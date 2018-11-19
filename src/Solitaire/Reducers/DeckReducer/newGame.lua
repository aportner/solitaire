local Model = script.Parent.Parent.Parent.Model
local CardModel = require(Model.CardModel)
local DeckModel = require(Model.DeckModel)

function createStacks(deck, n)
	local stacks = {}
	
	for i = 1, (n or 7) do
		local stack = DeckModel.new({})
		
		for j = 1, i do
			local card, newDeck = deck:draw()
			
			stack = stack:add(card:setVisibility(j == i))
			deck = newDeck
		end
		
		table.insert(stacks, stack)
	end
	
	return stacks, newDeck
end

return function()
	local deck = DeckModel.new():shuffle()
	local stacks
	stacks, deck = createStacks(deck)
	
	return {
		deck = deck,
		stacks = stacks,
	}
end
