local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Conch = require(ReplicatedStorage.Packages.Conch)

return Conch.register("permission", {
	description = "Check a player's permission level",
	permissions = { "permission-check" },
	arguments = function()
		return Conch.args.player()
	end,
	callback = function(player: Player)
		local user = Conch.get_user(player)
		Conch.log("info", user.roles[1])
	end,
})
