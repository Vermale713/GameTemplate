local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Loader = require(ReplicatedStorage.Utility.Loader)

local startTime = os.clock()
Loader.LoadDirectory(ReplicatedStorage.Client)
	:andThen(Loader.Start)
	:andThen(function()
		print(`Client loaded in {os.clock() - startTime}`)
	end)
	:catch(function(err)
		warn(`Client failed to load: {err}\n{debug.traceback()}`)
	end)
