local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)
local App = require(script.App)
local Loader = require(ReplicatedStorage.Utility.Loader)

-- Function Alias
local mount = Fluid.mount
local create = Fluid.create

local UiController = {}
Loader.Register("UI", {
	Module = UiController,
	Dependencies = {},
})

function UiController.OnStart()
	mount(function()
		return {
			create("ScreenGui")({
				Name = "GameUi",
				ResetOnSpawn = false,
				IgnoreGuiInset = true,

				App(),
				-- Link style sheets here if you have em
			}),
		}
	end, Players.LocalPlayer.PlayerGui)
end

return UiController
