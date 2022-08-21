local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()
local Commands = {}

local HumanoidConnections = {}
local RS = game:GetService('RunService')
local Players = game:GetService('Players')
local HttpS = game:GetService('HttpService')
local TPS = game:GetService('TeleportService')

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
            if HumanoidConnections.HHChanged then
                if Util.GetHumanoid().RigType == Enum.HumanoidRigType.R15 then
                    Util.GetHumanoid().HipHeight = 2.1
                else
                    Util.GetHumanoid().HipHeight = 0
                end
                HumanoidConnections.HHChanged:Disconnect()
                HumanoidConnections.HHLoop:Disconnect()
                HumanoidConnections.HHChanged = nil
                HumanoidConnections.HHLoop = nil
            end
        end
    },
    {
        Names = {'unloopjumppower','unloopjp','noloopjumppower','noloopjp'},
        Description = 'Stops loop setting your JumpPower.',
        Arguments = {},
        Call = function()
            if HumanoidConnections.JPChanged then
                Util.GetHumanoid().JumpPower = 50
                HumanoidConnections.JPChanged:Disconnect()
                HumanoidConnections.JPLoop:Disconnect()
                HumanoidConnections.JPChanged = nil
                HumanoidConnections.JPLoop = nil
            end
        end
    },
    {
        Names = {'unloopwalkspeed','unloopws','noloopwalkspeed','noloopws'},
        Description = 'Stops loop setting your WalkSpeed.',
        Arguments = {},
        Call = function()
            if HumanoidConnections.WSChanged then
                Util.GetHumanoid().WalkSpeed = 16
                HumanoidConnections.WSChanged:Disconnect()
                HumanoidConnections.WSLoop:Disconnect()
                HumanoidConnections.WSChanged = nil
                HumanoidConnections.WSLoop = nil
            end
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
        Description = {'Joins a random server of the game you are in.'},
        Arguments = {},
        Call = function()
            local Servers = Util.GetServers(game.PlaceId,1,true)
            local RandomIndex = math.random(1,#Servers)
            local RandomServer = Servers[RandomIndex]

            local ServerId = RandomServer.id

            TPS:TeleportToPlaceInstance(game.PlaceId,ServerId,Players.LocalPlayer)
        end
    }

}

return Commands
