local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)
local GameLogic = require(script.Parent.Parent.GameLogic)
local CardModel = require(script.Parent.Parent.Model.CardModel)

local DrawnPile = Roact.Component:extend("DrawnPile")

function DrawnPile:init()
	self.boundOnCardClick = function(card)
		self:onCardClick(card)
	end

	self.lastClick = 0
end

function DrawnPile:onCardClick(card)
	local now = tick()
	local isDoubleClick = now - self.lastClick < 0.8
	self.lastClick = now

	local actions = self.props.actions
    local deck = self.props.deck
	local selectedCard = self.props.selectedCard

	if isDoubleClick then
		self.lastClick = 0

		if card ~= nil and not card:isBack() then
			local stack = GameLogic.findBestMove(self.props.state, card)

			if stack ~= nil then
				actions.onMoveCard(card, stack)
			elseif selectedCard == card then
				actions.onDeselectCard(card)
			end
		end
	elseif selectedCard ~= nil and card == selectedCard then
		actions.onDeselectCard(card)
	elseif selectedCard == nil and not card.visible then
		actions.onRevealCard(card)
	elseif selectedCard == nil and not card:isBack() then
		actions.onSelectCard(card)
	elseif selectedCard ~= nil then
		actions.onMoveCard(selectedCard, deck)
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