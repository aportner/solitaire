local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local Actions = require(script.Parent.Parent.Actions)

local Draw = require(script.Parent.Draw)
local Stack = require(script.Parent.Stack)

local Game = Roact.Component:extend("Game")

function Game:getStacks()
	local selectedCard = self.props.deckReducer.selectedCard
	local stacks = self.props.deckReducer.stacks
	local actions = self.props.actions

	return stacks:map(
		function(stack, index)
			return Roact.createElement(
				Stack,
				{
					deck = stack,
					index = index,
					selectedCard = selectedCard,
					actions = actions,
				}
			)
		end
	)
end

function Game:render()
	local actions = self.props.actions
	local deck = self.props.deckReducer.deck
	local drawnPile = self.props.deckReducer.drawnPile
	local selectedCard = self.props.deckReducer.selectedCard

	local children = self:getStacks()
	children = children:push(
		Roact.createElement(
			Draw,
			{
				actions = actions,
				deck = deck,
				drawnPile = drawnPile,
				selectedCard = selectedCard,
			}
		)
	)

	return Roact.createElement(
		"Frame",
		{
			BackgroundColor3 = Color3.new(0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
		},
		children:toTable()
	)
end

Game = RoactRodux.UNSTABLE_connect2(
	function(state)
        return {
			deckReducer = state.deckReducer,
		}
    end,
    function(dispatch)
		return {
			actions = {
				onDeselectCard = function()
					dispatch(Actions.DeselectCard())
				end,
				onDrawCard = function()
					dispatch(Actions.DrawCard())
				end,
				onMoveCard = function(fromCard, toCard)
					dispatch(Actions.MoveCard(fromCard, toCard))
				end,
				onRevealCard = function(card)
					dispatch(Actions.RevealCard(card))
				end,
				onSelectCard = function(card)
					dispatch(Actions.SelectCard(card))
				end,
			}
        }
    end
)(Game)

return Game
