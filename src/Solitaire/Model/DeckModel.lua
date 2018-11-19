local CardModel = require(script.Parent.CardModel)

local DeckModel = {}
DeckModel.__index = DeckModel

function getCards()
	local cards = {}
	
	for suit = 1, 4 do
		for value = 1, 13 do
			table.insert(cards, CardModel.new(value, suit))
		end
	end
	
	return cards
end

function shuffle(cards)
	local shuffled = {}
	
	for index, card in ipairs(cards) do
		table.insert(shuffled, math.random(index), card)
	end
	
	return shuffled
end

function slice(tbl, first, last, step)
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

function DeckModel:draw()
	local card = self.cards[1]
	local cards = slice(self.cards, 2)
	
	return card, DeckModel.new(cards)
end

function DeckModel:first()
	return self.cards[1]
end

function DeckModel:length()
	return #self.cards
end

function DeckModel:last()
	return self.cards[#self.cards]
end

return DeckModel
