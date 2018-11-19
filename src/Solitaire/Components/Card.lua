local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local PATH = 'rbxasset://textures/solitaire.png'

local Card = Roact.Component:extend("Card")

Card.WIDTH = 71
Card.HEIGHT = 96

function Card:init()
	self.onCardClick = function()
		self.props.onCardClick(self.props.Card)
	end
end

function Card:render()
	local card = self.props.Card
	local onCardClick = self.props.onCardClick
	
	local xOffset = (self.props.Card.value - 1) * Card.WIDTH
	local yOffset = (self.props.Card.suit - 1) * Card.HEIGHT
	
	if not self.props.Card.visible then
		xOffset = 2 * Card.WIDTH
		yOffset = 4 * Card.HEIGHT
	end
	
	return Roact.createElement(
		"ImageButton",
		{
			BackgroundTransparency = 1,
			Image = PATH,
			ImageRectOffset = Vector2.new(xOffset, yOffset),
			ImageRectSize = Vector2.new(Card.WIDTH, Card.HEIGHT),
			Size = UDim2.new(0, Card.WIDTH, 0, Card.HEIGHT),
			[Roact.Event.Activated] = self.onCardClick,
		}
	)
end

return Card

