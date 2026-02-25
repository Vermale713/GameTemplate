local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerData = require(ReplicatedStorage.Data.Templates.PlayerData)
local Charm = require(ReplicatedStorage.Packages.Charm)

local Store = {}

local GetData, SetData = Charm.signal(PlayerData :: PlayerData.PlayerData)
Store.GetData, Store.SetData = GetData, SetData

return Store
