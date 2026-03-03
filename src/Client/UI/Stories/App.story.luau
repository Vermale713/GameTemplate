local ReplicatedStorage = game:GetService("ReplicatedStorage")

local App = require(ReplicatedStorage.Client.UI.App)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local app = App()
	Fluid.bind(props.target, { app })

	props.subscribe(function(values)
		print("controls changed", values)
	end)

	return function()
		app:Destroy()
	end
end)

return story
