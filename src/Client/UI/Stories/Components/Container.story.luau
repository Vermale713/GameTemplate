local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Container = require(ReplicatedStorage.Client.UI.Components.Shared.Container)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)
local Vide = require(ReplicatedStorage.Packages.Vide)

local story = UiLabs.CreateVideStory({
	vide = Vide,
}, function()
	return Container({
		Size = UDim2.fromOffset(200, 200),
	})
end)

return story
