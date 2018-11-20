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
			local drawnPile = state.drawnPile

			local newState = cloneTable(state)

			if deck:length() == 0 then
				newState.deck = drawnPile
				newState.drawnPile = List.new({})
			else
				local card
				card, newState.deck = deck:shift()
				newState.drawnPile = drawnPile:push(card)
			end

			return newState
		end,

		MoveCard = function(state, action)
			local newState = cloneTable(state)
			newState.selectedCard = nil

			local fromCard = action.fromCard
			local toCardStack = action.toCardStack

			local fromCardStack, fromCardStackUpdate =
				GameLogic.getListForCard(state, fromCard)
			local fromCards = fromCardStack:getFromCards(state, fromCard)
			local toCardStackUpdate =
				GameLogic.getUpdateFunctionForList(state, toCardStack)

			if toCardStack == nil or not toCardStack:canMove(state, fromCards) then
				return newState
			end

			toCardStackUpdate(
				newState,
				toCardStack:move(newState, fromCards)
			)
			fromCardStackUpdate(
				newState,
				fromCardStack:moveFrom(newState, fromCards)
			)

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
			local stackIndex = GameLogic.getStackIndexOfCard(newState, card)
			local stack = newState.stacks:get(stackIndex)
			local cardIndex = stack:indexOf(card)

			if cardIndex < stack:length() then
				return state
			end

			newState.stacks = newState.stacks:set(
				stackIndex,
				stack:set(cardIndex, card:setVisibility(true))
			)

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
