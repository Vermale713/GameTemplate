local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerDataSquash = require(ReplicatedStorage.Data.Templates.PlayerDataSquash)
local Squash = require(ReplicatedStorage.Packages.Squash)

-- Function Alias
local T = Squash.T

local None = "__none"

-- Schema
local UsersSerdes = Squash.record({
	type = T(Squash.string()),
	data = T(Squash.map(Squash.string(), Squash.opt(PlayerDataSquash))),
})

local Utility = {}

local PacketSerdes = Squash.array(UsersSerdes)

local function isNone(value): boolean
	return typeof(value) == "table" and value.__none == None
end

local function normalize<T>(value: T): T
	if isNone(value) then
		return nil
	end
	if typeof(value) == "table" then
		local out = {}
		for k, v in pairs(value) do
			out[k] = normalize(v)
		end
		return out
	end
	return value
end

local function denormalize<T>(value: T): T
	if value == nil then
		return { __none = None }
	end
	if typeof(value) == "table" then
		local out = {}
		for k, v in pairs(value) do
			out[k] = denormalize(v)
		end
		return out
	end
	return value
end

function Utility.Serialize<T>(packet: T)
	local cursor = Squash.cursor()
	PacketSerdes.ser(cursor, normalize(packet))
	return Squash.tobuffer(cursor)
end

function Utility.Deserialize(buf: buffer): unknown
	local cursor = Squash.frombuffer(buf)
	local result = PacketSerdes.des(cursor)
	return denormalize(result)
end

return Utility
