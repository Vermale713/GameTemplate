local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Label = require(ReplicatedStorage.Client.UI.Components.Shared.Label)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local label
	Fluid.mount(function()
		label = Label({
			Size = UDim2.fromOffset(200, 50),
			Text = "Hello foo",
		})
		return { label }
	end, props.target)

	return function()
		if label then
			label:Destroy()
		end
	end
end)

return story
