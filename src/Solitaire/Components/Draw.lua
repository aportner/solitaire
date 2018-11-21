local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)

local DrawnPile = require(script.Parent.DrawnPile)
local DrawPile = require(script.Parent.DrawPile)

local Draw = Roact.Component:extend("Draw")
local HORIZONTAL_PADDING = 10
local NAME_PADDING = 30

function Draw:render()
	local actions = self.props.actions
	local selectedCard = self.props.selectedCard
    local deck = self.props.deck
    local drawnPile = self.props.drawnPile
    local state = self.props.state

	return Roact.createElement("Frame",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(
				0,
				Card.WIDTH,
				0,
				Card.HEIGHT
			),
			Position = UDim2.new(
				1,
				-(2 * Card.WIDTH + HORIZONTAL_PADDING),
				0,
				NAME_PADDING
			),
        },
        {
            DrawPile = Roact.createElement(
                DrawPile,
                {
                    xOffset = HORIZONTAL_PADDING + Card.WIDTH,
                    deck = deck,
                    onClick = actions.onDrawCard
                }
            ),
            DrawnPile = Roact.createElement(
                DrawnPile,
                {
                    actions = actions,
                    deck = drawnPile,
                    selectedCard = selectedCard,
                    xOffset = 0,
                    state = state,
                }
            )
        }
	)
end

return Draw

