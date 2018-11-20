local CardModel = {}
CardModel.__index = CardModel

CardModel.VALUE_MAP = {
	[1] = 'Ace',
	[2] = 'Two',
	[3] = 'Three',
	[4] = 'Four',
	[5] = 'Five',
	[6] = 'Six',
	[7] = 'Seven',
	[8] = 'Eight',
	[9] = 'Nine',
	[10] = 'Ten',
	[11] = 'Jack',
	[12] = 'Queen',
	[13] = 'King',
}

CardModel.SUIT_MAP = {
	[1] = 'Spades',
	[2] = 'Hearts',
	[3] = 'Clubs',
	[4] = 'Diamonds',
	[5] = 'Backs',
	[6] = 'Backs',
}

function CardModel.new(value, suit, visible)
	if visible == nil then
		visible = true
	end

	local instance = {
		value = value,
		suit = suit,
		visible = visible,
	}

	setmetatable(instance, CardModel)
	return instance
end

function CardModel:__eq(card)
	return card ~= nil and
		card.__index == CardModel and
		self.value == card.value and
		self.suit == card.suit
end

function CardModel:setVisibility(visibility)
	return CardModel.new(self.value, self.suit, visibility)
end

function CardModel:toString()
	print(
		CardModel.VALUE_MAP[self.value]
			.. ' of '
			.. CardModel.SUIT_MAP[self.suit]
	)
end

return CardModel
