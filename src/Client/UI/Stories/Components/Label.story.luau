local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Label = require(ReplicatedStorage.Client.UI.Components.Shared.Label)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)
local Vide = require(ReplicatedStorage.Packages.Vide)

local story = UiLabs.CreateVideStory({
	vide = Vide,
}, function()
	Label({
		Size = UDim2.fromOffset(200, 50),
	})
end)

return story
