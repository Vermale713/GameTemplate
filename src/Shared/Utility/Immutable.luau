local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GlobalTypes = require(ReplicatedStorage.Types.GlobalTypes)

local AssertMessage = "Input must be a table"

local Utility = {}

function Utility.Copy<T>(input: T): T
	assert(typeof(input) == "table", AssertMessage)
	return table.clone(input)
end

function Utility.CopyDeep<T>(input: T): T
	assert(typeof(input) == "table", AssertMessage)
	local new: { [any]: any } = Utility.Copy(input)

	for key, value in pairs(input) do
		if typeof(value) == "table" then
			new[key] = Utility.CopyDeep(value)
		end
	end

	return new
end

function Utility.Freeze<T>(input: T): T
	assert(typeof(input) == "table", AssertMessage)
	local new = Utility.Copy(input)

	table.freeze(new :: GlobalTypes.AnyDictionary)

	return new
end

function Utility.FreezeDeep<T>(input: T): T
	assert(typeof(input) == "table", AssertMessage)
	local new: { [any]: any } = Utility.Copy(input)

	for key, value in pairs(input) do
		if typeof(value) == "table" then
			new[key] = Utility.FreezeDeep(value)
		end
	end

	table.freeze(new :: GlobalTypes.AnyDictionary)

	return new
end

function Utility.Set<T, K>(object: T & {}, key: K & keyof<T>, value: index<T, K>): T
	if object[key] ~= value then
		object = table.clone(object)
		object[key] = value
	end
	return object
end

return Utility
