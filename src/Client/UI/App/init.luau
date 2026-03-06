local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)

-- Function Alias
local create = Fluid.create

local function app()
	return create("Frame")({
		Name = "",

		create("TextButton")({
			Size = UDim2.fromOffset(200, 50),
			Activated = function()
				print("hello")
			end,
		}),
	})
end

return app
