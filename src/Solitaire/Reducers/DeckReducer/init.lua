local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local newGame = require(script.newGame)
local cloneTable = require(script.Parent.Parent.Utils.cloneTable)

local function getStackIndexFromCard(card, stacks)
	for index, value in ipairs(stacks) do
		if value:hasCard(card) then
			return index
		end
	end

	return 0
end

return Rodux.createReducer(
	newGame(),
	{
		MoveCard = function(state, action)
			local newState = cloneTable(state)
			local fromCard = action.fromCard
			local toCard = action.toCard

			local fromCardStackIndex = getStackIndexFromCard(fromCard, state.stacks)
			local toCardStackIndex = getStackIndexFromCard(toCard, state.stacks)
			local fromCardStack = state.stacks[fromCardStackIndex]
			local toCardStack = state.stacks[toCardStackIndex]
			toCard = toCardStack:get(toCardStack:length())

			local isFromCardRed = fromCard.suit % 2
			local isToCardRed = toCard.suit % 2

			if not toCard.visible or isFromCardRed == isToCardRed
				or toCard.value - fromCard.value ~= 1 then
				newState.selectedCard = nil
				return newState
			end

			newState.stacks = cloneTable(state.stacks)

			local cards
			cards, newState.stacks[fromCardStackIndex] = fromCardStack:slice(
				fromCardStack:indexOf(fromCard)
			)
			newState.stacks[toCardStackIndex] = toCardStack:addCards(cards)
			newState.selectedCard = nil

			return newState
		end,

		NewGame = function()
			return newGame()
		end,

		RevealCard = function(state, action)
			local card = action.card
			if card.visible then
				return state
			end

			local newState = cloneTable(state)
			newState.stacks = cloneTable(newState.stacks)

			local stackIndex = getStackIndexFromCard(card, newState.stacks)
			local stack = newState.stacks[stackIndex]
			local cardIndex = stack:indexOf(card)

			if cardIndex < stack:length() then
				return state
			end

			newState.stacks[stackIndex] = stack:revealCard(card)

			return newState
		end,

		SelectCard = function(state, action)
			local newState = cloneTable(state)

			newState.selectedCard = action.card

			return newState
		end,

		DeselectCard = function(state)
			local newState = cloneTable(state)

			newState.selectedCard = nil

			return newState
		end,
	}
)
