local Immutable = script.Parent.Immutable
local List = require(Immutable.List)

local PileModel = {}
PileModel.__index = PileModel
setmetatable(PileModel, { __index = List })

return PileModel