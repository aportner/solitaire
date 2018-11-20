local GameLogic = {}
GameLogic.__index = GameLogic

function GameLogic.getStackIndexOfCard(state, card)
    local value = 0

    state.stacks:forEach(
        function(stack, index)
            if stack:has(card) then
                print('yay')
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

    local stack, stackIndex = GameLogic.getStackOfCard(state, card)
    return stack, GameLogic.getUpdateFunctionForStack(stackIndex)
end

function GameLogic.getUpdateFunctionForDrawnPile()
    return function(newState, newList)
        newState.drawnPile = newList
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

    return nil
end

return GameLogic