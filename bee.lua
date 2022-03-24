code = "25×"
pc = 1
stack = {}
status = "normal"
print(code)


function vis()
	s = "(stack = "
	for i, item in pairs(stack) do
		s = s .. item.value .. ": " .. item.type
		if i ~= #stack then s = s .. "; " end
	end
	print(s .. ")")
end

str, num, mrk, fnc = "str", "num", "mrk", "fnc"
function push(val, type)
	table.insert( stack, {value = val, type=type} )
	return val
end

function unich(string, index)
    return string:sub(utf8.offset(string,index), utf8.offset(string,index+1)-1)
end

function execchar(char)
	if ("0123456789"):find(char, 1, true) then
		table.insert( stack, {value=char,type="num"} )
	elseif char == "+" then
		y,x  = table.remove(stack), table.remove(stack)
		if x.type == "num" and y.type == "num" then
			push(tonumber(x.value) + tonumber(y.value), num)
		else
			print( "utter bees are to occur" )
			push("utter bees", str)
		end
	elseif char == "-" then
		y,x  = table.remove(stack), table.remove(stack)
		if x.type == "num" and y.type == "num" then
			push(tonumber(x.value) - tonumber(y.value), num)
		else
			print( "utter bees are to occur" )
			push("utter bees", str)
		end
	elseif char == "×" then
		y,x  = table.remove(stack), table.remove(stack)
		if x.type == "num" and y.type == "num" then
			push(tonumber(x.value) * tonumber(y.value), num)
		else
			print( "utter bees are to occur" )
			push("utter bees", str)
		end
	elseif char == "÷" then
		y,x  = table.remove(stack), table.remove(stack)
		if x.type == "num" and y.type == "num" then
			ratio = tonumber(x.value) / tonumber(y.value)
			if math.floor(ratio) == ratio then push(math.floor(ratio), num)
			else push(ratio, num) end
		else
			print( "utter bees are to occur" )
			push("utter bees", str)
		end
	elseif char == "·" then
		-- do nothing
	elseif char == "ℓ" then
		push(#stack, num)
	elseif char == "²" then
		x = table.remove(stack)
		push(x.value, x.type)
		push(x.value, x.type)
	elseif char == "ⁿ" then
		y, x = table.remove(stack), table.remove(stack)
		for i = 1, x.value do
			push(y.value, y.type)
		end
	elseif char == "[" then
		status = "bracketparse"
		parsed = ""
		bracketlevel = 1
	elseif char == "ε" then
		--aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		--TODO: unbee functions containing bracketoids
		x = table.remove(stack)
		for i = 1, utf8.len(x.value) do execchar(unich(x.value,i)) end

	else push(char, str) end
end


for pc = 1, utf8.len(code) do
	if status == "normal" then
		execchar(unich(code,pc))
	elseif status == "bracketparse" then
		if unich(code,pc) == "[" then bracketlevel = bracketlevel + 1 end
		if unich(code,pc) == "]" then bracketlevel = bracketlevel - 1 end
		if bracketlevel == 0 then push(parsed, fnc) status = "normal" end
		parsed = parsed .. unich(code,pc)
	end
end

::yeah::
vis()