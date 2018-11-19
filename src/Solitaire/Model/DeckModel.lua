local CardModel = require(script.Parent.CardModel)

local DeckModel = {}
DeckModel.__index = DeckModel

local function getCards()
	local cards = {}

	for suit = 1, 4 do
		for value = 1, 13 do
			table.insert(cards, CardModel.new(value, suit))
		end
	end

	return cards
end

local function shuffle(cards)
	local shuffled = {}

	for index, card in ipairs(cards) do
		table.insert(shuffled, math.random(index), card)
	end

	return shuffled
end

local function slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

function DeckModel.new(cards)
	local instance = {
		cards = cards or getCards(),
	}

	setmetatable(instance, DeckModel)
	return instance
end

function DeckModel:shuffle()
	return DeckModel.new(shuffle(self.cards))
end

function DeckModel:add(card)
	local cards = slice(self.cards)
	table.insert(cards, card)

	return DeckModel.new(cards)
end

function DeckModel:addCards(cardsToAdd)
	local cards = slice(self.cards)

	for _, card in ipairs(cardsToAdd) do
		table.insert(cards, card)
	end

	return DeckModel.new(cards)
end

function DeckModel:draw()
	local card = self.cards[1]
	local cards = slice(self.cards, 2)

	return card, DeckModel.new(cards)
end

function DeckModel:first()
	return self.cards[1]
end

function DeckModel:get(index)
	return self.cards[index]
end

function DeckModel:hasCard(card)
	return self:indexOf(card) > 0
end

function DeckModel:indexOf(card)
	for index, value in ipairs(self.cards) do
		if value:equals(card) then
			return index
		end
	end

	return 0
end

function DeckModel:length()
	return #self.cards
end

function DeckModel:last()
	return self.cards[#self.cards]
end

function DeckModel:reveal(index)
	local cards = slice(self.cards)
	local card = cards[index]

	cards[index] = card:setVisibility(true)

	return DeckModel.new(cards)
end

function DeckModel:revealCard(card)
	return self:reveal(self:indexOf(card))
end

function DeckModel:slice(point)
	local cardsBefore = {}
	local cardsAfter = {}

	for index, card in ipairs(self.cards) do
		if index < point then
			table.insert(cardsBefore, card)
		else
			table.insert(cardsAfter, card)
		end
	end

	return cardsAfter, DeckModel.new(cardsBefore)
end

return DeckModel
