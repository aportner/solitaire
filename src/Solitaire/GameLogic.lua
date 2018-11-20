local GameLogic = {}
GameLogic.__index = GameLogic

function GameLogic.getStackIndexOfCard(state, card)
	for index, stack in ipairs(state.stacks) do
		if stack:has(card) then
			return index
		end
	end

	return 0
end

function GameLogic.getStackOfCard(state, card)
    local index = GameLogic.getStackIndexOfCard(state, card)

    if index ~= 0 then
        return state.stacks[index]
    end

    return nil
end

function GameLogic.isCardInDrawnPile(state, card)
    return state.drawnPile:has(card)
end

function GameLogic.getListForCard(state, card)
    if GameLogic.isCardInDrawnPile then
        return state.drawnPile
    end

    return GameLogic.getStackForCard(state, card)
end

return GameLogic