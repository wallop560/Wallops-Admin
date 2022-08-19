local Util = loadstring
return {
    -- All games

    All = {
        {
            Names = 'kill',
            Arguments = {'Player'},
            Description = 'Kills the specified Player.',
            Call = function(Player)

            end
        },
        {
            Names = {'view','spectate'},
            Arguments = {'Player'},
            Description = 'Makes your camera follow a specific player'
             
        }
    }
}
