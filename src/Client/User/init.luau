local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Data = require(ReplicatedStorage.Client.Store.Player.Data)
local BlinkClient = require(ReplicatedStorage.Network.BlinkClient)
local CharmSync = require(ReplicatedStorage.Packages.CharmSync)
local CharmSyncSerDes = require(ReplicatedStorage.Utility.CharmSyncSerDes)
local Loader = require(ReplicatedStorage.Utility.Loader)

local UserController = {}
Loader.Register("User", {
	Module = UserController,
	Dependencies = {},
})

function UserController.OnInit()
	CharmSync.client.addSignals({
		[`User-{Players.LocalPlayer.Name}`] = Data.SetData,
	})
	BlinkClient.User.Sync.On(function(payload)
		-- Sync patches sent by the server
		local patches = CharmSyncSerDes.Deserialize(payload)
		CharmSync.client.patch(patches :: any)
	end)
end

return UserController
