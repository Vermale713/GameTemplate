local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)

-- Function Alias
local create = Vide.create

type UsedAs<T> = Vide.Source<T> | T

type Satisfier<T> = LabelProps & T

type TextLabelProps = {
	-- Text
	Text: UsedAs<string>?,
	TextColor: UsedAs<Color3>?,
	TextSize: UsedAs<number>?,
	XAlignment: UsedAs<Enum.TextXAlignment>?,
	YAlignment: UsedAs<Enum.TextYAlignment>?,
	Font: UsedAs<Font>?,
	RichText: UsedAs<boolean>?,
}

type ImageLabelProps = {
	-- Image
	Image: UsedAs<string>?,
	ImageColor3: UsedAs<Color3>?,
	ImageTransparency: UsedAs<number>?,
	ScaleType: UsedAs<Enum.ScaleType>?,
	SliceCenter: UsedAs<Rect>?,
}

type LabelProps = {
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
	[number]: Instance,
}
-- & TextLabelProps & ImageLabelProps
local function imageLabel(props: LabelProps & ImageLabelProps)
	return create("ImageLabel")({
		Name = props.Name or "Label",

		-- Label Exclusive
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

local function textLabel(props: LabelProps & TextLabelProps)
	return create("TextLabel")({
		Name = props.Name or "Label",

		-- Label Exclusive
		Text = props.Text,
		TextColor3 = props.TextColor,
		TextSize = props.TextSize,
		TextScaled = if props.TextSize then false else true,
		TextXAlignment = props.XAlignment,
		TextYAlignment = props.YAlignment,
		RichText = props.RichText,
		FontFace = props.Font, -- can keep it like this or default it to a font

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

local function label(props: LabelProps)
	local isTextLabel = (props :: TextLabelProps).Text
	return if isTextLabel
		then textLabel(props :: Satisfier<TextLabelProps>)
		else imageLabel(props :: Satisfier<ImageLabelProps>)
end

return label
