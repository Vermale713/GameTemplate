local ReplicatedStorage = game:GetService("ReplicatedStorage")

local App = require(ReplicatedStorage.Client.UI.App)
local Fluid = require(ReplicatedStorage.Packages.Fluid)
local UiLabs = require(ReplicatedStorage.Packages.UiLabs)

local story = UiLabs.CreateGenericStory({}, function(props)
	local app
	Fluid.mount(function()
		app = App()
		return { app }
	end, props.target)

	return function()
		if app then
			app:Destroy()
		end
	end
end)

return story
