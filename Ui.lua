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
						Size = UDim2.new(0, 200, 0, 40),
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
								ZIndex = 3,
								Font = Enum.Font.SourceSansBold,
								BackgroundTransparency = 1,
								TextXAlignment = Enum.TextXAlignment.Left,
								FontSize = Enum.FontSize.Size18,
								BackgroundColor3 = Color3.new(1, 1, 1),
								TextColor = BrickColor.new('Quill grey')
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
Admin_UI.Parent = game.CoreGui

return {ScreenGui=Admin_UI,Main=Admin_UI.CmdBar,TextBox=Admin_UI.CmdBar.TextFrame.CmdBox,DropShadow = Admin_UI.CmdBar.DropShadow}
