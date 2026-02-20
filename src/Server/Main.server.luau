local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Loader = require(ReplicatedStorage.Utility.Loader)

local startTime = os.clock()
Loader.LoadDirectory(ServerScriptService)
	:andThen(Loader.Start)
	:andThen(function()
		print(`Server loaded in {os.clock() - startTime}`)
	end)
	:catch(function(err)
		warn(`Server failed to load: {err}\n{debug.traceback()}`)
	end)
