local UserInputService = game:GetService("UserInputService")

local KeyboardHandler = {}
KeyboardHandler.__index = KeyboardHandler

function KeyboardHandler.new(actions)
    local instance = {
        actions = actions
    }
    setmetatable(instance, KeyboardHandler)

    instance:init()

    return instance
end

function KeyboardHandler:init()
	self.boundOnInputBegan = function(inputObject, gameProcessedEvent)
		self:onInputBegan(inputObject, gameProcessedEvent)
	end
	self.boundOnInputEnded = function(inputObject, gameProcessedEvent)
		self:onInputEnded(inputObject, gameProcessedEvent)
	end

	self.keys = {}
	self.connections = {}

	table.insert(
		self.connections,
		UserInputService.InputBegan:connect(self.boundOnInputBegan)
	)
	table.insert(
		self.connections,
		UserInputService.InputEnded:connect(self.boundOnInputEnded)
	)
end

function KeyboardHandler:destroy()
	for _, connection in ipairs(self.connections) do
		connection:disconnect()
	end
    self.connections = nil

    return nil
end

function KeyboardHandler:isCtrl()
    return self.keys[Enum.KeyCode.LeftControl] or
        self.keys[Enum.KeyCode.RightControl]
end

function KeyboardHandler:onInputBegan(inputObject)
	if inputObject.keyCode == Enum.KeyCode.Unknown then
		return
	end

	self.keys[inputObject.keyCode] = true

	if (self:isCtrl()) then
		if inputObject.keyCode == Enum.KeyCode.Z then
			self.actions.onUndo()
		elseif inputObject.keyCode == Enum.KeyCode.N then
			self.actions.onNewGame()
		end
	end
end

function KeyboardHandler:onInputEnded(inputObject)
	if inputObject.keyCode == Enum.KeyCode.Unknown then
		return
	end

	self.keys[inputObject.keyCode] = false
end

return KeyboardHandler