local Util = {}
local Https = game:GetService('HttpService')

Util.Create = function(Class,Properties,Children)
	Class = Class or 'Frame'
	Properties = Properties or {}
	Children = Children or {}
	
	local instance = Instance.new(Class)
	
	for Property,value in next,Properties do
		instance[Property] = value
	end
	for _,Child in next,Children do
		Child.Parent = instance
	end
	return instance
end

Util.GetPlayer = function(text)
    text = string.lower(text)
	local Players = game.Players:GetPlayers()
    if text == 'me' then
		return {game.Players.LocalPlayer}
	elseif text == 'random' then

		for _,v in next,Players do
			if v.Name == game.Players.LocalPlayer then
				Players[_] = nil
			end
		end

		return {Players[math.Random(0,#Players)]}
	elseif text == 'others' then
		
		for _,v in next,Players do
			if v.Name == game.Players.LocalPlayer then
				Players[_] = nil
			end
		end

		return Players
	elseif text == 'all' then
		return Players
	end
	for _,player in next,Players do
		if string.lower(player.Name) == string.lower(text) then
			return {player}
		end
	end
	for _,player in next,Players do
		Name = string.lower(player.Name)
		if string.sub(Name,1,#text) == string.lower(text) then
			return {player}
		end
	end
end

Util.GetCharacter = function(Player)
	Player = Player or game:GetService('Players').LocalPlayer
	return Player.Character or Player.CharacterAdded:Wait()
end

Util.GetHumanoid = function(Player)
	local Character = Util.GetCharacter(Player)
	
	if not Character:FindFirstChildOfClass('Humanoid') then
		repeat wait() until Character:FindFirstChildOfClass('Humanoid')
	end
	return Character:FindFirstChildOfClass('Humanoid')
end

Util.GetServers = function(PlaceId,Pages,ExcludeFull)
	ExcludeFull = ExcludeFull or true
	PlaceId = placeId or game.PlaceId
	local Servers = {}

	local Url = 'https://games.roblox.com/v1/games/'..tostring(PlaceId)..'/servers/Public?sortOrder=Asc&limit=100&excludeFullGames='..tostring(ExcludeFull)..'&cursor='
	local page = 1
	local Request = game:GetService('HttpService'):JSONDecode(game:HttpGet(Url))

	for _,Server in next,Request.data do
		table.insert(Servers,Server)
	end

	repeat 
		Request = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'..tostring(PlaceId)..'/servers/Public?sortOrder=Asc&limit=100&excludeFullGames='..tostring(ExcludeFull)..'&cursor='..Request.nextPageCursor))
		page += 1
		for _,Server in next,Request.data do
			table.insert(Servers,Server)
		end
	until not Request.nextPageCursor or page == Pages

	return Servers
end

Util.ToggleCommandToConfig = function(CommandName,value)
	local Config = Https:JSONDecode(readfile('Wallops Admin/Config.wa'))
	Config.Commands[CommandName] = value
	local Dump = Https:JSONEncode(Config)
	writefile('Wallops Admin/Config.wa',Dump)
end

Util.CommandToString = function(index,...)
	local Str = 'local CommandList = loadstring(game:HttpGet("https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/CommandList.lua"))()'
    local tableString = ''
    local Args = {...}
	for i,v in next,Args do
		tableString = tableString..'"'..tostring(v)..'"'
		if i~= #Args  then
			tableString = tableString..','
		end
	end
	
	
    
    Str = Str..[[
		for _,value in next,CommandList do
			for _,Command in next,value do
				if table.find(Command.Names,]]..index..[[) then
					Command.Call(]]..tableString..[[)
				end
			end
		end]]
    return Str
end

return Util
