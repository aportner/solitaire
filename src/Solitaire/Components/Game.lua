local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local Actions = require(script.Parent.Parent.Actions)

local Card = require(script.Parent.Card)
local Draw = require(script.Parent.Draw)
local DrawnPile = require(script.Parent.DrawnPile)
local Stack = require(script.Parent.Stack)

local Game = Roact.Component:extend("Game")

function Game:getStacks(children)
	local selectedCard = self.props.deckReducer.selectedCard
	local stacks = self.props.deckReducer.stacks
	local actions = self.props.actions

	stacks:forEach(
		function(stack, index)
			children["Stack" .. index] = Roact.createElement(
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

function Game:getPiles(children)
	local selectedCard = self.props.deckReducer.selectedCard
	local piles = self.props.deckReducer.piles
	local actions = self.props.actions

	piles:forEach(
		function(pile, index)
			children["Pile" .. index] = Roact.createElement(
				DrawnPile,
				{
					deck = pile,
					selectedCard = selectedCard,
					actions = actions,
					xOffset = (index - 1) * (Card.WIDTH + Stack.HORIZONTAL_PADDING)
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

	local children = {}
	self:getStacks(children)
	self:getPiles(children)
	children["Draw"] = Roact.createElement(
		Draw,
		{
			actions = actions,
			deck = deck,
			drawnPile = drawnPile,
			selectedCard = selectedCard,
		}
	)

	return Roact.createElement(
		"Frame",
		{
			BackgroundColor3 = Color3.new(0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
		},
		children
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
