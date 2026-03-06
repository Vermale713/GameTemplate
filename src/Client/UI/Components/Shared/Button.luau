local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)

-- Function Alias
local create = Fluid.create

type UsedAs<T> = Fluid.UsedAs<T>

type ButtonProps = {
	-- Identity
	Name: UsedAs<string>?,

	-- Layout
	Order: UsedAs<number>?,
	ZIndex: UsedAs<number>?,
	Anchor: UsedAs<Vector2>?,
	Position: UsedAs<UDim2>?,
	Size: UsedAs<UDim2>,

	-- Behaviour
	Visible: UsedAs<boolean>?,
	Active: UsedAs<boolean>?,
	Interactable: UsedAs<boolean>?,

	-- Events
	OnClick: ((InputObject, number) -> ())?,

	-- Children
	[number]: any?,
}

local function button(props: ButtonProps)
	return create("TextButton")({
		Name = props.Name or "Button",

		-- Defaults
		BackgroundTransparency = 1,
		Text = "",

		-- Layout
		LayoutOrder = props.Order,
		ZIndex = props.ZIndex,
		AnchorPoint = props.Anchor,
		Position = props.Position,
		Size = props.Size,

		-- Behaviour
		Visible = props.Visible,
		Active = props.Active,
		Interactable = props.Interactable,

		-- Click Event
		Activated = props.OnClick,

		-- Children
		table.unpack(props),
	})
end

return button
