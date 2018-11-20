local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

local PATH = 'rbxasset://textures/solitaire.png'

local Card = Roact.Component:extend("Card")

Card.WIDTH = 71
Card.HEIGHT = 96

function Card:init()
	self.boundOnClick = function()
		self.props.onClick(self.props.card)
	end
end

function Card:render()
	local card = self.props.card
	local selectedCard = self.props.selectedCard
	local isSelected = self.props.isSelected or card == selectedCard

	local imageColor3 = Color3.new(1, 1, 1)
	if isSelected then
		imageColor3 = Color3.new(0.3, 1, 0.3)
	end

	local xOffset = (card.value - 1) * Card.WIDTH
	local yOffset = (card.suit - 1) * Card.HEIGHT

	if not card.visible then
		xOffset = 2 * Card.WIDTH
		yOffset = 4 * Card.HEIGHT
	end

	return Roact.createElement(
		"ImageButton",
		{
			BackgroundTransparency = 1,
			Image = PATH,
			ImageColor3 = imageColor3,
			ImageRectOffset = Vector2.new(xOffset, yOffset),
			ImageRectSize = Vector2.new(Card.WIDTH, Card.HEIGHT),
			Selected = isSelected,
			Size = UDim2.new(0, Card.WIDTH, 0, Card.HEIGHT),
			[Roact.Event.Activated] = self.boundOnClick,
		}
	)
end

return Card

