local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

local SolitaireUI = Roact.Component:extend("SolitaireUI")

function SolitaireUI:render()
	local moves = self.props.moves
	local score = self.props.score

	return Roact.createElement(
		"Frame",
		{
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 0.7,
            Position = UDim2.new(0, 0, 1, -100),
			Size = UDim2.new(0, 200, 0, 100),
        },
        {
            Moves = Roact.createElement(
                "TextLabel",
                {
                    BackgroundTransparency = 1,
                    Text = "Moves: " .. moves .. "\n" .. "Score: " .. score,
                    TextColor3 = Color3.new(1, 1, 1),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Position = UDim2.new(0, 5, 0, 5),
                    Size = UDim2.new(1, -10, 1, -10),
                }
            )
        }
	)
end

return SolitaireUI