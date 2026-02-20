local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Conch = require(ReplicatedStorage.Packages.Conch)
local ConchUI = require(ReplicatedStorage.Packages.ConchUI)
local Loader = require(ReplicatedStorage.Utility.Loader)

local ConchController = {}
Loader.Register("Conch", {
	Module = ConchController,
	Dependencies = {},
})

function ConchController.OnInit()
	Conch.initiate_default_lifecycle()
	ConchUI.bind_to(Enum.KeyCode.F4)
end

return ConchController
