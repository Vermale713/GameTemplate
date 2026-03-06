local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)

-- Function Alias
local create = Fluid.create

type UsedAs<T> = Fluid.UsedAs<T>

type PanelProps = {
	-- Name
	Name: UsedAs<string>?,

	-- Layout
	Order: UsedAs<number>?,
	ZIndex: UsedAs<number>?,
	Anchor: UsedAs<Vector2>?,
	Position: UsedAs<UDim2>?,
	Size: UsedAs<UDim2>,

	-- Appearance
	BackgroundTransparency: UsedAs<number>?,
	BackgroundColor3: UsedAs<Color3>?,
	ClipsDescendants: UsedAs<boolean>?,

	-- Behaviour
	Visible: UsedAs<boolean>?,

	-- Children
	[number]: any?,
}

local function panel(props: PanelProps)
	return create("Frame")({
		Name = props.Name or "Panel",

		-- Layout
		LayoutOrder = props.Order,
		ZIndex = props.ZIndex,
		AnchorPoint = props.Anchor,
		Position = props.Position,
		Size = props.Size,

		-- Appearance
		BackgroundTransparency = props.BackgroundTransparency,
		BackgroundColor3 = props.BackgroundColor3,
		ClipsDescendants = props.ClipsDescendants,

		-- Behaviour
		Visible = props.Visible,

		-- Children
		table.unpack(props),
	})
end

return panel
