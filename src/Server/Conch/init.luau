local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local User = require(ServerScriptService.User)
local Conch = require(ReplicatedStorage.Packages.Conch)
local Loader = require(ReplicatedStorage.Utility.Loader)

local ConchService = {}
Loader.Register("Conch", {
	Module = ConchService,
	Dependencies = {
		"User",
	},
})

function ConchService.OnInit()
	Conch.initiate_default_lifecycle()
	User.Signals.UserAdded:Connect(function(user)
		local player = user.Player
		local permission = user.Permissions

		local conchUser = Conch.get_user(player)
		Conch.give_roles(conchUser, permission)
	end)
end

function ConchService.OnStart()
	for _, command in ServerScriptService.Conch.Commands:GetChildren() do
		if not command:IsA("ModuleScript") then
			continue
		end
		(require)(command)
	end

	Conch.set_role_permissions("guest", "permission-check")
end

return ConchService
