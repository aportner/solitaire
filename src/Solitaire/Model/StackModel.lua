local Immutable = script.Parent.Immutable
local List = require(Immutable.List)

-- local GameLogic = require(script.Parent.Parent.GameLogic)

local StackModel = {}
StackModel.__index = StackModel
setmetatable(StackModel, { __index = List })

function StackModel.new(initialState)
	local instance = {
        list = initialState or {}
	}

    setmetatable(instance, StackModel)
	return instance
end

function StackModel:canMove(_, fromCards)
    if self:length() == 0 then
        return fromCards:length() > 0 and
            fromCards:get(1).value == 13
    end

    local toCard = self:last()
    return fromCards:length() > 0
        and toCard.value == fromCards:get(1).value + 1
        and toCard.suit % 2 ~= fromCards:get(1).suit % 2
end

function StackModel:move(_, fromCards)
    return self:concat(fromCards)
end

function StackModel:moveFrom(_, fromCards)
    local fromCard = fromCards:get(1)
    local stack = self:slice(1, self:indexOf(fromCard) - 1)

    local len = stack:length()
    if len > 0 then
        stack = stack:set(
            len,
            stack:get(len):setVisibility(true)
        )
    end

    return stack
end

function StackModel:getFromCards(_, fromCard)
    return self:slice(self:indexOf(fromCard), self:length())
end

return StackModel