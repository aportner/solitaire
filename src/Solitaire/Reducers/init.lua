local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local deckReducer = require(script.DeckReducer)

return Rodux.combineReducers({
	deckReducer = deckReducer,
})
