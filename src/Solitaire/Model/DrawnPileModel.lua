local Immutable = script.Parent.Immutable
local List = require(Immutable.List)

local DrawnPileModel = {}
DrawnPileModel.__index = DrawnPileModel
setmetatable(DrawnPileModel, { __index = List })

function DrawnPileModel.new(initialState)
	local instance = {
        list = initialState or {}
	}

    setmetatable(instance, DrawnPileModel)
	return instance
end

function DrawnPileModel.canMove()
    return false
end

function DrawnPileModel:moveFrom()
    local _, newPile = self:pop()
    return newPile
end

function DrawnPileModel.getFromCards(_, _, fromCard)
    return List.new({ fromCard })
end

return DrawnPileModel