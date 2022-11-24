local function TableToString(table, level)
	level = level or 1
	local currentString = '{'
	local didInsert = false
	for i,v in pairs(table) do
		didInsert = true
		currentString ..= '\n'..string.rep(' ', level * 4)..'[' .. (
			type(i) == 'string' and ('"%s"'):format(i) or tostring(i)
		) .. '] = ' .. (
			type(v) == 'string' and ('"%s"'):format(v) or type(v) == 'table' and (TableToString(v, level + 1)
			) or tostring(v)..',')
	end
	currentString ..= (didInsert and ('\n' .. string.rep(' ', (level - 1) * 4)) or '') .. '},'
	return currentString
end
return function(Base: string, ...)
	local NewObjs = {}
	for _, v in pairs({...}) do
		if typeof(v) == "Instance" then
			table.insert(NewObjs, ("%s: %s"):format("Instance - "..v.ClassName, tostring(v)))
		elseif typeof(v) == "Color3" then
			table.insert(NewObjs, ("%s: %s"):format("Color", v:ToHex()))
		elseif typeof(v) == "table" then
			table.insert(NewObjs, ("%s: %s"):format("Table", TableToString(v)))
		else
			table.insert(NewObjs, ("%s: %s"):format(typeof(v), tostring(v)))
		end
	end
	error(Base.." \n	"..table.concat(NewObjs, "\n	"))
end
