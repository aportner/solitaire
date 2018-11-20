local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)
local CardModel = require(script.Parent.Parent.Model.CardModel)

local DrawnPile = Roact.Component:extend("DrawnPile")

function DrawnPile:init()
	self.boundOnCardClick = function(card)
		self:onCardClick(card)
	end
end

function DrawnPile:onCardClick(card)
	local actions = self.props.actions

	local selectedCard = self.props.selectedCard

	if selectedCard ~= nil and card == selectedCard then
		actions.onDeselectCard(card)
	elseif selectedCard == nil and not card.visible then
		actions.onRevealCard(card)
	elseif selectedCard == nil then
		actions.onSelectCard(card)
	else
		actions.onMoveCard(selectedCard, card)
	end
end


function DrawnPile:render()
    local deck = self.props.deck
	local selectedCard = self.props.selectedCard
    local xOffset = self.props.xOffset

	local card
    if deck:length() > 0 then
        card = deck:last()
    else
        card = CardModel.new(13, 5)
    end

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
					onClick = self.boundOnCardClick,
					selectedCard = selectedCard,
                }
			),
        }
	)
end

return DrawnPile