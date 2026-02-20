local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage.Packages.Promise)

type Config = {
	Module: unknown,
	Dependencies: { string },
}
type Singleton = {
	[string]: () -> (), -- This is necessary to satisfy the indexer type error
	OnInit: () -> (),
	OnStart: () -> (),
}

local SingletonLifecycles = {
	OnInit = "OnInit",
	OnStart = "OnStart",
}

local Loader = {}

local singletons = {}
local sortedSingletons: {}

local function sort(registry: { [string]: Config })
	local graph: { [string]: { string } } = {}
	local inDegree: { [string]: number } = {}

	for name in registry do
		graph[name] = {}
		inDegree[name] = inDegree[name] or 0
	end

	for name, config in registry do
		for _, dep in config.Dependencies do
			assert(registry[dep], `[Loader] "{name}" depends on "{dep}" which is not registered`)
			graph[dep] = graph[dep] or {}
			table.insert(graph[dep], name)
			inDegree[name] += 1
		end
	end

	local queue: { string } = {}
	for name, degree in inDegree do
		if degree == 0 then
			table.insert(queue, name)
		end
	end

	local sorted = {}
	while #queue > 0 do
		local current = table.remove(queue, 1) :: string
		table.insert(sorted, registry[current].Module)

		for _, dependant in graph[current] do
			inDegree[dependant] -= 1
			if inDegree[dependant] == 0 then
				table.insert(queue, dependant)
			end
		end
	end

	local registrySize = 0
	for _ in registry do
		registrySize += 1
	end

	if #sorted ~= registrySize then
		local loaded = {}
		for _, module in sorted do
			loaded[module] = true
		end

		local culprits: { string } = {}
		for name, config in registry do
			if not loaded[config.Module] then
				table.insert(culprits, name)
			end
		end
		error("[Loader] Circular dependency among: " .. table.concat(culprits, ", "))
	end

	return sorted
end

function Loader.Register(name: string, config: Config)
	singletons[name] = config
end

function Loader.LoadDirectory(dir: Instance, descendants: boolean?)
	return Promise.new(function(resolve)
		descendants = descendants or false

		local dirDescendants = if descendants then dir:GetDescendants() else dir:GetChildren()

		for _, descendant in dirDescendants do
			if descendant:IsA("ModuleScript") then
				-- Wrap it so it doesn't show an error
				(require)(descendant)
			end
		end

		resolve()
	end)
end

function Loader.Start()
	return Promise.new(function(resolve)
		sortedSingletons = sort(singletons)

		-- Initialize modules
		for _, module: Singleton in sortedSingletons :: { Singleton } do
			local method: () -> () = module[SingletonLifecycles.OnInit]
			if method then
				method()
			end
		end

		-- Start modules
		for _, module: Singleton in sortedSingletons :: { Singleton } do
			task.spawn(function()
				local method: () -> () = module[SingletonLifecycles.OnStart]
				if method then
					method()
				end
			end)
		end

		resolve()
	end)
end

return Loader
