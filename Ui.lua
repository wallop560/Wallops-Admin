
function Create(Class,Properties,Children)
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
--                         //   Created By I2L   \\
--                         ¦¦Plugin by wallop5607¦¦
--                         \\    le birdo#2221   //
local Admin_UI = Create(
	'ScreenGui',{
		ResetOnSpawn = false,
		Name = 'Admin UI'
	},{
		Create(
			'Frame',{
				AnchorPoint = Vector2.new(0.5, 1),
				Name = 'CmdBar',
				Position = UDim2.new(0.5, 0, 1, -100),
				Size = UDim2.new(0, 200, 0, 40),
				ZIndex = 2,
				BackgroundColor3 = Color3.new(0.211765, 0.223529, 0.247059)
			},{
				Create(
					'UICorner',{
						CornerRadius = UDim.new(0, 6)
					}
				),
				Create(
					'Frame',{
						AnchorPoint = Vector2.new(0.5, 0.5),
						Name = 'DropShadow',
						Position = UDim2.new(0.5, 3, 0.5, 3),
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						Size = UDim2.new(1,0,1,0),
						BackgroundColor3 = Color3.new(0.447059, 0.537255, 0.85098)
					},{
						Create(
							'UICorner',{
								CornerRadius = UDim.new(0, 6)
							}
						)
					}
				),
				Create(
					'Frame',{
						AnchorPoint = Vector2.new(0.5, 0.5),
						Name = 'TextFrame',
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Size = UDim2.new(1, -10, 1, -14),
						ZIndex = 2,
						BackgroundColor3 = Color3.new(0.25098, 0.266667, 0.294118)
					},{
						Create(
							'UICorner',{
								CornerRadius = UDim.new(0, 6)
							}
						),
						Create(
							'TextBox',{
                                Name = 'CmdBox',
								LineHeight = 1.100000023841858,
								PlaceholderColor3 = Color3.new(0.427451, 0.443137, 0.478431),
								PlaceholderText = 'type @command',
								TextSize = 16,
								Size = UDim2.new(1, 0, 1, 0),
								TextColor3 = Color3.new(0.843137, 0.839216, 0.85098),
								Text = '',
								ZIndex = 4,
								Font = Enum.Font.SourceSansBold,
								BackgroundTransparency = 1,
								TextXAlignment = Enum.TextXAlignment.Left,
								FontSize = Enum.FontSize.Size18,
								BackgroundColor3 = Color3.new(1, 1, 1)
							},{
								Create(
									'UIPadding',{
										PaddingLeft = UDim.new(0, 10)
									}
								)
							}
						),
						Create(
							'TextLabel',{
                                Name = 'CmdPreview',
								LineHeight = 1.100000023841858,
								TextColor3 = Color3.new(0.427451, 0.443137, 0.478431),
								TextSize = 16,
								Size = UDim2.new(1, 0, 1, 0),
								Text = '',
								ZIndex = 3,
								Font = Enum.Font.SourceSansBold,
								BackgroundTransparency = 1,
								TextXAlignment = Enum.TextXAlignment.Left,
								FontSize = Enum.FontSize.Size18,
								BackgroundColor3 = Color3.new(1, 1, 1)
							},{
								Create(
									'UIPadding',{
										PaddingLeft = UDim.new(0, 10)
									}
								)
							}
						)
					}
				)
			}
		)
	}
)

-- This part was ripped from IY cuz i only have SynapseX
local COREGUI = game:GetService('CoreGui')
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
if get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	Admin_UI.Name = randomString()
	Admin_UI.Parent = hiddenUI()
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	Admin_UI.Name = randomString()
	syn.protect_gui(Admin_UI)
	Admin_UI.Parent = COREGUI
	PARENT = Main
elseif COREGUI:FindFirstChild('RobloxGui') then
	PARENT = COREGUI.RobloxGui
else
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	Main.Parent = COREGUI
	PARENT = Main
end

local OrigonalSize = Admin_UI.CmdBar.Size

Admin_UI.CmdBar.TextFrame.CmdBox:GetPropertyChangedSignal('TextBounds'):Connect(function()
    local textBounds = Admin_UI.CmdBar.TextFrame.CmdBox.TextBounds.X + 20
    local Bounds = Admin_UI.CmdBar.TextFrame.AbsoluteSize.X 
	local OtherTextBounds = Admin_UI.CmdBar.TextFrame.CmdPreview.TextBounds.X + 20

	local TextBound = textBounds > Bounds and textBounds or OtherTextBounds

    if TextBound > Bounds  then
        print(textBounds,OrigonalSize.X.Offset)
        game:GetService('TweenService'):Create(Admin_UI.CmdBar,TweenInfo.new(.1,Enum.EasingStyle.Quad),{Size = UDim2.new(0,TextBound+10,0,OrigonalSize.Y.Offset)}):Play()
    else
        print(textBounds,OrigonalSize.X.Offset)
        game:GetService('TweenService'):Create(Admin_UI.CmdBar,TweenInfo.new(.1,Enum.EasingStyle.Quad),{Size = OrigonalSize}):Play()
    end
end)

local UI = {ScreenGui=Admin_UI,Main=Admin_UI.CmdBar,TextBox=Admin_UI.CmdBar.TextFrame.CmdBox,Preview = Admin_UI.CmdBar.TextFrame.CmdPreview,DropShadow = Admin_UI.CmdBar.DropShadow}

function UI:ApplyTheming(Instance)
    if Instance:IsA('TextLabel') or Instance:IsA('TextButton') then 
        Instance.TextColor3 = Color3.new(0.843137, 0.839216, 0.85098)
        Instance.Font = Enum.Font.SourceSansBold
        Instance.LineHeight = 1.1
        Instance.TextXAlignment = Enum.TextXAlignment.Left
        Instance.FontSize = Enum.FontSize.Size18
        Instance.TextSize = 16
        Instance.BackgroundColor3 = Color3.new(0.447059, 0.537255, 0.85098)
    elseif Instance:IsA('TextBox') then
        Instance.TextColor3 = Color3.new(0.843137, 0.839216, 0.85098)
        Instance.Font = Enum.Font.SourceSansBold
        Instance.LineHeight = 1.1
        Instance.TextXAlignment = Enum.TextXAlignment.Left
        Instance.FontSize = Enum.FontSize.Size18
        Instance.TextSize = 16
        Instance.PlaceholderColor3 = Color3.new(0.427451, 0.443137, 0.478431)
        Instance.BackgroundColor3 = Color3.new(0.25098, 0.266667, 0.294118)
        Create('UICorner',{CornerRadius = UDim.new(0, 6)}).Parent = Instance
    end
end

function UI:NewWindow(Size,Position)
    local MainFrame = UI.Main:Clone()

    MainFrame.TextFrame:Destroy()
	MainFrame.Parent = Admin_UI
    return MainFrame
end


return UI
