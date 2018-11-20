local Model = script.Parent.Parent.Parent.Model
local Immutable = Model.Immutable
local List = require(Immutable.List)

local CardModel = require(Model.CardModel)
local StackModel = require(Model.StackModel)
local DrawnPileModel = require(Model.DrawnPileModel)
local PileModel = require(Model.PileModel)

local function getCards()
	local cards = {}

	for suit = 1, 4 do
		for value = 1, 13 do
			table.insert(cards, CardModel.new(value, suit))
		end
	end

	return cards
end

local function createStacks(deck, n)
	local stacks = {}
	local newDeck = deck

	for i = 1, (n or 7) do
		local stack = StackModel.new({})

		for j = 1, i do
			local card
			card, newDeck = deck:shift()

			stack = stack:push(card:setVisibility(j == i))
			deck = newDeck
		end

		table.insert(stacks, stack)
	end

	return List.new(stacks), newDeck
end

local function createPiles()
	local piles = List.new()

	for _ = 1, 4 do
		piles = piles:push(PileModel.new())
	end

	return piles
end

return function()
	local deck = List.new(getCards()):shuffle()
	local stacks
	stacks, deck = createStacks(deck)

	return {
		deck = deck,
		stacks = stacks,
		drawnPile = DrawnPileModel.new(),
		piles = createPiles(),
	}
end
