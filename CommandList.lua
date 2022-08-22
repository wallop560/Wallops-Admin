local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()
local Commands = {}

local HumanoidConnections = {}
local OtherConnections = {}
local Loops = {}
local RS = game:GetService('RunService')
local Players = game:GetService('Players')
local HttpS = game:GetService('HttpService')
local TPS = game:GetService('TeleportService')
local VU = game:GetService("VirtualUser")
local Command = getgenv().Command
Commands.Global = {
    {
        Names = {'walkspeed','ws','speed'},
        Description = 'Changed your characters WalkSpeed.',
        Arguments = {'Speed'},
        Call = function(Speed)
            Speed = tonumber(Speed) or 16
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').WalkSpeed = Speed
        end
    },
    {
        Names = {'jumppower','jp'},
        Description = 'Changed your characters JumpPower.',
        Arguments = {'Power'},
        Call = function(Power)
            Power = tonumber(Power) or 50
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').JumpPower = Power
        end
    },
    {
        Names = {'hipheight','hh'},
        Description = 'Changed your characters HipHeight.',
        Arguments = {'Height'},
        Call = function(Height)
            
            if Util.GetHumanoid().RigType == Enum.HumanoidRigType.R15 then
                Height = tonumber(Height) or 2.1
            else
                Height = tonumber(Height) or 0
            end
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').HipHeight = Height
        end
    },
    {
        Names = {'loopwalkspeed','loopws','loopspeed'},
        Description = 'Loops changing your characters WalkSpeed.',
        Arguments = {'Speed'},
        Call = function(Speed)
            Speed = tonumber(Speed) or 16
            
            local Character = Util.GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeWS()
                if Character and Humanoid then
                    Humanoid.WalkSpeed = Speed
                end
            end

            ChangeWS()

            HumanoidConnections.WSLoop = (HumanoidConnections.WSLoop and HumanoidConnections.WSLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)

            HumanoidConnections.WSChanged = (HumanoidConnections.WSChanged and HumanoidConnections.WSChanged:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                Character = char
                Humanoid = char:WaitForChild('Humanoid')

                ChangeWS()

                HumanoidConnections.WSLoop = (HumanoidConnections.WSLoop and HumanoidConnections.WSLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)
            end)
        end
    },
    {
        Names = {'loopjumppower','loopjp'},
        Description = 'Loops changing your characters JumpPower.',
        Arguments = {'Power'},
        Call = function(Power)
            Power = tonumber(Power) or 50
            
            local Character = Util.GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeJP()
                if Character and Humanoid then
                    Humanoid.JumpPower = Power
                end
            end

            ChangeJP()

            HumanoidConnections.JPLoop = (HumanoidConnections.JPLoop and HumanoidConnections.JPLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeJP)

            HumanoidConnections.JPChanged = (HumanoidConnections.JPChanged and HumanoidConnections.JPChanged:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                Character = char
                Humanoid = char:WaitForChild('Humanoid')

                ChangeJP()

                HumanoidConnections.JPLoop = (HumanoidConnections.JPLoop and HumanoidConnections.JPLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeJP)
            end)
        end
    },
    {
        Names = {'loophipheight','loophh'},
        Description = 'Loops changing your characters JumpPower.',
        Arguments = {'Power'},
        Call = function(Height)
            
            if Util.GetHumanoid().RigType == Enum.HumanoidRigType.R15 then
                Height = tonumber(Height) or 2.1
            else
                Height = tonumber(Height) or 0
            end
            
            local Character = Util.GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeHH()
                if Character and Humanoid then
                    Humanoid.HipHeight = Height
                end
            end

            ChangeHH()

            HumanoidConnections.HHLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeHH)

            HumanoidConnections.HHChanged = (HumanoidConnections.HHChanged and HumanoidConnections.HHChanged:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                Character = char
                Humanoid = char:WaitForChild('Humanoid')

                ChangeHH()

                HumanoidConnections.HHLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeHH)
            end)
        end
    },
    {
        Names = {'unloophipheight','unloophh','noloophipheight','noloophh'},
        Description = 'Stops loop setting your HipHeight.',
        Arguments = {},
        Call = function()
            if Util.GetHumanoid().RigType == Enum.HumanoidRigType.R15 then
                Util.GetHumanoid().HipHeight = 2.1
            else
                Util.GetHumanoid().HipHeight = 0
            end
            HumanoidConnections.HHChanged = (HumanoidConnections.HHChanged and HumanoidConnections.HHChanged:Disconnect() and false) or nil
            HumanoidConnections.HHLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or nil
        end
    },
    {
        Names = {'unloopjumppower','unloopjp','noloopjumppower','noloopjp'},
        Description = 'Stops loop setting your JumpPower.',
        Arguments = {},
        Call = function()
            Util.GetHumanoid().JumpPower = 50
            HumanoidConnections.JPChanged = (HumanoidConnections.HHChanged and HumanoidConnections.HHChanged:Disconnect() and false) or nil
            HumanoidConnections.JPLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or nil
        end
    },
    {
        Names = {'unloopwalkspeed','unloopws','noloopwalkspeed','noloopws'},
        Description = 'Stops loop setting your WalkSpeed.',
        Arguments = {},
        Call = function()
            Util.GetHumanoid().WalkSpeed = 16
            HumanoidConnections.WSChanged = (HumanoidConnections.HHChanged and HumanoidConnections.HHChanged:Disconnect() and false) or nil
            HumanoidConnections.WSLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or nil
        end
    },
    {
        Names = {'noclip','nocollide'},
        Description = 'Stops you from colliding with objects.',
        Arguments = {},
        Call = function()
            HumanoidConnections.NCR = (HumanoidConnections.NCR and HumanoidConnections.NCR:Disconnect() and false) or RS.Stepped:Connect(function()
                print('Rs')
                local Character = Players.LocalPlayer.Character
                if Character then
                    for _,Part in next,Character:GetChildren() do
                        if Part:IsA('BasePart') then
                            Part.CanCollide = false
                        end
                    end
                end
            end)
        end
    },
    {
        Names = {'clip','collide'},
        Description = 'Lets you collide with objects.',
        Arguments = {},
        Call = function()
            HumanoidConnections.NCR = HumanoidConnections.NCR and HumanoidConnections.NCR:Disconnect() and nil or nil
        end
    },
    {
        Names = {'drophats','dropaccessories'},
        Description = 'Parents your accessories to roblox',
        Arguments = {},
        Call = function()
            HumanoidConnections.NCR = HumanoidConnections.NCR and HumanoidConnections.NCR:Disconnect() and nil or nil
        end
    },
    {
        Names = {'shop','serverhop','hopserver'},
        Description = 'Joins a random server of the game you are in.',
        Arguments = {'MinimumPeople'},
        Call = function(MinimumPeople)
            MinimumPeople = tonumber(MinimumPeople) or 1
            local TotalServers = Util.GetServers(game.PlaceId)

            local ViableServers = {}

            for _,Server in next,TotalServers do
                if Server.playing >= MinimumPeople then
                    table.insert(ViableServers,Server)
                end
            end
            local RandomIndex = math.random(1,#ViableServers)
            local RandomServer = ViableServers[RandomIndex]

            local ServerId = RandomServer.id

            TPS:TeleportToPlaceInstance(game.PlaceId,ServerId,Players.LocalPlayer)
        end
    },
    {
        Names = {'antiafk','antiidle'},
        Description = 'Stops you from being kicked when idle.',
        Arguments = {},
        Call = function()
            HumanoidConnections.AntiAfk = (HumanoidConnections.AntiAfk and HumanoidConnections.AntiAfk:Disconnect() and false) or game:GetService("Players").LocalPlayer.Idled:connect(function()
                VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(.2)
                VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    },
    {
        Names = {'unantiafk','unantiidle','noantiafk','noantiidle'},
        Description = 'allows you to be kicked when idle.',
        Arguments = {},
        Call = function()
            HumanoidConnections.AntiAfk = (HumanoidConnections.AntiAfk and HumanoidConnections.AntiAfk:Disconnect() and false) or nil
        end
    },
    {
        Names = {'rejoin','rj'},
        Description = 'Rejoins the same server.',
        Arguments = {}
        Call = function()
            TPS:TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
        end
    }

}
Commands[8737602449] = {
    {
        Names = {'autoshop','autoserverhop','autohopserver'},
        Description = 'Automaticly hops servers after a specified ammount of munites of not getting donations.',
        Arguments = {'Time'},
        Call = function(Time)
            if Loops.AutoShop then
                return
            end
            Time = tonumber(Time) or 30
            Time = Time*60
            local CurrentTime = Time

            local CommandName,ServerHopCommand,Direct = Command.GetCommand('shop')

            Loops.AutoShop = true

            OtherConnections.AutoShopReset = Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
                CurrentTime = Time
            end)

            while Loops.AutoShop and wait(1) and CurrentTime ~= 0 do
                CurrentTime = CurrentTime - 1
            end
            ServerHopCommand('20')
        end
    }
}

return Commands
