local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)
local map = require(script.Parent.Parent.Utils.map)

local Stack = Roact.Component:extend("Card")
local VERTICAL_PADDING = 24
local HORIZONTAL_PADDING = 10

function Stack:render()
	local onCardClick = self.props.onCardClick
	local deck = self.props.Deck
	local length = deck:length()

	return Roact.createElement("Frame",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(
				0,
				Card.WIDTH,
				0,
				Card.HEIGHT + (length - 1) * VERTICAL_PADDING
			),
			Position = UDim2.new(
				0,
				(self.props.Index - 1) * (Card.WIDTH + HORIZONTAL_PADDING),
				0,
				0
			),
		},
		map(
			deck.cards,
			function(index, card)
				return Roact.createElement(
					"Frame",
					{
						Size = UDim2.new(0, Card.WIDTH, 0, Card.HEIGHT),
						Position = UDim2.new(0, 0, 0, (index - 1) * VERTICAL_PADDING),
					},
					{
						Card = Roact.createElement(
							Card,
							{
								Card = card,
								onCardClick = onCardClick,
							}
						)
					}
				)	
			end
		)
	)
end

return Stack

