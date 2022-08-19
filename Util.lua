local Util = {}

Util.Create = function Create(Class,Properties,Children)
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
		Name = string.lower(player.Name)
		if string.sub()
	end
end
return Util
