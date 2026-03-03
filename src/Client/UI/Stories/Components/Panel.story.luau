local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Panel = require(ReplicatedStorage.Client.UI.Components.Shared.Panel)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)
local Vide = require(ReplicatedStorage.Packages.Vide)

local story = UiLabs.CreateVideStory({
	vide = Vide,
}, function()
	return Panel({
		Size = UDim2.fromOffset(200, 200),
	})
end)

return story
