return {
	NewGame = function(state)
		return {
			type = "NewGame",
		}
	end,
	TapCard = function(card)
		return {
			type = "TapCard",
			card = card,
		}
	end
}
