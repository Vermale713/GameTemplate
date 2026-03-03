local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)

-- Function Alias
local create = Vide.create

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
