local CardModel = {}
CardModel.__index = CardModel

function CardModel.new(value, suit, visible)
	if visible == nil then
		visible = true
	end
	
	local instance = {
		value = value,
		suit = suit,
		visible = visible,
	}
	
	setmetatable(instance, CardModel)
	return instance
end

function CardModel:setVisibility(visibility)
	return CardModel.new(self.value, self.suit, visibility)
end

return CardModel
