local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()
local Commands = {}

Commands.Global = {
    {
        Names = 'kill',
        Arguments = {'Player'},
        Description = 'Kills the specified Player.',
        Call = function(Player)
            print('kill',Player)
        end
    },
    {
        Names = {'view','spectate'},
        Arguments = {'Player'},
        Description = 'Makes your camera follow a specific player',
        Call = function(Player)
            print('view',Player)
        end
    }
}

return Commands
