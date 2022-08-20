local Cmds = {}

local FakeCmds = {}
setmetatable(FakeCmds,{
	__newIndex = function(table,index,value)
		return
	end,
	__call = function()
		return 
	end
})
function FakeCmds:AddCommand(CommandNames,Arguments,Description,Call)
	assert(type(CommandNames) == 'table' or type(CommandNames) == 'string','Argument 1 must be a string or a table got ' .. type(CommandNames))
	assert(type(Arguments) == 'table','Argument 2 must be a table got ' .. type(Arguments))
	assert(type(Description) == 'string','Argument 3 must be a table got ' .. type(Description))
	assert(type(Call) == 'function','Argument 4 must be a table got ' .. type(Call))

	if type(CommandNames) == 'string' then
		CommandNames = {CommandNames}
	end
	for i,v in next,CommandNames do
		CommandNames[i] = string.lower(v)
	end

	local Command = {
		CommandNames = CommandNames,
		Arguments = Arguments,
		Description = Description,
		Call = Call
	}
	setmetatable(Command,{
		__call = function(table)
			table.call()
		end
	})

	table.insert(Cmds,Command)
end

function FakeCmds:GetCommands()
	return Cmds
end

function FakeCmds:GetCommand(Name)
    for _,Command in next,Cmds do -- check for exact match
		for _,CommandName in next,Command.CommandNames do
			if CommandName == string.lower(Text) then
				return Text,Command,true
			end
		end
	end
    error('Command not found')
end

function FakeCmds:GetClosestCommand(Text)
	if Text == '' then return '',nil,false end
	for _,Command in next,Cmds do -- check for exact match
		for _,CommandName in next,Command.CommandNames do
			print(CommandName)
			if CommandName == string.lower(Text) then
				return '',Command,true
			end
		end
	end
	for _,Command in next,Cmds do -- check for Closest match
		for _,CommandName in next,Command.CommandNames do
			if string.sub(CommandName,1,#Text) == string.lower(Text) then
				local OtherText = string.sub(CommandName,#Text+1,#CommandName)
				return Text..OtherText,Command,false
			end
		end
	end
	return '',nil,false -- returns text, no command and not exact match
end

return FakeCmds
