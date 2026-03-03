local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local storybook: UiLabs.Storybook = {
	name = "Game Ui",
	storyRoots = {
		ReplicatedStorage.Client.UI,
	},
}

return storybook
