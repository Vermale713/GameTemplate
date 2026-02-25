local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Admins = require(ServerScriptService.Config.Admins)
local Workspace = require(ReplicatedStorage.Data.Attributes.Workspace)
local PlayerData = require(ReplicatedStorage.Data.Templates.PlayerData)
local BlinkServer = require(ReplicatedStorage.Network.BlinkServer)
local Charm = require(ReplicatedStorage.Packages.Charm)
local CharmSync = require(ReplicatedStorage.Packages.CharmSync)
local ProfileStore = require(ServerScriptService.ServerPackages.ProfileStore)
local Data = require(ServerScriptService.Store.Player.Data)
local Signal = require(ReplicatedStorage.Packages.Signal)
local CharmSyncSerDes = require(ReplicatedStorage.Utility.CharmSyncSerDes)
local Immutable = require(ReplicatedStorage.Utility.Immutable)
local Loader = require(ReplicatedStorage.Utility.Loader)
local Queue = require(ReplicatedStorage.Utility.Queue)

type User = {
	Player: Player,
	Permissions: string,
	Profile: ProfileStore.Profile<PlayerData.PlayerData>,
}

-- I casted PlayerData to never otherwise i got a type error
local store: ProfileStore.ProfileStore<PlayerData.PlayerData>
if workspace:GetAttribute(Workspace.DevMode) and RunService:IsStudio() then
	-- Use a mock store
	store =
		ProfileStore.New("PlayerStore", PlayerData :: never).Mock :: ProfileStore.ProfileStore<PlayerData.PlayerData>
else
	-- Use a regular store
	store = ProfileStore.New("PlayerStore", PlayerData :: never) :: ProfileStore.ProfileStore<PlayerData.PlayerData>
end

local UserService = {
	Users = {} :: { [Player]: User },
	Signals = {
		UserAdded = Signal.new(),
	},
}
Loader.Register("User", {
	Module = UserService,
	Dependencies = {},
})
local pendingUpdates: { [Player]: boolean } = {}

local function flushPlayer(player: Player)
	local user = UserService.Users[player]
	if not user then
		return
	end

	local data = Immutable.CopyDeep(user.Profile.Data)
	Data.SetData(player.Name, data)
end

local function onPlayerAdded(player: Player)
	if UserService.Users[player] then
		return
	end

	local profile = store:StartSessionAsync(player.Name, {
		Cancel = function()
			return not player:IsDescendantOf(Players)
		end,
	})

	if profile == nil then
		player:Kick("Profile load fail - Please rejoin")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	local dcData = Immutable.FreezeDeep(profile.Data)
	Data.SetData(player.Name, dcData)

	local sessionStart = os.time()

	if profile.Data.Metadata.JoinDate == 0 then
		-- We can mutate like this cause this is before
		-- Initial replication
		profile.Data.Metadata.JoinDate = os.time()
	end

	profile.OnSessionEnd:Connect(function()
		UserService.Users[player] = nil
		player:Kick()
	end)
	profile.OnLastSave:Connect(function()
		-- No need to care if this gets replicated to the client
		profile.Data.Metadata.LastSeen = os.time()
		profile.Data.Metadata.TotalPlaytime += os.time() - sessionStart
	end)

	if player:IsDescendantOf(Players) then
		UserService.Users[player] = {
			Player = player,
			Permissions = Admins.GetPlayerPermissions(player),
			Profile = profile,
		}

		CharmSync.server.addSignalsToClient(player, {
			[`User-{player.Name}`] = Charm.computed(function()
				return Data.GetData(`{player.Name}`)
			end),
		})
	else
		profile:EndSession()
	end

	UserService.Signals.UserAdded:Fire(UserService.Users[player])
end

local function onPlayerRemoving(player: Player)
	local user = UserService.Users[player]
	if not user then
		return
	end

	CharmSync.server.removeClient(player)
	user.Profile:EndSession()
end

function UserService.UpdateUserData(player: Player, updater: (data: PlayerData.PlayerData) -> ())
	local user = UserService.Users[player]
	if not user then
		return
	end

	updater(user.Profile.Data)

	if not pendingUpdates[player] then
		pendingUpdates[player] = true
		Queue.Enqueue(function()
			pendingUpdates[player] = nil
			flushPlayer(player)
		end)
	end
end

function UserService.OnInit()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
	CharmSync.server.connect(function(player, patches)
		-- Fire to the client to apply new patches
		-- TODO: make this a buffer
		local payload = CharmSyncSerDes.Serialize(patches)
		BlinkServer.User.Sync.Fire(player, payload)
	end)
end

function UserService.OnStart()
	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return UserService
