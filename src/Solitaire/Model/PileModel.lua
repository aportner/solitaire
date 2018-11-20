local Immutable = script.Parent.Immutable
local List = require(Immutable.List)

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

function PileModel.canMove()
    return false
end

function PileModel:moveFrom()
    local _, newPile = self:pop()
    return newPile
end

function PileModel.getFromCards(_, _, fromCard)
    return List.new({ fromCard })
end

return PileModel