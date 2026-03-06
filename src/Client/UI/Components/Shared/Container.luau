local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)

-- Function Alias
local create = Fluid.create

type UsedAs<T> = Fluid.Source<T> | T

type ContainerProps = {
	-- Name
	Name: UsedAs<string>?,

	-- Layout
	Order: UsedAs<number>?,
	ZIndex: UsedAs<number>?,
	Anchor: UsedAs<Vector2>?,
	Position: UsedAs<UDim2>?,
	Size: UsedAs<UDim2>,

	-- Behaviour
	Visible: UsedAs<boolean>?,

	-- Children
	[number]: any?,
}

local function container(props: ContainerProps)
	return create("Frame")({
		Name = props.Name or "Container",

		-- Defaults
		BackgroundTransparency = 1,

		-- Layout
		LayoutOrder = props.Order,
		ZIndex = props.ZIndex,
		AnchorPoint = props.Anchor,
		Position = props.Position,
		Size = props.Size,

		-- Behaviour
		Visible = props.Visible,

		-- Children
		table.unpack(props),
	})
end

return container
