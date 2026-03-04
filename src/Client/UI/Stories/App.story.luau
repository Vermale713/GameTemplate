local ReplicatedStorage = game:GetService("ReplicatedStorage")

local App = require(ReplicatedStorage.Client.UI.App)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)
local Vide = require(ReplicatedStorage.Packages.Vide)

local story = UiLabs.CreateVideStory({
	vide = Vide,
}, function()
	return App()
end)

return story
