local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Squash = require(ReplicatedStorage.Packages.Squash)

-- Function Alias
local T = Squash.T

local UserDataSchema = Squash.record({
	Coins = T(Squash.opt(Squash.u32())),
	Metadata = T(Squash.opt(Squash.record({
		JoinData = T(Squash.opt(Squash.u32())),
		LastSeen = T(Squash.opt(Squash.u32())),
		TotalPlaytime = T(Squash.opt(Squash.u32())),
	}))),
})

return UserDataSchema
