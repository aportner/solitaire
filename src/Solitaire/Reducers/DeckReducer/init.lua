local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local newGame = require(script.newGame)

return Rodux.createReducer(
	newGame(),
	{
		NewGame = function(state, action)
			return newGame()
		end,
	
		TapCard = function(state, action)
			local newState = {}
	
			-- Since state is read-only, we copy it into newState
			for index, friend in pairs(state) do
				newState[index] = friend
			end
	
			print('TapCard')
	
			return newState
		end,
	}
)
