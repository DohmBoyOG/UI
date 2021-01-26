local library = {}

if game.CoreGui:FindFirstChild("DarkHub") then 
    game.CoreGui.DarkHub:Destroy()
end
game:GetService('UserInputService').InputBegan:connect(function(key, gpe)
			if key.KeyCode == Enum.KeyCode.RightControl then
				pcall(function()
				    for i,v in pairs(game.CoreGui.DarkHub:GetChildren()) do
				        v.Visible = not v.Visible
				    end
				end)
			end
end)

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local HB = game:GetService("RunService").Heartbeat
theme = {
    52,
    52,
    52
}
pcall(function()
    theme = game:GetService("HttpService"):JSONDecode(readfile("theme.json"))
end)

function drag(object)
    local dragInput
	local dragStart
    local startPos
    local dragging

	local function update(input)
		local delta = input.Position - dragStart
		object:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),'Out','Linear',0.02,true)
    end
    
	local connection = object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = object.Position
			repeat wait() until input.UserInputState == Enum.UserInputState.End
            dragging = false
		end
    end)
    
	object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
    end)
    
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
            update(input)
		end
    end)
end

function library:Create(what, propri)
	local instance = Instance.new(what)

	for i, v in next, propri do
		if instance[i] and propri ~= "Parent" then
			instance[i] = v
		end
	end

	return instance
end

function library:CreateMain()
    local obj = {}

    obj.Screengui = library:Create("ScreenGui", {
        Name = "DarkHub",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
		ResetOnSpawn = false,
    })

    obj.Container = library:Create("Frame", {
        Name = "Container",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 20, 0, 20),
        Size = UDim2.new(0.985, 0, 1, 0),
    })

    windowcounter = 0

    function obj:CreateWindow(Name)
        local windows = {}
        local tabopend = true

        windows.window = library:Create("ImageLabel", { 
            Name = Name.."Tab",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Position = UDim2.new(0,windowcounter,0,0),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 196, 0, 30),
            Image = "http://www.roblox.com/asset/?id=5196582310",
            ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.1,
        })

        windowcounter = windowcounter + 211

        windows.windowname = library:Create("TextLabel", {
            Name = "Name",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.173469394, 0, 0, 0),
            Size = UDim2.new(0.649999976, 0, 1, 0),
            Font = Enum.Font.Gotham,
            Text = Name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 16,
        })

        windows.windowarrow = library:Create("ImageButton", {       
            Name = "Arrow",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.841836751, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0.155000001, 0, 1, 0),
            Image = "rbxassetid://5054982349",
        })

        windows.container = library:Create("Frame", {
            Name = "Container",
            BackgroundColor3 = Color3.fromRGB(49,49,49),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(1, 0, 0, 10),
        })
        windows.container.ClipsDescendants = true

        windows.containerlayout = library:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0,5)
        })
        
        windows.containerpadding = library:Create("UIPadding", {
            PaddingBottom = UDim.new(0, 7),
            PaddingLeft = UDim.new(0, 7),
            PaddingTop = UDim.new(0, 8),
        })

        windows.windowarrow.MouseButton1Click:Connect(function()
            tabopend = not tabopend

            if tabopend then
                TS:Create(windows.windowarrow, TweenInfo.new(0.15), {Rotation = 0}):Play()
                local y = 0
                for i, v in next, windows.container:GetChildren() do
                    if not v:IsA("UIListLayout") and not v:IsA("UIPadding") then 
                        y = y + v.AbsoluteSize.Y + 5
                    end
                end
                TS:Create(windows.container, TweenInfo.new(0.15), {Size = UDim2.new(1,0,0,y + 10)}):Play()
            else
                TS:Create(windows.windowarrow, TweenInfo.new(0.15), {Rotation = 90}):Play()
                wait(.1)
                colorpickertoggled = false
                windows.container.ClipsDescendants = true
                pcall(function()
                    TS:Create(colorp.colorpback, TweenInfo.new(0.15), {Size = UDim2.new(0, 0,0, 149)}):Play()
                end)
                TS:Create(windows.container, TweenInfo.new(0.12), {Size = UDim2.new(1,0,0,0)}):Play()
            end
        end)

        function windows:Button(Name, CallBack)
            local buttons = {}

            buttons.background = library:Create("Frame", {
                Name = Name.."Button",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 180, 0, 25),
            })

            buttons.button = library:Create("ImageButton", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 90, 0, 12),
                Size = UDim2.new(0, 180, 0, 25),
                AutoButtonColor = false,
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.04,
            })

            buttons.buttontext = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999829),
                Size = UDim2.new(0.850000024, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            buttons.background.Parent = windows.container
            buttons.button.Parent = buttons.background
            buttons.buttontext.Parent = buttons.button

            buttons.button.MouseButton1Click:Connect(function()

                TS:Create(buttons.button, TweenInfo.new(0.07), {Size = UDim2.new(0, 172, 0, 21)}):Play()
                wait(0.05)
                TS:Create(buttons.button, TweenInfo.new(0.07), {Size = UDim2.new(0, 180, 0, 25)}):Play()

                if CallBack then
                    CallBack()
                end
            end)

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            return buttons
        end

        function windows:Slider(Name, CallBack, Options)
            local sliders = {}
            local value
            local min = Options.min 
            local max = Options.max

            sliders.background = library:Create("ImageLabel", {
                Name = Name.."Slider",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.459183663, 7, 1.33531201, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 40),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            sliders.slidertext = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999829, 0, 0, 0),
                Size = UDim2.new(0.75999999, 0, 0.5, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            sliders.slideramount = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Position = UDim2.new(0.870000005, 0, 0, 0),
                Size = UDim2.new(0, 20, 0, 20),
                Font = Enum.Font.Gotham,
                Text = tostring(Options.min),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            sliders.slider = library:Create("ImageButton", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Position = UDim2.new(0.0111111114, 0, 0.697199821, 0),
                Size = UDim2.new(0, 172, 0, 4),
                AutoButtonColor = false,
            })

            sliders.sliderinner = library:Create("Frame", {
                BackgroundColor3 = Color3.fromRGB(49,49,49),
                BorderSizePixel = 0,
                Size = UDim2.new(0, 0, 1, 0),
            })

            sliders.circle = library:Create("ImageLabel", {
                Name = "Circle",
                BackgroundColor3 = Color3.fromRGB(49,49,49),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0.94, 0, -1, 0),
                Size = UDim2.new(0, 12, 0, 12),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(49,49,49),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
            })

            sliders.slider.MouseButton1Down:Connect(function()
                local moveconnection = HB:Connect(function()
                    local s = math.clamp(Mouse.X - sliders.slider.AbsolutePosition.X,0,sliders.slider.AbsoluteSize.X) / sliders.slider.AbsoluteSize.X
                    if Options.precise then
                        value = string.format("%.1f", min + ((max-min) * s))
                    else
                        value = math.floor(min + ((max-min) * s))
                    end
                    sliders.slideramount.Text = tostring(value)

                    if CallBack then
                        CallBack(value)
                    end

                    game:GetService("TweenService"):Create(sliders.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(s, 0, 1, 0)}):Play()
                end)
                game:GetService("UserInputService").InputEnded:Connect(function(Check)
                    if Check.UserInputType == Enum.UserInputType.MouseButton1 then
                        if moveconnection then
                            moveconnection:Disconnect()
                            moveconnection = nil
                        end
                    end
                end)
            end)


            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,45)

            sliders.background.Parent = windows.container
            sliders.slidertext.Parent = sliders.background
            sliders.slideramount.Parent = sliders.background
            sliders.slider.Parent = sliders.background
            sliders.sliderinner.Parent = sliders.slider
            sliders.circle.Parent = sliders.sliderinner

            return sliders
        end

        function windows:Toggle(Name, CallBack, Default)
            local toggles = {}
            local toggled = false

            toggles.toggle = library:Create("ImageButton", {
                Name = Name.."Toggle",
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0.97349292, 0),
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            toggles.toggletext = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999997, 0, 0, 0),
                Size = UDim2.new(0.850000024, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            toggles.background = library:Create("ImageLabel", {
                Name = "Background",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.843333423, 7, 0.173493028, 0),
                Selectable = true,
                Size = UDim2.new(0, 15, 0, 15),
                Image = "rbxassetid://3570695787",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            toggles.toggleon = library:Create("ImageLabel", {
                Name = "On",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(49, 49, 49),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Selectable = true,
                Size = UDim2.new(1, 0, 1, 0),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(10, 175, 0),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
                ImageTransparency = 1,
            })

            if Default then 
                toggled = true 
                
                if CallBack then 
                    CallBack(toggled)
                end

                TS:Create(toggles.toggleon, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
            end

            toggles.toggle.MouseButton1Click:Connect(function()
                toggled = not toggled

                if CallBack then 
                    CallBack(toggled)
                end

                if toggled then 
                    TS:Create(toggles.toggleon, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
                else 
                    TS:Create(toggles.toggleon, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
                end
            end)

            function toggles:SetValue(boolean)
                toggled = boolean

                if CallBack then
                    CallBack(toggled)
                end

                if toggled then
                    TS:Create(toggles.toggleon, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
                else 
                    TS:Create(toggles.toggleon, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
                end
            end

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            toggles.toggle.Parent = windows.container
            toggles.toggletext.Parent = toggles.toggle
            toggles.background.Parent = toggles.toggle
            toggles.toggleon.Parent = toggles.background

            return toggles
        end

        function windows:ColorPicker(Name, CallBack, Default)
            local colorp = {}
            local colorvalue
            local colorpickertoggled = false

            colorp.colorpickerbackground = library:Create("ImageLabel", {
                Name = "ColorPicker",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0.97349292, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            colorp.colorpickertext = library:Create("TextLabel", {       
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999997, 0, 0, 0),
                Size = UDim2.new(0.850000024, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            colorp.colorpickerbutton = library:Create("ImageButton", {
                Name = "Button",
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.842999995, 7, 0.172999993, 0),
                Size = UDim2.new(0, 17, 0, 17),
                Image = "http://www.roblox.com/asset/?id=4878598940",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0,
            })

            colorp.colorpback = library:Create("Frame", {
                Name = "ColorPicker",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(1.08299994, 0, 0, 0),
                Size = UDim2.new(0, 0, 0, 149),
            })
            colorp.colorpback.ClipsDescendants = true

            colorp.colorp = library:Create("ImageLabel", {
                Name = "ColorPicker",
                BackgroundColor3 = Color3.fromRGB(27, 42, 53),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 137, 0, 149),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(49,49,49),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.040,
            })

            colorp.saturationback = library:Create("ImageLabel", {
                Name = "SaturationBack",
                BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 6, 0, 7),
                Size = UDim2.new(0, 95, 0, 95),
                ZIndex = 2,
                Image = "rbxassetid://4695575676",
                ImageColor3 = Color3.fromRGB(49,49,49),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(128, 128, 128, 128),
                SliceScale = 0.03,
            })
            
            colorp.saturationcolor = library:Create("ImageButton", {
                Name = "Colour",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderColor3 = Color3.fromRGB(221, 221, 221),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                AutoButtonColor = false,
                Image = "rbxassetid://5113592272",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
            })

            colorp.saturationlight = library:Create("ImageLabel", {
                Name = "Light",
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Image = "rbxassetid://5113600420",
            })

            colorp.saturationring = library:Create("ImageLabel", {
                Name = "Ring",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 91, 0, 3),
                Size = UDim2.new(0, 16, 0, 16),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                ZIndex = 1,
                Image = "http://www.roblox.com/asset/?id=5236820965",
            })

            colorp.hsvback = library:Create("ImageLabel", {
                Name = "HSVBack",
                BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 113, 0, 7),
                Size = UDim2.new(0, 15, 0, 95),
                ZIndex = 2,
                Image = "rbxassetid://4695575676",
                ImageColor3 = Color3.fromRGB(49,49,49),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(128, 128, 128, 128),
                SliceScale = 0.030,
            })

            colorp.hsvbar = library:Create("ImageButton", {
                Name = "HSVBar",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                AutoButtonColor = false,
                Image = "http://www.roblox.com/asset/?id=5118428654",
            })

            colorp.hsvring = library:Create("ImageLabel", {
                Name = "Ring",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 7, 0, 3),
                Size = UDim2.new(0, 16, 0, 16),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                ZIndex = 1,
                Image = "http://www.roblox.com/asset/?id=5236820965",
            })

            colorp.rback = library:Create("ImageLabel", {
                Name = "RBack",
                Active = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 23, 0, 113),
                Selectable = true,
                Size = UDim2.new(0, 35, 0, 15),
                ZIndex = 1,
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(35, 35, 35),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            colorp.r = library:Create("TextLabel", {
                Name = "R",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0, 0),
                Size = UDim2.new(0, 20, 0, 15),
                ZIndex = 1,
                Font = Enum.Font.Gotham,
                Text = "255",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
            })

            colorp.gback = library:Create("ImageLabel", {
                Name = "GBack",
                Active = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 68, 0, 113),
                Selectable = true,
                Size = UDim2.new(0, 35, 0, 15),
                ZIndex = 1,
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(35, 35, 35),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            colorp.g = library:Create("TextLabel", {
                Name = "G",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 8, 0, 0),
                Size = UDim2.new(0, 20, 0, 15),
                ZIndex = 1,
                Font = Enum.Font.Gotham,
                Text = "255",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
            })

            colorp.bback = library:Create("ImageLabel", {
                Name = "BBack",
                Active = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 110, 0, 113),
                Selectable = true,
                Size = UDim2.new(0, 35, 0, 15),
                ZIndex = 1,
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(35, 35, 35),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            colorp.b = library:Create("TextLabel", {
                Name = "B",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0, 0),
                Size = UDim2.new(0, 20, 0, 15),
                ZIndex = 1,
                Font = Enum.Font.Gotham,
                Text = "255",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
            })

            colorp.rainbowtoggle = library:Create("ImageButton", {
                Name = "RainbowToggle",
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(-0.0149999466, 7, 0, 125),
                Size = UDim2.new(0, 123, 0, 19),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(49,49,49),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            colorp.rainbowtoggletext = library:Create("TextLabel", {       
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0150000099, 0, 0, 0),
                Size = UDim2.new(0.69682914, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = "Rainbow",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            colorp.rainbowtogglebox = library:Create("ImageLabel", {
                Name = "Box",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.851000011, 0, 0, 2),
                Selectable = true,
                Size = UDim2.new(0, 15, 0, 15),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(40, 40, 40),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            colorp.rainbowtoggleboxon = library:Create("ImageLabel", {
                Name = "On",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(49,49,49),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(-0.200000003, 0, -0.172999993, 0),
                Selectable = true,
                Size = UDim2.new(0, 21, 0, 21),
                Image = "http://www.roblox.com/asset/?id=5035588566",
                ImageColor3 = Color3.fromRGB(25, 25, 25),
                ImageTransparency = 1.000,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0,
            })

            colorp.colorpickerbutton.MouseButton1Click:Connect(function()
                colorpickertoggled = not colorpickertoggled

                if colorpickertoggled then
                    windows.container.ClipsDescendants = false
                    wait(0.15)
                    TS:Create(colorp.colorpback, TweenInfo.new(0.15), {Size = UDim2.new(0, 137,0, 149)}):Play()
                else 
                    TS:Create(colorp.colorpback, TweenInfo.new(0.15), {Size = UDim2.new(0, 0,0, 149)}):Play()
                end
            end)

            local colorbase = Color3.new(1,0,0)
            colorvalue = colorbase
            local Saturation = 1
            local Darkness = 0
            local colourPickColour = colorbase

            local function UpdateColorPicker()

                colourPickColour = colorbase
            
                if Darkness == 1 then
                    colourPickColour = Color3.new(0,0,0)
                    return
                end
            
                if Saturation < 1 then
                    local r = math.clamp(1 + (colourPickColour.r - 1) * Saturation, 0, 1)
                    local g = math.clamp(1 + (colourPickColour.g - 1) * Saturation, 0, 1)
                    local b = math.clamp(1 + (colourPickColour.b - 1) * Saturation, 0, 1)
                    colourPickColour = Color3.new( r, g, b )
                end
            
                if Darkness > 0 then 
                    local r = math.clamp(colourPickColour.r * (1 - Darkness ), 0, 1)
                    local g = math.clamp(colourPickColour.g * (1 - Darkness ), 0, 1)
                    local b = math.clamp(colourPickColour.b * (1 - Darkness ), 0, 1)
                    colourPickColour = Color3.new(r,g,b)
                end
                
                colorp.r.Text = tostring(math.floor(colourPickColour.r * 255))
                colorp.g.Text = tostring(math.floor(colourPickColour.g * 255))
                colorp.b.Text = tostring(math.floor(colourPickColour.b * 255))

                local rv = tonumber(colorp.r.Text)
                local gv = tonumber(colorp.g.Text)
                local bv = tonumber(colorp.b.Text)

                colorvalue = Color3.new(rv,gv,bv)

                TS:Create(colorp.colorpickerbutton, TweenInfo.new(0.2), {ImageColor3 = colourPickColour}):Play()

                if CallBack then
                    CallBack(colorvalue)
                end
            end

            if Default then
                local r,g,b = math.floor(Default.r * 255),math.floor(Default.g * 255),math.floor(Default.b * 255)
                colorbase = Color3.fromRGB(r,g,b)
                TS:Create(colorp.saturationcolor, TweenInfo.new(0.2), {ImageColor3 = colorbase}):Play()
                wait(.2)
                UpdateColorPicker()
            end

            local function setPickerColor(y)
                local rY = y - colorp.hsvbar.AbsolutePosition.Y;
                local cY = math.clamp(rY, 0, colorp.hsvbar.AbsoluteSize.Y - colorp.hsvring.AbsoluteSize.Y + 16)
                local offset = (y - colorp.hsvbar.AbsolutePosition.Y) - colorp.hsvring.AbsoluteSize.Y + 16
                local scale = offset / colorp.hsvbar.AbsoluteSize.Y
                TS:Create(colorp.hsvring, TweenInfo.new(0.15), {Position = UDim2.new(0, 7, 0, cY)}):Play()
                local color = Color3.fromHSV(math.clamp(scale, 0, 1), 1, 1)
                local r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)
                colorbase = Color3.fromRGB(r,g,b)
                TS:Create(colorp.saturationcolor, TweenInfo.new(0.15), {ImageColor3 = colorbase}):Play()
                UpdateColorPicker()
            end

            local function setPickerLight(x,y)
                Saturation = x / 94
                Darkness = y / 93

                TS:Create(colorp.saturationring, TweenInfo.new(0.15), {Position = UDim2.new(0, x, 0, y)}):Play()
                
                UpdateColorPicker()
            end

            local rc
            local cc

            UIS.InputEnded:Connect(function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    if cc then
                        cc:Disconnect()
                        cc = nil
                    end
                    if rc then 
                        rc:Disconnect()
                        rc = nil
                    end
                end
            end)

            local rainbow = false

            colorp.hsvbar.MouseButton1Down:Connect(function()
                if not rainbow then 
                    rc = HB:Connect(function()
                        setPickerColor(Mouse.Y)
                    end)
                end
            end)

            colorp.saturationcolor.MouseButton1Down:Connect(function()
                cc = HB:Connect(function()
                    local v = game:GetService("GuiService"):GetGuiInset()
                    local y = math.clamp(Mouse.Y - colorp.saturationcolor.AbsolutePosition.Y - v.y + 34, 0, 95 )
                    local x = math.clamp(Mouse.X - colorp.saturationcolor.AbsolutePosition.X - v.x, 0, 95 )
                    setPickerLight(x,y)
                end)
            end)

            local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
            colorp.rainbowtoggle.MouseButton1Click:Connect(function()
                rainbow = not rainbow
                if rainbow then 
                    TS:Create(colorp.rainbowtoggleboxon, TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
                    local counter = 0
                    repeat wait()
                        local color = Color3.fromHSV(zigzag(counter),1,1)
                        local r = color.r * 255
                        local b = color.b * 255
                        local g = color.g * 255
                        if counter >= 1.01 then
                            counter = -0.05
                        end
                        colorbase = Color3.fromRGB(r,g,b)
                        TS:Create(colorp.hsvring, TweenInfo.new(0.1), {Position = UDim2.new(0, 7, counter, 0)}):Play()
                        counter = counter + 0.01
                        TS:Create(colorp.saturationcolor, TweenInfo.new(0.15), {ImageColor3 = colorbase}):Play()
                        UpdateColorPicker()
                    until rainbow == false
                else
                    TS:Create(colorp.rainbowtoggleboxon, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
                end
            end)

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            colorp.colorpickerbackground.Parent = windows.container
            colorp.colorpickertext.Parent = colorp.colorpickerbackground
            colorp.colorpickerbutton.Parent = colorp.colorpickerbackground
            colorp.colorpback.Parent = colorp.colorpickerbackground
            colorp.colorp.Parent = colorp.colorpback
            colorp.saturationback.Parent = colorp.colorp
            colorp.saturationcolor.Parent = colorp.saturationback
            colorp.saturationlight.Parent = colorp.saturationcolor
            colorp.saturationring.Parent = colorp.saturationcolor
            colorp.hsvback.Parent = colorp.colorp 
            colorp.hsvbar.Parent = colorp.hsvback
            colorp.hsvring.Parent = colorp.hsvbar
            colorp.rback.Parent = colorp.colorp
            colorp.r.Parent = colorp.rback
            colorp.gback.Parent = colorp.colorp
            colorp.g.Parent = colorp.gback
            colorp.bback.Parent = colorp.colorp
            colorp.b.Parent = colorp.bback
            colorp.rainbowtoggle.Parent = colorp.colorp 
            colorp.rainbowtoggletext.Parent = colorp.rainbowtoggle
            colorp.rainbowtogglebox.Parent = colorp.rainbowtoggle 
            colorp.rainbowtoggleboxon.Parent = colorp.rainbowtogglebox

            return colorp
        end    
        
        function windows:TextLabel(Text)
            local labels = {}
            
            labels.labelback = library:Create("ImageLabel", {
                Name = "TextLabel",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0.97349292, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            labels.label = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
            })

            function labels:SetText(Text)
                labels.label.Text = Text
            end
            function labels:SetColor(ColorYes)
                labels.label.TextColor3 = ColorYes
            end

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            labels.labelback.Parent = windows.container
            labels.label.Parent = labels.labelback

            return labels
        end

        function windows:DropDown(Name, CallBack, Options)
            local dropdowns = {} 
            local dropdowntoggled = false
            local dropdownvalue
            local options

            if Options then

                if Options.options and not Options.playerlist then 
                    options = Options.options 
                elseif Options.options and Options.playerlist then 
                    options = {}
                                        
                    for g,f in pairs(Options.options) do
                       table.insert(options, f)
                    end
                    local list = game:GetService("Players"):GetChildren()
                    for i,v in pairs(list) do
                        if v:IsA("Player") then
                            table.insert(options, v.Name)
                        end
                    end
                elseif not Options.options and Options.playerlist then
                    options = {}
                    local list = game:GetService("Players"):GetChildren()
                    for i,v in pairs(list) do
                        if v:IsA("Player") then
                            table.insert(options, v.Name)
                        end
                    end      
                end
            end 

            if Options.options and not Options.playerlist then 
                dropdownvalue = options[1]
            elseif not Options.options and Options.playerlist then 
                dropdownvalue = game:GetService("Players"):GetChildren()[1].Name
            elseif Options.options and Options.playerlist then 
                dropdownvalue = options[1]
            end

            local maxdropvalue

            if Options.maxdrop then 
                maxdropvalue = Options.maxdrop * 25
            else
                maxdropvalue = 75
            end

            dropdowns.dropdownbackback = library:Create("Frame", {
                Name = Name.."Dropdown",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0357142873, 0, 0.602283776, 0),
                Size = UDim2.new(0, 180, 0, 25),
            })
            dropdowns.dropdownbackback.ClipsDescendants = true

            dropdowns.dropdownback = library:Create("ImageLabel", {
                Name = "Dropdown",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            dropdowns.dropdownarrow = library:Create("ImageButton", {
                Name = "Arrow",
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.831888914, 7, -0.0270000026, 0),
                Rotation = 90,
                Size = UDim2.new(0, 25, 0, 25),
                Image = "rbxassetid://5054982349",
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0,
            })

            dropdowns.dropdownvalue = library:Create("TextBox", {
                Name = "Value",
                Active = false,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999997, 0, 0, 0),
                Selectable = false,
                Size = UDim2.new(0.850000024, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = tostring(dropdownvalue),
                TextColor3 = Color3.fromRGB(248, 248, 248),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            dropdowns.dropdownlistback = library:Create("ImageLabel", {
                Name = "List",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 30),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, maxdropvalue),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })
            dropdowns.dropdownlistscrollingframe = library:Create("ScrollingFrame", {
                Active = true,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 0,
            })

            dropdowns.dropdownlistscrollingframelayout = library:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
            })

            local function refreshlist()

                for i,v in next, dropdowns.dropdownlistscrollingframe:GetChildren() do
                    if v:IsA("ImageButton") then
                        v:Destroy()
                    end
                end

                for i,v in next, options do
                    local button = library:Create("ImageButton", {
                        Name = string.lower(v),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 180, 0, 25),
                        AutoButtonColor = false,
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.05,
                    })

                    local buttontext = library:Create("TextLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = v,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 15,
                    })

                    button.Parent = dropdowns.dropdownlistscrollingframe
                    buttontext.Parent = button

                    button.MouseButton1Click:Connect(function()
                        dropdowntoggled = false
                        dropdowns.dropdownvalue.Text = v
                        dropdownvalue = v

                        if dropdowntoggled then 
                            refreshlist()
                            TS:Create(dropdowns.dropdownarrow, TweenInfo.new(0.12), {Rotation = 0}):Play()
                            TS:Create(windows.container, TweenInfo.new(0.12), {Size = windows.container.Size + UDim2.new(0,0,0,maxdropvalue + 5)}):Play()
                            TS:Create(dropdowns.dropdownlistscrollingframe, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.dropdownlistscrollingframe["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                            TS:Create(dropdowns.dropdownbackback, TweenInfo.new(0.12), {Size = UDim2.new(0, 180, 0, maxdropvalue + 30)}):Play()
                        else 
                            refreshlist()
                            TS:Create(dropdowns.dropdownarrow, TweenInfo.new(0.12), {Rotation = 90}):Play()
                            TS:Create(windows.container, TweenInfo.new(0.12), {Size = windows.container.Size - UDim2.new(0,0,0,maxdropvalue + 5)}):Play()
                            TS:Create(dropdowns.dropdownbackback, TweenInfo.new(0.12), {Size = UDim2.new(0, 180, 0, 25)}):Play()
                        end

                        if CallBack then
                            CallBack(dropdownvalue)
                        end
                    end)
                end
            end
        
            dropdowns.dropdownarrow.MouseButton1Click:Connect(function()
                dropdowntoggled = not dropdowntoggled

                if dropdowntoggled then 
                    refreshlist()
                    TS:Create(dropdowns.dropdownarrow, TweenInfo.new(0.12), {Rotation = 0}):Play()
                    TS:Create(windows.container, TweenInfo.new(0.12), {Size = windows.container.Size + UDim2.new(0,0,0,maxdropvalue + 5)}):Play()
                    TS:Create(dropdowns.dropdownlistscrollingframe, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.dropdownlistscrollingframe["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                    TS:Create(dropdowns.dropdownbackback, TweenInfo.new(0.12), {Size = UDim2.new(0, 180, 0, maxdropvalue + 30)}):Play()
                else 
                    refreshlist()
                    TS:Create(dropdowns.dropdownarrow, TweenInfo.new(0.12), {Rotation = 90}):Play()
                    TS:Create(windows.container, TweenInfo.new(0.12), {Size = windows.container.Size - UDim2.new(0,0,0,maxdropvalue + 5)}):Play()
                    TS:Create(dropdowns.dropdownbackback, TweenInfo.new(0.12), {Size = UDim2.new(0, 180, 0, 25)}):Play()
                end
            end)

            refreshlist()

            local Found = {}
            local searchtable = {}

            for i,v in pairs(options) do
                table.insert(searchtable, string.lower(v))
            end

            local function Edit()
                for i in pairs(Found) do
                    Found[i] = nil
                end
                for h,l in pairs(dropdowns.dropdownlistscrollingframe:GetChildren()) do
                    if not l:IsA("UIListLayout") then
                        l.Visible = false
                    end
                end
                dropdowns.dropdownvalue.Text = string.lower(dropdowns.dropdownvalue.Text)
            end

            local function Search()
                local Results = {}
                local num
                for i,v in pairs(searchtable) do
                    if string.find(v, dropdowns.dropdownvalue.Text) then
                        table.insert(Found, v)
                    end
                end
                for a,b in pairs(dropdowns.dropdownlistscrollingframe:GetChildren()) do
                    for c,d in pairs(Found) do
                        if d == b.Name then
                            b.Visible = true
                        end
                    end
                end
                for p,n in pairs(dropdowns.dropdownlistscrollingframe:GetChildren()) do
                    if not n:IsA("UIListLayout") and n.Visible == true then
                        table.insert(Results, n)
                        for c,d in pairs(Results) do
                            num = c
                        end
                    end
                end
                if num ~= nil then
                    num = num*25
                    dropdowns.dropdownlistscrollingframe.CanvasSize = UDim2.new(0, 0, 0, num)
                    num = 0
                end
            end

            local function Nil()
                for i,v in pairs(dropdowns.dropdownlistscrollingframe:GetChildren()) do
                    if not v:IsA("UIListLayout") and v.Visible == false then
                        TS:Create(dropdowns.dropdownlistscrollingframe, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.dropdownlistscrollingframe["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                        v.Visible = true
                    end 
                end
            end
            
            local SearchLock = true
            dropdowns.dropdownvalue.Changed:connect(function()
                if not SearchLock then
                    Edit()
                    Search()
                end
                if dropdowns.dropdownvalue.Text == "" then
                    Nil()
                    TS:Create(dropdowns.dropdownlistscrollingframe, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.dropdownlistscrollingframe["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                end
            end)

            dropdowns.dropdownvalue.FocusLost:connect(function()
                SearchLock = true
                if dropdowns.dropdownvalue.Text == "" then
                    TS:Create(dropdowns.dropdownlistscrollingframe, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.dropdownlistscrollingframe["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                    SearchLock = true
                    Nil()
                    dropdowns.dropdownvalue.Text = "Search..."
                end
            end)

            dropdowns.dropdownvalue.Focused:connect(function()
                SearchLock = false
            end)

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            dropdowns.dropdownbackback.Parent = windows.container
            dropdowns.dropdownback.Parent = dropdowns.dropdownbackback
            dropdowns.dropdownarrow.Parent = dropdowns.dropdownback
            dropdowns.dropdownvalue.Parent = dropdowns.dropdownback
            dropdowns.dropdownlistback.Parent = dropdowns.dropdownback
            dropdowns.dropdownlistscrollingframe.Parent = dropdowns.dropdownlistback
            dropdowns.dropdownlistscrollingframelayout.Parent = dropdowns.dropdownlistscrollingframe

            return dropdowns
        end

        function windows:TextBox(Name, Text, CallBack)
            local textboxes = {}
            local text

            text = Text

            textboxes.textboxback = library:Create("ImageLabel", {
                Name = Name.."TextBox",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0.97349292, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            textboxes.textboxtext = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999997, 0, 0, 0),
                Size = UDim2.new(0.850000024, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            textboxes.textboxwhite = library:Create("ImageLabel", {
                Name = "Background",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.467955649, 7, 0.173492432, 0),
                Selectable = true,
                Size = UDim2.new(0, 82, 0, 15),
                Image = "rbxassetid://3570695787",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            textboxes.textbox = library:Create("TextBox", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 2, 0, 0),
                Size = UDim2.new(1, -2, 1, 0),
                Font = Enum.Font.Gotham,
                Text = "",
                PlaceholderText = Text,
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 11.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            textboxes.textbox.FocusLost:Connect(function()
                local old = text
                textboxes.textbox.PlaceholderText = old
                text = textboxes.textbox.Text

                if CallBack then
                    CallBack(text)
                end
            end)

            textboxes.textboxback.Parent = windows.container
            textboxes.textboxtext.Parent = textboxes.textboxback
            textboxes.textboxwhite.Parent = textboxes.textboxback
            textboxes.textbox.Parent = textboxes.textboxwhite

            return textboxes
        end

        function windows:KeyBind(Name, CallBack, Default)
            local keybinds = {}
            local c 
            local key
            local bind

            keybinds.keybindback = library:Create("ImageLabel", {
                Name = Name.."KeyBind",
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0.97349292, 0),
                Selectable = true,
                Size = UDim2.new(0, 180, 0, 25),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(theme[1],theme[2],theme[3]),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.05,
            })

            keybinds.keybindtext = library:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0149999829, 0, 0, 0),
                Size = UDim2.new(0.491844594, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            keybinds.keybind = library:Create("ImageButton", {
                Name = "Keybindbtn",
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.467955649, 7, 0.173492432, 0),
                Size = UDim2.new(0, 82, 0, 15),
                Image = "rbxassetid://3570695787",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.03,
            })

            keybinds.keybindkey = library:Create("TextLabel", {
                Name = "Key",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = "None",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 11,
            })

            if Default then 
                bind = Default
                keybinds.keybindkey.Text = bind.Name
            end

            keybinds.keybind.MouseButton1Click:Connect(function()
                keybinds.keybindkey.Text = "..."
                c = UIS.InputBegan:Connect(function(i)
                    if i.UserInputType.Name == "Keyboard" and i.KeyCode ~= Enum.KeyCode.Backspace then
                        keybinds.keybindkey.Text = i.KeyCode.Name
                        bind = i.KeyCode
                        wait(.1)
                        if c then
                            c:Disconnect()
                            c = nil
                        end
                    elseif i.KeyCode == Enum.KeyCode.Backspace then
                        keybinds.keybindkey.Text = "None"
                        bind = nil
                        wait(.1)
                        if c then
                            c:Disconnect()
                            c = nil
                        end
                    end
                end)
            end)

            UIS.InputBegan:Connect(function(i, GPE)
                if bind and i.KeyCode == bind and not GPE and not c then
                    if CallBack then
                        CallBack(i.KeyCode)
                    end
                end
            end)

            windows.container.Size = windows.container.Size + UDim2.new(0,0,0,30)

            keybinds.keybindback.Parent = windows.container
            keybinds.keybindtext.Parent = keybinds.keybindback
            keybinds.keybind.Parent = keybinds.keybindback
            keybinds.keybindkey.Parent = keybinds.keybind

            return keybinds
        end

        windows.window.Parent = obj.Container
        windows.windowname.Parent = windows.window
        windows.windowarrow.Parent = windows.window
        windows.container.Parent = windows.window
        windows.containerlayout.Parent = windows.container
        windows.containerpadding.Parent = windows.container

        drag(windows.window)
        return windows
    end

    obj.Screengui.Parent = game:GetService("CoreGui")
    obj.Container.Parent = obj.Screengui

    return obj
end

return library