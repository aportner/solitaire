local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Card = require(script.Parent.Card)

local Stack = Roact.Component:extend("Stack")
local VERTICAL_PADDING = 20
local HORIZONTAL_PADDING = 10

function Stack:init()
	self.boundOnCardClick = function(card)
		self:onClickCard(card)
	end

	self.boundOnStackClick = function()
		self:onClickCard(nil)
	end
end

function Stack:onClickCard(card)
	local actions = self.props.actions
	local deck = self.props.deck
	local selectedCard = self.props.selectedCard

	if selectedCard ~= nil and card ~= nil and card == selectedCard then
		actions.onDeselectCard(card)
	elseif selectedCard == nil and card ~= nil and not card.visible then
		actions.onRevealCard(card)
	elseif selectedCard == nil and card ~= nil then
		actions.onSelectCard(card)
	elseif selectedCard ~= nil then
		actions.onMoveCard(selectedCard, deck)
	end
end

function Stack:render()
	local selectedCard = self.props.selectedCard
	local deck = self.props.deck
	local length = deck:length()

	local children = deck:map(
		function(card, index)
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
							card = card,
							onClick = self.boundOnCardClick,
							selectedCard = selectedCard,
						}
					)
				}
			)
		end
	):toTable()
	children['Mask'] = Roact.createElement(
		"TextButton",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(0, Card.WIDTH, 0, Card.HEIGHT),
			TextTransparency = 1,
			ZIndex = -1,
			[Roact.Event.Activated] = self.boundOnStackClick,
		}
	)

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
				(self.props.index - 1) * (Card.WIDTH + HORIZONTAL_PADDING),
				0,
				0
			),
		},
		children
	)
end

return Stack

