local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Admins = require(ServerScriptService.Config.Admins)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Loader = require(ReplicatedStorage.Utility.Loader)

local UserService = {
	Users = {},
	Signals = {
		UserAdded = Signal.new(),
		UserRemoving = Signal.new(),
	},
}
Loader.Register("User", {
	Module = UserService,
	Dependencies = { "Config" },
})

local function onPlayerAdded(player: Player)
	if UserService.Users[player] then
		return
	end

	UserService.Users[player] = {
		Player = player,
		Permissions = Admins.GetPlayerPermissions(player),
	}

	UserService.Signals.UserAdded:Fire(UserService.Users[player])
end

local function onPlayerRemoving(player: Player)
	local user = UserService.Users[player]
	if user then
		UserService.Users[player] = nil
		UserService.Signals.UserRemoving:Fire(user)
	end
end

function UserService.OnInit()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
end

function UserService.OnStart()
	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return UserService
