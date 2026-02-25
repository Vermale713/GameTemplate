local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerData = require(ReplicatedStorage.Data.Templates.PlayerData)
local Charm = require(ReplicatedStorage.Packages.Charm)
local Immutable = require(ReplicatedStorage.Utility.Immutable)

type DataContainer = { [string]: PlayerData.PlayerData }

local Store = {}

local GetData, SetData = Charm.signal({} :: DataContainer)
Store.GetDatas, Store.SetDatas = GetData, SetData

function Store.GetData(id: string)
	return GetData()[id]
end

function Store.SetData(id: string, data: PlayerData.PlayerData)
	SetData(function(state: DataContainer)
		return Immutable.Set(state, id, data)
	end)
end

return Store
