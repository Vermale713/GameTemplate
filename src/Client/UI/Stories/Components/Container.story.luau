local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Container = require(ReplicatedStorage.Client.UI.Components.Shared.Container)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local container
	Fluid.mount(function()
		container = Container({
			Size = UDim2.fromOffset(200, 50),
		})
		return { container }
	end, props.target)

	return function()
		if container then
			container:Destroy()
		end
	end
end)

return story
