
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)
local CardModel = require(script.Parent.Parent.Model.CardModel)

local DrawPile = Roact.Component:extend("DrawPile")

function DrawPile:render()
    local xOffset = self.props.xOffset
    local deck = self.props.deck
    local onClick = self.props.onClick
    local card

    if deck:length() > 0 then
        card = deck:first():setVisibility(false)
    else
        card = CardModel.new(11, 5)
    end

    local size = UDim2.new(
        0,
        Card.WIDTH,
        0,
        Card.HEIGHT
    )

	return Roact.createElement("Frame",
		{
			BackgroundTransparency = 1,
			Size = size,
			Position = UDim2.new(
				0,
				xOffset,
				0,
				0
			),
        },
        {
            Card = Roact.createElement(
                Card,
                {
                    card = card,
                }
            ),
			Mask = Roact.createElement(
				"TextButton",
				{
					Size = size,
					BackgroundTransparency = 1,
                    TextTransparency = 1,
                    ZIndex = 2,
					[Roact.Event.Activated] = onClick,
				}
			)
        }
	)
end

return DrawPile