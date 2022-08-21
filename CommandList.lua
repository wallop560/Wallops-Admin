local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()
local Commands = {}

local HumanoidConnections = {}

Commands.Global = {
    {
        Names = {'walkspeed','ws','speed'},
        Description = 'Changed your characters WalkSpeed.',
        Arguments = {'Speed'},
        Call = function(Speed)
            if typeof(Speed) ~= 'number' then return end
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').WalkSpeed = Speed
        end
    },
    {
        Names = {'jumppower','jp'},
        Description = 'Changed your characters JumpPower.',
        Arguments = {'Power'},
        Call = function(Power)
            if typeof(Power) ~= 'number' then return end
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').JumpPower = Power
        end
    },
    {
        Names = {'hipheight','hh'},
        Description = 'Changed your characters HipHeight.',
        Arguments = {'Height'},
        Call = function(Height)
            if typeof(Height) ~= 'number' then return end
            
            Util.GetCharacter():FindFirstChildOfClass('Humanoid').HipHeight = Height
        end
    },
    {
        Names = {'loopwalkspeed','loopws','loopspeed'},
        Description = 'Loops changing your characters WalkSpeed.',
        Arguments = {'Speed'},
        Call = function(Speed)
            Speed = Speed or 16
            if typeof(Speed) ~= 'number' then return end
            
            local Character = Util:GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeWS()
                if Character and Humanoid then
                    Humanoid.WalkSpeed = Speed
                end
            end

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
            Power = Power or 50
            if typeof(Power) ~= 'number' then return end
            
            local Character = Util:GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeWS()
                if Character and Humanoid then
                    Humanoid.JumpPower = Power
                end
            end

            HumanoidConnections.JPLoop = (HumanoidConnections.JPLoop and HumanoidConnections.JPLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)

            HumanoidConnections.JPChanged = (HumanoidConnections.JPChanged and HumanoidConnections.JPChanged:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                Character = char
                Humanoid = char:WaitForChild('Humanoid')

                ChangeWS()

                HumanoidConnections.JPLoop = (HumanoidConnections.JPLoop and HumanoidConnections.JPLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)
            end)
        end
    },
    {
        Names = {'loophipheight','loophh'},
        Description = 'Loops changing your characters JumpPower.',
        Arguments = {'Power'},
        Call = function(Power)
            Power = Power or 50
            if typeof(Power) ~= 'number' then return end
            
            local Character = Util:GetCharacter()
            local Humanoid = Util.GetHumanoid()

            local function ChangeWS()
                if Character and Humanoid then
                    Humanoid.HipHeight = Power
                end
            end

            HumanoidConnections.HHLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)

            HumanoidConnections.HHChanged = (HumanoidConnections.HHChanged and HumanoidConnections.HHChanged:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                Character = char
                Humanoid = char:WaitForChild('Humanoid')

                ChangeWS()

                HumanoidConnections.HHLoop = (HumanoidConnections.HHLoop and HumanoidConnections.HHLoop:Disconnect() and false) or Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeWS)
            end)
        end
    },
    {
        Names = {'unloophipheight','unloophh','noloophipheight','noloophh'},
        Description = 'Stops loop setting your HipHeight.',
        Arguments = {},
        Call = function()
            if HumanoidConnections.HHChanged then
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
                HumanoidConnections.WSChanged:Disconnect()
                HumanoidConnections.WSLoop:Disconnect()
                HumanoidConnections.WSChanged = nil
                HumanoidConnections.WSLoop = nil
            end
        end
    }

}

return Commands
