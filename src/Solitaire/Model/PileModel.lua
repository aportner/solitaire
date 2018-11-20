local Immutable = script.Parent.Immutable
local List = require(Immutable.List)

-- local GameLogic = require(script.Parent.Parent.GameLogic)

local PileModel = {}
PileModel.__index = PileModel
setmetatable(PileModel, { __index = List })

function PileModel.new(initialState)
	local instance = {
        list = initialState or {}
	}

    setmetatable(instance, PileModel)
	return instance
end

function PileModel:canMove(_, fromCards)
    if self:length() == 0 then
        return fromCards:length() == 1 and
            fromCards:get(1).value == 1
    end

    local toCard = self:last()
    return fromCards:length() == 1
        and toCard.value == fromCards:get(1).value - 1
        and toCard.suit == fromCards:get(1).suit
end

function PileModel:move(_, fromCards)
    return self:concat(fromCards)
end

function PileModel:moveFrom()
    local _, newPile = self:pop()
    return newPile
end

function PileModel.getFromCards(_, _, fromCard)
    return List.new({ fromCard })
end

return PileModel