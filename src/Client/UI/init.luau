local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local App = require(script.App)
local Loader = require(ReplicatedStorage.Utility.Loader)

-- Function Alias
local mount = Vide.mount
local create = Vide.create

local UiController = {}
Loader.Register("UI", {
	Module = UiController,
	Dependencies = {},
})

function UiController.OnStart()
	mount(function()
		return create("ScreenGui")({
			Name = "GameUi",
			ResetOnSpawn = false,
			IgnoreGuiInset = true,

			App(),
		})
	end, Players.LocalPlayer.PlayerGui)
end

return UiController
