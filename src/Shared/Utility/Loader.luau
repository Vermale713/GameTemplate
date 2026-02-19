local Loader = {}

function Loader.LoadDirectory(dir: Instance, descendants: boolean?)
	descendants = descendants or false

	local dirDescendants = if descendants then dir:GetDescendants() else dir:GetChildren()

	for _, descendant in dirDescendants do
		if descendant:IsA("ModuleScript") then
			-- Wrap it so it doesn't show an error
			(require)(descendant)
		end
	end
end

return Loader
