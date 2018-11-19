return {
	DeselectCard = function()
		return {
			type = "DeselectCard",
		}
	end,

	MoveCard = function(fromCard, toCard)
		return {
			type = "MoveCard",
			fromCard = fromCard,
			toCard = toCard,
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
