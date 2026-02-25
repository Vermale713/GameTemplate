local Utility = {}

local tasks = {}
local scheduled: thread?

function Utility.Enqueue(taskToEnqueue: (...any) -> any)
	table.insert(tasks, taskToEnqueue)

	if not scheduled then
		scheduled = task.defer(function()
			local snapshot = tasks
			tasks = {}
			scheduled = nil

			for _, callback in snapshot do
				callback()
			end
		end)
	end
end

return Utility
