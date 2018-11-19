return function(t, f)
	local r = {}
	
	for i, v in ipairs(t) do
		table.insert(r, f(i, v))
	end
	
	return r
end
