local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Loader = require(ReplicatedStorage.Utility.Loader)

local ConfigurationService = {}
Loader.Register("Config", {
	Module = ConfigurationService,
	Dependencies = {},
})

function ConfigurationService.OnStart()
	for _, config in ServerScriptService.Config:GetChildren() do
		if not config:IsA("ModuleScript") then
			continue
		end
		local module = (require)(config)
		local method = module["Load"]
		if method :: () -> () then
			method()
		end
	end
end

return ConfigurationService
