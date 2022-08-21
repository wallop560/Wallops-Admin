local Util = {}

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
	print(Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	return Character
end

Util.GetHumanoid = function(Player)
	local Character = Util.GetCharacter(Player)
	
	if not Character:FindFirstChildOfClass('Humanoid') then
		repeat wait() until Character:FindFirstChildOfClass('Humanoid')
	end
	return Character:FindFirstChildOfClass('Humanoid')
end


return Util
