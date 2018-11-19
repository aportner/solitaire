local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Rodux = require(ReplicatedStorage.Rodux)

local Actions = require(script.Parent.Parent.Actions)
local Reducers = require(script.Parent.Parent.Reducers)
local Card = require(script.Parent.Card)
local Stack = require(script.Parent.Stack)

local map = require(script.Parent.Parent.Utils.map)

local Game = Roact.Component:extend("Game")

function getStacks(stacks, onCardClick)
	return map(
		stacks,
		function(index, stack)
			return Roact.createElement(
				Stack,
				{
					Deck = stack,
					Index = index,
					onCardClick = onCardClick,
				}
			)
		end
	)
end


function Game:render()
	local onCardClick = self.props.onCardClick
	
	return Roact.createElement(
		"Frame",
		{
			BackgroundColor3 = Color3.new(0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
		},
		getStacks(self.props.deckReducer.stacks, onCardClick)
	)
end

Game = RoactRodux.UNSTABLE_connect2(
	function(state, props)
        return {
			deckReducer = state.deckReducer,
		}
    end,
    function(dispatch)
		return {
			onCardClick = function(card)
				dispatch(Actions.TapCard(card))
			end,
        }
    end
)(Game)

return Game
