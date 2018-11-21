local GameLogic = {}
GameLogic.__index = GameLogic

function GameLogic.getPileIndexOfCard(state, card)
	local value = 0

	state.piles:forEach(
		function(pile, index)
			if pile:has(card) then
				value = index
			end
		end
	)

	return value
end

function GameLogic.getPileOfCard(state, card)
	local index = GameLogic.getPileIndexOfCard(state, card)

	if index ~= 0 then
		return state.piles:get(index), index
	end

	return nil
end

function GameLogic.getStackIndexOfCard(state, card)
	local value = 0

	state.stacks:forEach(
		function(stack, index)
			if stack:has(card) then
				value = index
			end
		end
	)

	return value
end

function GameLogic.getStackOfCard(state, card)
	local index = GameLogic.getStackIndexOfCard(state, card)

	if index ~= 0 then
		return state.stacks:get(index), index
	end

	return nil
end

function GameLogic.isCardInDrawnPile(state, card)
	return state.drawnPile:has(card)
end

function GameLogic.getListForCard(state, card)
	if GameLogic.isCardInDrawnPile(state, card) then
		local list = state.drawnPile
		return list, GameLogic.getUpdateFunctionForDrawnPile()
	end

	local pile, pileIndex = GameLogic.getPileOfCard(state, card)
	if pile ~= nil then
		return pile, GameLogic.getUpdateFunctionForPile(pileIndex)
	end

	local stack, stackIndex = GameLogic.getStackOfCard(state, card)
	return stack, GameLogic.getUpdateFunctionForStack(stackIndex)
end

function GameLogic.getUpdateFunctionForDrawnPile()
	return function(newState, newList)
		newState.drawnPile = newList
	end
end

function GameLogic.getUpdateFunctionForPile(pileIndex)
	return function(newState, newList)
		newState.piles = newState.piles:set(pileIndex, newList)
	end
end

function GameLogic.getUpdateFunctionForStack(stackIndex)
	return function(newState, newList)
		newState.stacks = newState.stacks:set(stackIndex, newList)
	end
end

function GameLogic.getUpdateFunctionForList(state, list)
	if list == state.drawnPile then
		return GameLogic.getUpdateFunctionForDrawnPile()
	end

	local stackIndex = state.stacks:indexOf(list)
	if stackIndex > 0 then
		return GameLogic.getUpdateFunctionForStack(stackIndex)
	end

	local pileIndex = state.piles:indexOf(list)
	if pileIndex > 0 then
		return GameLogic.getUpdateFunctionForPile(pileIndex)
	end

	return nil
end

function GameLogic.findBestMove(state, fromCard)
	local fromCardStack = GameLogic.getListForCard(state, fromCard)
	local fromCards = fromCardStack:getFromCards(state, fromCard)

	for i = 1, state.piles:length() do
		local pile = state.piles:get(i)
		if pile ~= fromCardStack and pile:canMove(state, fromCards) then
			return pile
		end
	end

	for i = 1, state.stacks:length() do
		local stack = state.stacks:get(i)
		if stack ~= fromCardStack and stack:canMove(state, fromCards) then
			return stack
		end
	end

	return nil
end

return GameLogic