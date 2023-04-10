local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()
local Commands = {}

local HumanoidConnections = {}
local OtherConnections = {}
local Loops = {}
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RS = game:GetService('RunService')
local Players = game:GetService('Players')
local HttpS = game:GetService('HttpService')
local TPS = game:GetService('TeleportService')
local VU = game:GetService("VirtualUser")
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
        Arguments = {},
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

            local CommandName,ServerHopCommand,Direct = getgenv().Command:GetCommand('shop')

            Loops.AutoShop = true

            OtherConnections.AutoShopReset = Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
                CurrentTime = Time
            end)

            while Loops.AutoShop and wait(1) and CurrentTime ~= 0 do
                CurrentTime = CurrentTime - 1
            end
            ((syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport))(Util.CommandToString('autoshop',Time))
            ServerHopCommand('20')
        end
    },
    {
        Names = {'unautoshop','unautoserverhop','unautohopserver'},
        Description = 'Stops you automaticly hops servers after a specified ammount of munites of not getting donations.',
        Arguments = {},
        Call = function()
            Loops.AutoShop = false
            OtherConnections.AutoShopReset = (OtherConnections.AutoShopReset and OtherConnections.AutoShopReset:Disconnect() and nil) or nil
        end
    }
}

do
    local DestroyFunction

    local DestroyGames = {11093443900}

    local LT2Method = {11093443900}

    if table.find(LT2Method,game.PlaceId) then
        DestroyFunction = function(...)
            v = {...}
            for i,v in next,v do
                local args = {
                    "",
                    CFrame.new(Vector3.new(0,0,0), Vector3.new(0,0,0)),
                    Players.LocalPlayer,
                    v,
                    true
                }

                game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedBlueprint:FireServer(unpack(args))
            end
        end
    end
    for _,v in next,DestroyGames do
        Commands[v] = {
            {
                Names = {'kill'},
                Description = 'Kills Specified Targets',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Player in next,Players do
                        DestroyFunction(Player.Character:FindFirstChild('Head'))
                    end
                end
            },
            {
                Names = {'deleteroot','delroot','delhrp','ragdoll'},
                Description = 'Deletes the Targets HumanoidRootPart',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Player in next,Players do
                        DestroyFunction(Player.Character:FindFirstChild('HumanoidRootPart'))
                    end
                end
            },
            {
                Names = {'deletehumanoid','delhum','delh'},
                Description = 'Deletes the Targets Humanoid',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Player in next,Players do
                        DestroyFunction(Player.Character:FindFirstChild('Humanoid'))
                    end
                end
            },
            {
                Names = {'kick'},
                Description = 'Kicks the Target out of the game',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Player in next,Players do
                        DestroyFunction(Player)
                    end
                end
            },
            {
                Names = {'creeper','noarms'},
                Description = 'Deletes the Targets Arms',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    print(Players)
                    for _,Player in next,Players do
                        if not Player.Character or not Player.Character:FindFirstChild('Torso') then continue end
                        local R6 = Player.Character:FindFirstChild('Torso') and true or false
                        if R6 then
                            DestroyFunction(Player.Character:FindFirstChild('Left Arm'),Player.Character:FindFirstChild('Right Arm'))
                        elseif not R6 then
                            DestroyFunction(Player.Character:FindFirstChild('LeftUpperArm'),Player.Character:FindFirstChild('RightUpperArm'))
                        end
                    end
                end
            },
            {
                Names = {'nolegs'},
                Description = 'Deletes the Targets Legs',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Player in next,Players do
                        if not Player.Character or not Player.Character:FindFirstChild('Torso') then continue end
                        local R6 = Player.Character:FindFirstChild('Torso') and true or false
                        if R6 then
                            DestroyFunction(Player.Character:FindFirstChild('Left Leg'),Player.Character:FindFirstChild('Right Leg'))
                        elseif not R6 then
                            DestroyFunction(Player.Character:FindFirstChild('LeftUpperLeg'),Player.Character:FindFirstChild('RightUpperLeg'))
                        end
                    end
                end
            },
            {
                Names = {'RemoveAdmin','DeleteAdmin'},
                Description = 'Deletes the Admin in the game if there is any',
                Arguments = {},
                Call = function()
                    if ReplicatedStorage:FindFirstChild('b\a\n\a\n\a') then
                        DestroyFunction(ReplicatedStorage['b\a\n\a\n\a'])
                    end
                    if ReplicatedStorage:FindFirstChild('HDAdminClient') then
                        DestroyFunction(ReplicatedStorage['HDAdminClient'])
                    end
                end
            },
            {
                Names = {'DeleteTool'},
                Description = 'Gives a tool that lets you delete anything ',
                Arguments = {},
                Call = function()
                    local Tool = Instance.new('Tool',Players.LocalPlayer.Backpack)
                    Tool.Name = 'Delete'
                    Tool.TextureId = 'rbxassetid://29402763'
                    local MouseMove
                    local GUI = Instance.new('ScreenGui',game.CoreGui)
                    local Highlight = Instance.new('Highlight',GUI)
                    local Target
                    local TargetPos

                    Highlight.Enabled = true
                    Highlight.OutlineColor = Color3.new(1,.1,.1)
                    Highlight.FillColor = Color3.new(1,.3,.3)
                    Highlight.FillTransparency = .7
                    Highlight.OutlineTransparency = 0
                    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded

                    Tool.RequiresHandle = false

                    Tool.Equipped:Connect(function(Mouse)
                        MouseMove = game:GetService('UserInputService').InputChanged:Connect(function()
                            if game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.LeftShift) then
                                Target = Mouse.Target and Mouse.Target.Parent
                                TargetPos = Mouse.Target.Position
                            else
                                Target = Mouse.Target
                                TargetPos = Target.Position
                            end
                            Highlight.Adornee = Target
                        end)
                    end)
                    Tool.Unequipped:Connect(function()
                        MouseMove:Disconnect()
                        Highlight.Adornee = nil
                    end)
                    Tool.Activated:Connect(function()
                        local Explosion = Instance.new('Explosion',workspace)
                        
                        Explosion.Position = TargetPos
                        Explosion.Visible = true
                        Explosion.BlastPressure = 0
                        Explosion.BlastRadius = 0
                        Explosion.DestroyJointRadiusPercent = 0 
                        DestroyFunction(Target)
                    end)
                end
            }

        }
        for _,v in next,LT2Method do
            local PlayerModels = workspace.PlayerModels
            table.insert(Commands[v],{
                Names = {'Wipe'},
                Description = 'Wipes the Targets base',
                Arguments = {'Player'},
                Call = function(Players)
                    Players = Util.GetPlayer(Players)
                    for _,Item in next,PlayerModels:GetChildren() do
                        if Item:FindFirstChild('Owner') and table.find(Players,Item.Owner.Value) then
                            DestroyFunction(Item)
                        end
                    end
                end
            })
            table.insert(Commands[v],{
                Names = {'DeletePlayerModels'},
                Description = 'Deletes PlayerModels Folder',
                Arguments = {},
                Call = function()
                    DestroyFunction(PlayerModels)
                end
            })
        end
    end
end

return Commands
