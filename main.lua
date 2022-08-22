if not game:IsLoaded() then
    game.Loaded:Wait()
end
local UIS = game:GetService('UserInputService')
local TS = game:GetService('TweenService')
local RS = game:GetService('RunService')
local Https = game:GetService('HttpService')
local Players = game:GetService('Players')
local isfile = isfile or pcall(readfile,'wowd.txt')

local ConfigFoler = makefolder('Wallops Admin')

if not isfile('Wallops Admin/Config.wa') then
    writefile('Wallops Admin/Config.wa','{"Commands":{}}')
end


if not isfile('Wallops Admin/Custom Commands.lua') then
    writefile('Wallops Admin/Custom Commands.lua',[[-- custom commands can be added here. if you have any suggestions please dm me at le birdo#2221

-- to add a Command format it like this (do not have spaces in the names)
--{
--    Names = {'example','wowexample','bruh'},
--    Description = 'This is an example bruh bruh.',
--    Arguments = {'Player','Ammount','Time'},
--    Call = function(Player,Ammount,Time)
--        print(Player,Ammount,Time)
--    end
--}

-- to add game specific commands add a table to the Commands dictionary formated like this:
--GAME ID HERE = {
--    Commands here ( as specified above )
--}

local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Util.lua'))()

local Commands = {}

Commands.Global = {}

return Commands]])
end

local CustomCommands = loadstring(readfile('Wallops Admin/Custom Commands.lua'))()
local Config = Https:JSONDecode(readfile('Wallops Admin/Config.wa'))

local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Ui.lua'))()
local Command = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/Command.lua'))()
local CommandList = loadstring(game:HttpGet('https://raw.githubusercontent.com/wallop560/Wallops-Admin/main/CommandList.lua'))()



local GuiRestPosition = UDim2.new(0.5, 0, 1, -100)
local GuiClosePosition = UDim2.new(0.5,0,1,100)

local State = true

for Range,V in next,CustomCommands do
    if Range == 'Global' then
        for _,v in next,V do
            Command:AddCommand(v.Names,v.Arguments,v.Description,v.Call)
        end
    elseif tonumber(Range) == game.PlaceId then
        for _,v in next,V do
            Command:AddCommand(v.Names,v.Arguments,v.Description,v.Call)
        end
    end
end
for Range,V in next,CommandList do
    if Range == 'Global' then
        for _,v in next,V do
            Command:AddCommand(v.Names,v.Arguments,v.Description,v.Call)
        end
    elseif tonumber(Range) == game.PlaceId then
        for _,v in next,V do
            Command:AddCommand(v.Names,v.Arguments,v.Description,v.Call)
        end
    end
end

UI.Main.Position = GuiRestPosition

UI.TextBox:GetPropertyChangedSignal('Text'):Connect(function()
    local Arguments = UI.TextBox.Text:split(' ')

    local CommandArgument = Arguments[1]
    table.remove(Arguments,1)

    local CommandName,Command,Direct = Command:GetClosestCommand(CommandArgument)
    if #Arguments == 0 then
        UI.Preview.Text = CommandName
    else
        UI.Preview.Text = ''
    end
end)

UI.TextBox.FocusLost:Connect(function(Enter)
    if Enter then
        local Arguments = UI.TextBox.Text:split(' ')

        local CommandArgument = Arguments[1]
        table.remove(Arguments,1)

        local CommandName,Command,Direct = Command:GetClosestCommand(CommandArgument)

        if Command then
            Command(unpack(Arguments))
            UI.TextBox.Text = ''
        end
    end
end)

UIS.InputBegan:Connect(function(Input,gpe)
    if Input.KeyCode == Enum.KeyCode.LeftControl and not gpe then
        State = not State
        if State then
            TS:Create(UI.Main,TweenInfo.new(.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{Position = GuiRestPosition}):Play()
        else
            TS:Create(UI.Main,TweenInfo.new(.2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position = GuiClosePosition}):Play()
        end
    elseif State and Input.KeyCode == Enum.KeyCode.Semicolon and not UIS:GetFocusedTextBox() then
        UI.TextBox:CaptureFocus()
        UI.TextBox:GetPropertyChangedSignal('Text'):Wait()
        UI.TextBox.Text = ''
    end
end)

getgenv().Command = Command
getgenv().UI = UI
