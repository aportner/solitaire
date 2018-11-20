local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local GameLogic = require(script.Parent.Parent.GameLogic)

local Model = script.Parent.Parent.Model
local Immutable = Model.Immutable
local List = require(Immutable.List)

local newGame = require(script.newGame)
local cloneTable = require(script.Parent.Parent.Utils.cloneTable)

return Rodux.createReducer(
	newGame(),
	{
		DrawCard = function(state)
			local deck = state.deck
			local drawnDeck = state.drawnDeck

			local newState = cloneTable(state)

			if deck:length() == 0 then
				newState.deck = drawnDeck
				newState.drawnDeck = List.new({})
			else
				local card
				card, newState.deck = deck:shift()
				newState.drawnDeck = drawnDeck:push(card)
			end

			return newState
		end,

		MoveCard = function(state, action)
			local newState = cloneTable(state)
			newState.selectedCard = nil

			local fromCard = action.fromCard
			local toCard = action.toCard

			-- local fromCardStack = GameLogic.getListForCard(state, fromCard)
			local toCardStack = GameLogic.getListForCard(state, toCard)

			if toCardStack == nil or not toCardStack:canMove(fromCard) then
				return newState
			end

			--[[
			if toCardStackIndex == 0 then
				newState.selectedCard = nil
				return newState
			end

			local toCardStack = state.stacks[toCardStackIndex]
			toCard = toCardStack:get(toCardStack:length())

			local fromCardStack
			if fromCardStackIndex == 0 then
				fromCardStack = state.drawnDeck
			else
				fromCardStack = state.stacks[fromCardStackIndex]
			end

			local isFromCardRed = fromCard.suit % 2
			local isToCardRed = toCard.suit % 2

			if not toCard.visible or isFromCardRed == isToCardRed
				or toCard.value - fromCard.value ~= 1 then
				newState.selectedCard = nil
				return newState
			end

			newState.stacks = cloneTable(state.stacks)

			local cards
			if fromCardStackIndex ~= 0 then
				cards, newState.stacks[fromCardStackIndex] = fromCardStack:slice(
					fromCardStack:indexOf(fromCard)
				)
				newState.stacks[toCardStackIndex] = toCardStack:addCards(cards)
			else
				cards, newState.drawnDeck = fromCardStack:slice(
					fromCardStack:indexOf(fromCard)
				)
				newState.stacks[toCardStackIndex] = toCardStack:addCards(cards)
			end
			--]]

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
