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
        return state.drawnPile,
            function(newState, list)
                newState.drawnPile = list
            end
    end

    local stack, index = GameLogic.getStackOfCard(state, card)
    return stack,
        function(newState, list)
            newState.stacks = newState.stacks:set(index, list)
        end
end

return GameLogic