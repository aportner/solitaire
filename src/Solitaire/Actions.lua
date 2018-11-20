return {
	DeselectCard = function()
		return {
			type = "DeselectCard",
		}
	end,

	DrawCard = function()
		return {
			type = "DrawCard",
		}
	end,

	MoveCard = function(fromCard, toCardStack)
		return {
			type = "MoveCard",
			fromCard = fromCard,
			toCardStack = toCardStack,
		}
	end,

	NewGame = function()
		return {
			type = "NewGame",
		}
	end,

	RevealCard = function(card)
		return {
			type = "RevealCard",
			card = card,
		}
	end,

	SelectCard = function(card)
		return {
			type = "SelectCard",
			card = card,
		}
	end
}
