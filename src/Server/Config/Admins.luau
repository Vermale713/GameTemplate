local ConfigService = game:GetService("ConfigService")

local ConfigKey = "Admins"

local Config = {
	Config = {} :: { number }, -- Admins Config is an array of player ids,
}

local function setupConfigSignals(config: ConfigSnapshot)
	config:GetValueChangedSignal(ConfigKey):Connect(function(newConfigValue)
		Config.Config = newConfigValue
	end)
end

function Config.Load()
	local config = ConfigService:GetConfigAsync()

	local configValue = config:GetValue(ConfigKey)
	Config.Config = configValue
	setupConfigSignals(config)
end

function Config.GetPlayerPermissions(player: Player)
	local permissionLevel = "guest"

	if table.find(Config.Config, player.UserId) then
		permissionLevel = "super-user"
	end

	return permissionLevel
end

return Config
