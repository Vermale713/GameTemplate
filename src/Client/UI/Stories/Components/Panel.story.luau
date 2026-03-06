local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Panel = require(ReplicatedStorage.Client.UI.Components.Shared.Panel)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local panel
	Fluid.mount(function()
		panel = Panel({
			Size = UDim2.fromOffset(200, 50),
		})
		return { panel }
	end, props.target)

	return function()
		if panel then
			panel:Destroy()
		end
	end
end)

return story
