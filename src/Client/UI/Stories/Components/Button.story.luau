local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Button = require(ReplicatedStorage.Client.UI.Components.Shared.Button)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)
local Vide = require(ReplicatedStorage.Packages.Vide)

local story = UiLabs.CreateVideStory({
	vide = Vide,
}, function()
	return Button({
		Anchor = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(200, 50),

		OnClick = function()
			print("helo")
		end,
	})
end)

return story
