local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Button = require(ReplicatedStorage.Client.UI.Components.Shared.Button)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local button
	Fluid.mount(function()
		button = Button({
			Size = UDim2.fromOffset(200, 50),
			OnClick = function()
				print("hello")
			end,
		})
		return { button }
	end, props.target)

	return function()
		if button then
			button:Destroy()
		end
	end
end)

return story
