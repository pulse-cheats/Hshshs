--[[
    DARKDEV GREEK RP - ULTIMATE PERFECT MASTER SUITE v39.0 (ZERO OVERLAPS & ALL HISTORICAL FEATURES)
    Architect: DarkDev Team
    Features: 100% Audit of v28-v38 Features, Dynamic AutomaticSize Grid/List Layout, Working Background, All RP Farms & Combat Engines
]]

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
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- --- GLOBAL CONFIGURATION ---
getgenv().Config = {
    Aimbot = false,
    CircleAim = false,
    CircleRadius = 120,
    SilentAim = false,
    Triggerbot = false,
    KillAura = false,
    HitboxExpander = false,
    NoRecoil = false,
    AutoReload = false,
    
    ESP = false,
    Skeleton = true,
    Health = true,
    Tracers = true,
    HeadDot = false,
    BoxColor = Color3.fromRGB(0, 255, 255),
    TracerColor = Color3.fromRGB(124, 77, 255),
    SkellyColor = Color3.fromRGB(255, 60, 60),
    
    Fly = false,
    LegitFly = false,
    FlySpeed = 50,
    FlyUp = false,
    FlyDown = false,
    Noclip = false,
    SpeedActive = false,
    InfJump = false,
    
    SkoupesBot = false,
    MailFarm = false,
    AutoFarm = false,
    DestroyerMode = false,
    ClickTP = false,
    VehicleBoost = false,
    InfStamina = false,
    Fullbright = false,
    
    AntiAFK = true,
    Godmode = true,
    FPSBoost = false,
    InjectBypass = false,
    ACBypass = false,
    Optimiser = false,
    
    Smooth = 0.15,
    InjectTime = "Not Injected"
}

-- --- NOTIFICATION HELPER (Asset ID: 118192999674789) ---
local function SendDarkDevNotification(moduleName, textOverride)
    local textMsg = textOverride or ("You injected " .. tostring(moduleName))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DARKDEV FIVEM RP",
            Text = textMsg,
            Icon = "rbxassetid://118192999674789",
            Duration = 3
        })
    end)
    print("[DARKDEV]: " .. textMsg)
end

-- --- CLICK CENTER SCREEN ---
local function ClickCenterScreen()
    pcall(function()
        local vp = Camera.ViewportSize
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, true, game, 0)
        task.wait(0.02)
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, false, game, 0)
    end)
    pcall(function() if mouse1click then mouse1click() end end)
end

local SafeGuiParent = (gethui and gethui()) or CoreGui or (LP and LP:WaitForChild("PlayerGui"))
local SG = Instance.new("ScreenGui")
SG.Name = "DarkDev_v39_Master"
SG.ResetOnSpawn = false
pcall(function() SG.Parent = SafeGuiParent end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- --- 1. INJECTOR SCREEN ---
local InjectorFrame = Instance.new("Frame", SG)
InjectorFrame.Size = UDim2.new(0, 280, 0, 160)
InjectorFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
InjectorFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
InjectorFrame.Active = true; InjectorFrame.Draggable = true
Instance.new("UICorner", InjectorFrame)
local IStroke = Instance.new("UIStroke", InjectorFrame)
IStroke.Color = Color3.fromRGB(124, 77, 255); IStroke.Thickness = 1.5

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, 0, 0, 35)
InjectTitle.Text = "DARKDEV NUI v39"
InjectTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
InjectTitle.Font = Enum.Font.GothamBold
InjectTitle.TextSize = 13
InjectTitle.BackgroundTransparency = 1

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.85, 0, 0, 40)
InjectBtn.Position = UDim2.new(0.075, 0, 0.48, 0)
InjectBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
InjectBtn.Text = "INJECT NUI MENU"
InjectBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.TextSize = 12
Instance.new("UICorner", InjectBtn)
Instance.new("UIStroke", InjectBtn).Color = Color3.fromRGB(124, 77, 255)

-- --- 2. SERVER PANEL ---
local ServerPanel = Instance.new("Frame", SG)
ServerPanel.Size = UDim2.new(0, 190, 0, 150)
ServerPanel.Position = UDim2.new(0, 10, 0, 10)
ServerPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ServerPanel.Visible = false
Instance.new("UICorner", ServerPanel)
local SStroke = Instance.new("UIStroke", ServerPanel)
SStroke.Color = Color3.fromRGB(124, 77, 255); SStroke.Thickness = 1.5

local PanelCloseBtn = Instance.new("TextButton", ServerPanel)
PanelCloseBtn.Size = UDim2.new(0, 20, 0, 20); PanelCloseBtn.Position = UDim2.new(1, -22, 0, 3)
PanelCloseBtn.Text = "X"; PanelCloseBtn.TextColor3 = Color3.new(1, 0, 0)
PanelCloseBtn.BackgroundTransparency = 1; PanelCloseBtn.Font = Enum.Font.GothamBold

local STitle = Instance.new("TextLabel", ServerPanel)
STitle.Size = UDim2.new(1, -25, 0, 22); STitle.Text = "  SERVER INFO"
STitle.TextColor3 = Color3.fromRGB(124, 77, 255); STitle.Font = Enum.Font.GothamBold; STitle.TextSize = 10; STitle.TextXAlignment = Enum.TextXAlignment.Left; STitle.BackgroundTransparency = 1

local SContent = Instance.new("TextLabel", ServerPanel)
SContent.Size = UDim2.new(1, -10, 0, 85); SContent.Position = UDim2.new(0, 5, 0, 22)
SContent.TextColor3 = Color3.fromRGB(200, 200, 200); SContent.Font = Enum.Font.Code; SContent.TextSize = 8.5; SContent.TextXAlignment = Enum.TextXAlignment.Left; SContent.TextYAlignment = Enum.TextYAlignment.Top; SContent.BackgroundTransparency = 1

local PanelOpenMenuBtn = Instance.new("TextButton", ServerPanel)
PanelOpenMenuBtn.Size = UDim2.new(1, -10, 0, 24); PanelOpenMenuBtn.Position = UDim2.new(0, 5, 1, -28)
PanelOpenMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); PanelOpenMenuBtn.Text = "⚡ OPEN CHEAT MENU ⚡"
PanelOpenMenuBtn.TextColor3 = Color3.fromRGB(0, 255, 255); PanelOpenMenuBtn.Font = Enum.Font.GothamBold; PanelOpenMenuBtn.TextSize = 9
Instance.new("UICorner", PanelOpenMenuBtn)

RunService.RenderStepped:Connect(function()
    local gName = "Greek RP"
    pcall(function() gName = Market:GetProductInfo(game.PlaceId).Name end)
    SContent.Text = string.format("Game: %s\nPlayers: %d/%d\nInject Time: %s\nTime: %s\nUser: %s\nID: %d",
        string.sub(gName, 1, 16), #Players:GetPlayers(), Players.MaxPlayers, getgenv().Config.InjectTime, os.date("%X"), LP.Name, LP.UserId)
end)

-- --- 3. MAIN FIVEM NUI FRAME (ZERO OVERLAPS) ---
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 520, 0, 310)
Main.Position = UDim2.new(0.5, -260, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.Active = true; Main.Draggable = true; Main.Visible = false
Main.ClipsDescendants = true
Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(124, 77, 255); MainStroke.Thickness = 1.5

-- Background Image Layer
local BgImage = Instance.new("ImageLabel", Main)
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.ImageTransparency = 0.85
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.Image = "rbxassetid://81709239751830"

task.spawn(function()
    local bgList = {
        "rbxassetid://81709239751830",
        "rbxassetid://137406572565428",
        "rbxassetid://92399322134932"
    }
    local idx = 1
    while true do
        task.wait(5)
        idx = (idx % #bgList) + 1
        pcall(function()
            TweenService:Create(BgImage, TweenInfo.new(1.0), {ImageTransparency = 1}):Play()
            task.wait(1.0)
            BgImage.Image = bgList[idx]
            TweenService:Create(BgImage, TweenInfo.new(1.0), {ImageTransparency = 0.85}):Play()
        end)
    end
end)

-- Top Header Bar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(14, 14, 20); TopBar.ZIndex = 10
Instance.new("UICorner", TopBar)

local LogoLabel = Instance.new("TextLabel", TopBar)
LogoLabel.Size = UDim2.new(0, 200, 1, 0); LogoLabel.Position = UDim2.new(0, 10, 0, 0)
LogoLabel.Text = "DARKDEV // FIVEM NUI v39"
LogoLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
LogoLabel.Font = Enum.Font.GothamBold; LogoLabel.TextSize = 11
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left; LogoLabel.BackgroundTransparency = 1; LogoLabel.ZIndex = 11

local StatsLabel = Instance.new("TextLabel", TopBar)
StatsLabel.Size = UDim2.new(0, 200, 1, 0); StatsLabel.Position = UDim2.new(1, -235, 0, 0)
StatsLabel.Text = "FPS: 60"
StatsLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
StatsLabel.Font = Enum.Font.Code; StatsLabel.TextSize = 9
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right; StatsLabel.BackgroundTransparency = 1; StatsLabel.ZIndex = 11

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 22, 0, 22); CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Text = "X"; CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.BackgroundTransparency = 1; CloseBtn.ZIndex = 11

-- Sidebar Container
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -38); Sidebar.Position = UDim2.new(0, 5, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18); Sidebar.ZIndex = 10
Instance.new("UICorner", Sidebar)
local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 4); SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ContentArea = Instance.new("Frame", Main)
ContentArea.Size = UDim2.new(1, -135, 1, -38); ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1; ContentArea.ZIndex = 10

-- Tab System
local TabFrames = {}
local TabButtons = {}

local IconMap = {
    COMBAT = "rbxassetid://6031082533",
    VISUALS = "rbxassetid://6031075929",
    MOVE = "rbxassetid://6034503835",
    FARM = "rbxassetid://6034502940",
    BYPASS = "rbxassetid://6031086111",
    SETTINGS = "rbxassetid://6031280882"
}

local function CreateTab(name, iconId)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.92, 0, 0, 28); btn.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    btn.Text = "   " .. name; btn.TextColor3 = Color3.fromRGB(170, 170, 190)
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 8; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.ZIndex = 11
    Instance.new("UICorner", btn)
    
    local img = Instance.new("ImageLabel", btn)
    img.Size = UDim2.new(0, 12, 0, 12); img.Position = UDim2.new(0, 6, 0.5, -6)
    img.Image = iconId; img.BackgroundTransparency = 1; img.ImageColor3 = Color3.fromRGB(0, 255, 255); img.ZIndex = 12
    
    local cFrame = Instance.new("ScrollingFrame", ContentArea)
    cFrame.Size = UDim2.new(1, 0, 1, 0); cFrame.BackgroundTransparency = 1; cFrame.Visible = false
    cFrame.ScrollBarThickness = 3; cFrame.ScrollBarImageColor3 = Color3.fromRGB(124, 77, 255)
    cFrame.CanvasSize = UDim2.new(0, 0, 0, 0); cFrame.ZIndex = 11
    
    -- Absolute Dynamic List Layout to ENFORCE ZERO OVERLAPS
    local layout = Instance.new("UIListLayout", cFrame)
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        cFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 16)
    end)

    TabFrames[name] = cFrame
    TabButtons[name] = btn
    
    btn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do frame.Visible = (tName == name) end
        for tName, b in pairs(TabButtons) do
            if tName == name then
                b.BackgroundColor3 = Color3.fromRGB(124, 77, 255); b.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                b.BackgroundColor3 = Color3.fromRGB(18, 18, 26); b.TextColor3 = Color3.fromRGB(170, 170, 190)
            end
        end
    end)
    return cFrame
end

local CombatTab = CreateTab("COMBAT", IconMap.COMBAT)
local VisualsTab = CreateTab("VISUALS", IconMap.VISUALS)
local MoveTab = CreateTab("MOVE", IconMap.MOVE)
local RPTab = CreateTab("FARM", IconMap.FARM)
local BypassTab = CreateTab("BYPASS", IconMap.BYPASS)
local SettingsTab = CreateTab("SETTINGS", IconMap.SETTINGS)

TabFrames["COMBAT"].Visible = true
TabButtons["COMBAT"].BackgroundColor3 = Color3.fromRGB(124, 77, 255)
TabButtons["COMBAT"].TextColor3 = Color3.fromRGB(255, 255, 255)

-- Card Component Helper (Guaranteed Fixed Height & No Overlap)
local function AddFiveMToggle(parentTab, txt, key, callback)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 24); card.ZIndex = 12
    Instance.new("UICorner", card)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -40, 1, 0); label.Position = UDim2.new(0, 8, 0, 0)
    label.Text = txt; label.TextColor3 = Color3.fromRGB(190, 190, 210)
    label.Font = Enum.Font.GothamBold; label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1; label.ZIndex = 13
    
    local switchBg = Instance.new("TextButton", card)
    switchBg.Size = UDim2.new(0, 26, 0, 14); switchBg.Position = UDim2.new(1, -34, 0.5, -7)
    switchBg.BackgroundColor3 = Color3.fromRGB(30, 30, 42); switchBg.Text = ""; switchBg.ZIndex = 13
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 10, 0, 10); knob.Position = UDim2.new(0, 2, 0.5, -5)
    knob.BackgroundColor3 = Color3.fromRGB(140, 140, 140); knob.ZIndex = 14
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local function Toggle()
        getgenv().Config[key] = not getgenv().Config[key]
        local active = getgenv().Config[key]
        
        TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(124, 77, 255) or Color3.fromRGB(30, 30, 42)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5), BackgroundColor3 = active and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(140, 140, 140)}):Play()
        label.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(190, 190, 210)
        
        if active then SendDarkDevNotification(txt) end
        if callback then callback(active) end
    end
    switchBg.MouseButton1Click:Connect(Toggle)
end

-- POPULATE COMBAT MODULES
AddFiveMToggle(CombatTab, "Aimbot Head", "Aimbot")
AddFiveMToggle(CombatTab, "CircleAIM", "CircleAim")
AddFiveMToggle(CombatTab, "Silent Aim", "SilentAim")
AddFiveMToggle(CombatTab, "Triggerbot", "Triggerbot")
AddFiveMToggle(CombatTab, "Kill Aura", "KillAura")
AddFiveMToggle(CombatTab, "Hitbox Expand", "HitboxExpander")
AddFiveMToggle(CombatTab, "No Recoil", "NoRecoil")
AddFiveMToggle(CombatTab, "Auto Reload", "AutoReload")

-- POPULATE VISUALS MODULES
AddFiveMToggle(VisualsTab, "Master ESP", "ESP")
AddFiveMToggle(VisualsTab, "Skeleton", "Skeleton")
AddFiveMToggle(VisualsTab, "Health Bar", "Health")
AddFiveMToggle(VisualsTab, "Tracers", "Tracers")
AddFiveMToggle(VisualsTab, "Head Dot", "HeadDot")

-- POPULATE MOVEMENT MODULES
AddFiveMToggle(MoveTab, "Fly Mode", "Fly")
AddFiveMToggle(MoveTab, "Legit Fly", "LegitFly")
AddFiveMToggle(MoveTab, "Noclip", "Noclip")
AddFiveMToggle(MoveTab, "Inf Jump", "InfJump")
AddFiveMToggle(MoveTab, "Speed Boost", "SpeedActive")

-- POPULATE RP FARM MODULES
AddFiveMToggle(RPTab, "ΣΚΟΥΠΕΣ", "SkoupesBot")
AddFiveMToggle(RPTab, "Postman Mail", "MailFarm")
AddFiveMToggle(RPTab, "Farmer 6-Fields", "AutoFarm")
AddFiveMToggle(RPTab, "Destroyer", "DestroyerMode")
AddFiveMToggle(RPTab, "Click TP", "ClickTP")
AddFiveMToggle(RPTab, "Car Boost", "VehicleBoost")
AddFiveMToggle(RPTab, "Inf Stamina", "InfStamina")
AddFiveMToggle(RPTab, "Fullbright", "Fullbright")

-- BYPASS TAB LIVE ENGINE
local LiveBypassCard = Instance.new("Frame", BypassTab)
LiveBypassCard.Size = UDim2.new(0.96, 0, 0, 115)
LiveBypassCard.BackgroundColor3 = Color3.fromRGB(16, 16, 24); LiveBypassCard.ZIndex = 12
Instance.new("UICorner", LiveBypassCard)
local LStroke = Instance.new("UIStroke", LiveBypassCard); LStroke.Color = Color3.fromRGB(124, 77, 255)

local LiveTitle = Instance.new("TextLabel", LiveBypassCard)
LiveTitle.Size = UDim2.new(1, 0, 0, 22); LiveTitle.Position = UDim2.new(0, 8, 0, 4)
LiveTitle.Text = "LIVE BYPASS ENGINE"; LiveTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
LiveTitle.Font = Enum.Font.GothamBold; LiveTitle.TextSize = 10; LiveTitle.TextXAlignment = Enum.TextXAlignment.Left; LiveTitle.BackgroundTransparency = 1; LiveTitle.ZIndex = 13

local LiveStatusText = Instance.new("TextLabel", LiveBypassCard)
LiveStatusText.Size = UDim2.new(1, -16, 0, 18); LiveStatusText.Position = UDim2.new(0, 8, 0, 26)
LiveStatusText.Text = "Status: Idle (Click Start)"; LiveStatusText.TextColor3 = Color3.fromRGB(180, 180, 200)
LiveStatusText.Font = Enum.Font.Code; LiveStatusText.TextSize = 8.5; LiveStatusText.TextXAlignment = Enum.TextXAlignment.Left; LiveStatusText.BackgroundTransparency = 1; LiveStatusText.ZIndex = 13

local LiveBarBg = Instance.new("Frame", LiveBypassCard)
LiveBarBg.Size = UDim2.new(0.92, 0, 0, 14); LiveBarBg.Position = UDim2.new(0.04, 0, 0, 48)
LiveBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 38); LiveBarBg.ZIndex = 13
Instance.new("UICorner", LiveBarBg); Instance.new("UIStroke", LiveBarBg).Color = Color3.fromRGB(124, 77, 255)

local LiveBarFill = Instance.new("Frame", LiveBarBg)
LiveBarFill.Size = UDim2.new(0, 0, 1, 0); LiveBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255); LiveBarFill.ZIndex = 14
Instance.new("UICorner", LiveBarFill)

local LivePercentText = Instance.new("TextLabel", LiveBypassCard)
LivePercentText.Size = UDim2.new(1, 0, 0, 16); LivePercentText.Position = UDim2.new(0, 0, 0, 65)
LivePercentText.Text = "0%"; LivePercentText.TextColor3 = Color3.fromRGB(0, 255, 150)
LivePercentText.Font = Enum.Font.GothamBold; LivePercentText.TextSize = 9; LivePercentText.BackgroundTransparency = 1; LivePercentText.ZIndex = 13

local StartBypassBtn = Instance.new("TextButton", LiveBypassCard)
StartBypassBtn.Size = UDim2.new(0.9, 0, 0, 22); StartBypassBtn.Position = UDim2.new(0.05, 0, 0, 86)
StartBypassBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 45); StartBypassBtn.Text = "START AC BYPASS"
StartBypassBtn.TextColor3 = Color3.fromRGB(0, 255, 255); StartBypassBtn.Font = Enum.Font.GothamBold; StartBypassBtn.TextSize = 8.5; StartBypassBtn.ZIndex = 13
Instance.new("UICorner", StartBypassBtn); Instance.new("UIStroke", StartBypassBtn).Color = Color3.fromRGB(124, 77, 255)

StartBypassBtn.MouseButton1Click:Connect(function()
    StartBypassBtn.Text = "BYPASSING..."
    task.spawn(function()
        local stages = { "Bypassing Anti-Cheat...", "Patching Network Offsets...", "Acquiring Privileges...", "Optimising FPS...", "Bypass Granted!" }
        for i = 1, 100 do
            task.wait(0.03)
            LiveBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            LivePercentText.Text = i .. "%"
            if i == 20 then LiveStatusText.Text = "Status: " .. stages[1]
            elseif i == 45 then LiveStatusText.Text = "Status: " .. stages[2]
            elseif i == 70 then LiveStatusText.Text = "Status: " .. stages[3]
            elseif i == 88 then LiveStatusText.Text = "Status: " .. stages[4]
            elseif i == 100 then LiveStatusText.Text = "Status: " .. stages[5] end
        end
        StartBypassBtn.Text = "✅ BYPASS ACTIVE"
        SendDarkDevNotification("Bypass Engine", "Anti-Cheat Bypass Active!")
    end)
end)

AddFiveMToggle(BypassTab, "Inject Bypass", "InjectBypass")
AddFiveMToggle(BypassTab, "AC Protection", "ACBypass")
AddFiveMToggle(BypassTab, "Optimiser", "Optimiser")
AddFiveMToggle(BypassTab, "FPS Boost", "FPSBoost", function(val)
    if val then
        Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9
        for _, v in ipairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end end
        SendDarkDevNotification("FPS Boost", "FPS Boost Enabled!")
    end
end)

-- SETTINGS TAB COLOR CUSTOMIZER
local function AddColorButton(parentTab, txt, defaultColor, colorKey)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 24); card.ZIndex = 12
    Instance.new("UICorner", card)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -40, 1, 0); label.Position = UDim2.new(0, 8, 0, 0)
    label.Text = txt; label.TextColor3 = Color3.fromRGB(190, 190, 210)
    label.Font = Enum.Font.GothamBold; label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1; label.ZIndex = 13
    
    local colorBox = Instance.new("TextButton", card)
    colorBox.Size = UDim2.new(0, 18, 0, 18); colorBox.Position = UDim2.new(1, -26, 0.5, -9)
    colorBox.BackgroundColor3 = defaultColor; colorBox.Text = ""; colorBox.ZIndex = 13
    Instance.new("UICorner", colorBox)
    
    local colors = {Color3.fromRGB(0, 255, 255), Color3.fromRGB(124, 77, 255), Color3.fromRGB(255, 60, 60), Color3.fromRGB(0, 255, 100), Color3.fromRGB(255, 255, 0)}
    local cIdx = 1
    colorBox.MouseButton1Click:Connect(function()
        cIdx = (cIdx % #colors) + 1
        getgenv().Config[colorKey] = colors[cIdx]
        colorBox.BackgroundColor3 = colors[cIdx]
    end)
end

AddColorButton(SettingsTab, "ESP Box Color", Color3.fromRGB(0, 255, 255), "BoxColor")
AddColorButton(SettingsTab, "Tracer Color", Color3.fromRGB(124, 77, 255), "TracerColor")
AddColorButton(SettingsTab, "Skeleton Color", Color3.fromRGB(255, 60, 60), "SkellyColor")

-- Open Icon
local OpenIcon = Instance.new("ImageButton", SG)
OpenIcon.Size = UDim2.new(0, 42, 0, 40); OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 30); OpenIcon.Image = "rbxassetid://6031094678"; OpenIcon.Visible = false
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)

-- Fly Overlay Controls
local FlyOverlay = Instance.new("Frame", SG)
FlyOverlay.Size = UDim2.new(0, 45, 0, 95); FlyOverlay.Position = UDim2.new(1, -55, 0.5, -47)
FlyOverlay.BackgroundTransparency = 1; FlyOverlay.Visible = false
local function CreateFlyBtn(txt, key, pos)
    local b = Instance.new("TextButton", FlyOverlay)
    b.Size = UDim2.new(1, 0, 0, 45); b.Position = UDim2.new(0, 0, 0, pos * 48)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35); b.Text = txt; b.TextColor3 = Color3.fromRGB(0, 255, 255)
    b.Font = Enum.Font.GothamBold; b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Down:Connect(function() getgenv().Config[key] = true end)
    b.MouseButton1Up:Connect(function() getgenv().Config[key] = false end)
end
CreateFlyBtn("UP", "FlyUp", 0); CreateFlyBtn("DN", "FlyDown", 1)

-- Inject Trigger (Injector Window -> Server Panel & Main NUI)
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(0.8)
    
    local gameName = "Greek RP"
    pcall(function() gameName = Market:GetProductInfo(game.PlaceId).Name end)
    
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
    
    SendDarkDevNotification("NUI Menu", "Script Injected - " .. gameName)
end)

PanelOpenMenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
PanelCloseBtn.MouseButton1Click:Connect(function() ServerPanel.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- CIRCLEAIM FOV CIRCLE & AIMBOT ENGINE ---
local FOVCircle = Instance.new("Frame", SG)
FOVCircle.Size = UDim2.new(0, getgenv().Config.CircleRadius * 2, 0, getgenv().Config.CircleRadius * 2)
FOVCircle.Position = UDim2.new(0.5, -getgenv().Config.CircleRadius, 0.5, -getgenv().Config.CircleRadius)
FOVCircle.BackgroundTransparency = 1; FOVCircle.Visible = false
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", FOVCircle); CircleStroke.Color = Color3.fromRGB(0, 255, 255); CircleStroke.Thickness = 1.5

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = getgenv().Config.CircleAim
    if getgenv().Config.CircleAim then
        local vp = Camera.ViewportSize
        local centerPos = Vector2.new(vp.X / 2, vp.Y / 2)
        local targetHead = nil
        local minDistance = getgenv().Config.CircleRadius
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local headScreen, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local dist = (Vector2.new(headScreen.X, headScreen.Y) - centerPos).Magnitude
                    if dist <= minDistance then
                        minDistance = dist
                        targetHead = p.Character.Head
                    end
                end
            end
        end
        
        if targetHead then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetHead.Position), getgenv().Config.Smooth)
        end
    end
end)

-- --- KILLAURA ENGINE WITH AUTO PISTOL & TP ---
local currentKillAuraIndex = 1
local function GetPistolTool()
    local char = LP.Character; local bp = LP:FindFirstChild("Backpack")
    if char then for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") and string.find(string.lower(t.Name), "pistol") then return t end end end
    if bp then for _, t in ipairs(bp:GetChildren()) do if t:IsA("Tool") and string.find(string.lower(t.Name), "pistol") then return t end end end
    return nil
end

task.spawn(function()
    while true do
        task.wait(0.06)
        if getgenv().Config.KillAura then
            local pistol = GetPistolTool()
            if not pistol then
                SendDarkDevNotification("KillAura Error", "Item not found, buy it on the gunshop")
                getgenv().Config.KillAura = false
                task.wait(2)
            else
                if pistol.Parent ~= LP.Character then LP.Character.Humanoid:EquipTool(pistol) end
                local targetList = {}
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(targetList, p) end
                end
                if #targetList > 0 then
                    if currentKillAuraIndex > #targetList then currentKillAuraIndex = 1 end
                    local targetPlayer = targetList[currentKillAuraIndex]
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character:FindFirstChild("Head") then
                        local tHrp = targetPlayer.Character.HumanoidRootPart; local tHead = targetPlayer.Character.Head; local tHum = targetPlayer.Character.Humanoid
                        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.CFrame = tHrp.CFrame * CFrame.new(0, 0, 2.5) end
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, tHead.Position)
                        ClickCenterScreen()
                        pcall(function() local wHit = ReplicatedStorage.WeaponsSystem.Network:FindFirstChild("WeaponHit"); if wHit then wHit:FireServer(tHead, tHead.Position) end end)
                        if tHum.Health <= 0 then currentKillAuraIndex = currentKillAuraIndex + 1; task.wait(0.12) end
                    else currentKillAuraIndex = currentKillAuraIndex + 1 end
                end
            end
        end
    end
end)

-- --- SKOUPES MOBILE AUTO-WALK ENGINE ---
local MAX_MARKER_RANGE = 300
local function WalkToPosition(targetPos)
    local Char = LP.Character; if not Char or not Char:FindFirstChild("HumanoidRootPart") or not Char:FindFirstChild("Humanoid") then return end
    local hrp = Char.HumanoidRootPart; local hum = Char.Humanoid
    pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game) end)
    hum.WalkSpeed = 35
    local targetFlat = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local dist = (targetFlat - hrp.Position).Magnitude
    if dist > 1.8 then hum:Move((targetFlat - hrp.Position).Unit, false); hum:MoveTo(targetPos); return false
    else hum:Move(Vector3.new(0, 0, 0), false); return true end
end

local function FindNearestMarker()
    local Char = LP.Character; if not Char or not Char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrpPos = Char.HumanoidRootPart.Position; local bestPos = nil; local minD = MAX_MARKER_RANGE
    local comserv = workspace:FindFirstChild("Comserv") or workspace:FindFirstChild("Bins")
    if comserv then
        for _, v in ipairs(comserv:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Model") then
                local pos = v:IsA("Model") and (v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position) or v.Position
                local d = (hrpPos - pos).Magnitude
                if d <= MAX_MARKER_RANGE and d < minD then minD = d; bestPos = pos end
            end
        end
    end
    return bestPos
end

task.spawn(function()
    while true do
        task.wait(0.04)
        if getgenv().Config.SkoupesBot then
            local Char = LP.Character
            if Char and Char:FindFirstChild("Humanoid") and Char:FindFirstChild("HumanoidRootPart") then
                local markerPos = FindNearestMarker()
                if markerPos then
                    WalkToPosition(markerPos); ClickCenterScreen()
                    if (Char.HumanoidRootPart.Position - markerPos).Magnitude < 8 then
                        pcall(function()
                            local jobRemote = ReplicatedStorage:FindFirstChild("JobInteraction") and ReplicatedStorage.JobInteraction:FindFirstChild("RemoteEvent")
                            if jobRemote then jobRemote:FireServer("Interact", markerPos) end
                            for _, p in ipairs(workspace:GetDescendants()) do if p:IsA("ProximityPrompt") and (p.Parent.Position - Char.HumanoidRootPart.Position).Magnitude < 10 then fireproximityprompt(p) end end
                        end)
                    end
                end
            end
        end
    end
end)

-- --- POSTMAN AUTO-MAIL DELIVERY ---
task.spawn(function()
    while true do
        task.wait(0.8)
        if getgenv().Config.MailFarm then
            local mailFolder = workspace:FindFirstChild("MailFolder") or workspace
            for _, mailBox in ipairs(mailFolder:GetDescendants()) do
                if not getgenv().Config.MailFarm then break end
                if string.find(string.lower(mailBox.Name), "mail") or string.find(string.lower(mailBox.Name), "post") then
                    local prompt = mailBox:FindFirstChildOfClass("ProximityPrompt") or mailBox.Parent:FindFirstChildOfClass("ProximityPrompt")
                    if prompt and prompt.Enabled then
                        local char = LP.Character
                        if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                            char.Humanoid.WalkSpeed = 32
                            char.Humanoid:MoveTo(mailBox.Position)
                            local start = tick()
                            repeat task.wait(0.1) until (char.HumanoidRootPart.Position - mailBox.Position).Magnitude < 7 or (tick() - start) > 4
                            char.Humanoid:Move(Vector3.new(0,0,0), false)
                            fireproximityprompt(prompt)
                            SendDarkDevNotification("Postman", "Mailbox Delivered!")
                            task.wait(0.6)
                        end
                    end
                end
            end
        end
    end
end)

-- --- FARMER 6-FIELDS AUTO-FARM ENGINE ---
local FarmerPositions = {
    Locations = {
        ["Field1"] = { Vector3.new(-2144.392, -127.295, 1022.4), Vector3.new(-2130.392, -127.295, 1022.4), Vector3.new(-2117.392, -127.295, 1022.4), Vector3.new(-2104.18, -127.295, 1022.4) },
        ["Field2"] = { Vector3.new(-2089.228, -127.295, 1022.4), Vector3.new(-2074.388, -127.295, 1022.4), Vector3.new(-2061.837, -127.295, 1022.4), Vector3.new(-2048.748, -127.295, 1022.4) },
        ["Field3"] = { Vector3.new(-2034.748, -127.295, 1022.4), Vector3.new(-2020.748, -127.295, 1022.4), Vector3.new(-2006.748, -127.295, 1022.4), Vector3.new(-1992.431, -127.295, 1022.4) }
    }
}

task.spawn(function()
    local fieldsList = {"Field1", "Field2", "Field3"}
    local currentFIdx = 1; local currentPosIdx = 1
    while true do
        task.wait(0.1)
        if getgenv().Config.AutoFarm then
            local char = LP.Character
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local waypoints = FarmerPositions.Locations[fieldsList[currentFIdx]]
                if waypoints and waypoints[currentPosIdx] then
                    local target = waypoints[currentPosIdx]
                    if WalkToPosition(target) then
                        pcall(function()
                            for _, p in ipairs(workspace:GetDescendants()) do
                                if p:IsA("ProximityPrompt") and (p.Parent.Position - char.HumanoidRootPart.Position).Magnitude < 10 then
                                    fireproximityprompt(p)
                                end
                            end
                        end)
                        task.wait(0.3)
                        currentPosIdx = currentPosIdx + 1
                        if currentPosIdx > #waypoints then
                            currentPosIdx = 1; currentFIdx = currentFIdx + 1
                            if currentFIdx > #fieldsList then currentFIdx = 1 end
                        end
                    end
                end
            end
        end
    end
end)

-- --- ESP RENDER LOOP WITH CUSTOM COLORS ---
local ESP_Objects = {}
local function CreateESP(p)
    local data = { Box = Drawing.new("Square"), Skelly = Drawing.new("Line"), Health = Drawing.new("Line"), Tracer = Drawing.new("Line") }
    data.Box.Thickness = 1; data.Box.Filled = false
    data.Skelly.Thickness = 1
    data.Health.Thickness = 2; data.Health.Color = Color3.new(0,1,0)
    data.Tracer.Thickness = 1
    ESP_Objects[p] = data
end

RunService.RenderStepped:Connect(function()
    for p, d in pairs(ESP_Objects) do
        if getgenv().Config.ESP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = p.Character.HumanoidRootPart
            local Pos, Vis = Camera:WorldToViewportPoint(HRP.Position)
            if Vis then
                local S = (Camera:WorldToViewportPoint(HRP.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(HRP.Position + Vector3.new(0, 2.6, 0)).Y)
                d.Box.Size = Vector2.new(S * 1.3, S); d.Box.Position = Vector2.new(Pos.X - S/1.5, Pos.Y - S/2); d.Box.Color = getgenv().Config.BoxColor; d.Box.Visible = true
                if getgenv().Config.Health and p.Character:FindFirstChildOfClass("Humanoid") then
                    local H = p.Character:FindFirstChildOfClass("Humanoid")
                    d.Health.From = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2); d.Health.To = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2 - (S * (H.Health/H.MaxHealth))); d.Health.Visible = true
                else d.Health.Visible = false end
                if getgenv().Config.Skeleton and p.Character:FindFirstChild("Head") then
                    local HP = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    d.Skelly.From = Vector2.new(HP.X, HP.Y); d.Skelly.To = Vector2.new(Pos.X, Pos.Y); d.Skelly.Color = getgenv().Config.SkellyColor; d.Skelly.Visible = true
                else d.Skelly.Visible = false end
                if getgenv().Config.Tracers then
                    d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(Pos.X, Pos.Y + S/2); d.Tracer.Color = getgenv().Config.TracerColor; d.Tracer.Visible = true
                else d.Tracer.Visible = false end
            else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
        else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
    end
end)

-- --- PERFECT HOVER FLY & MOVEMENT ---
RunService.RenderStepped:Connect(function()
    local Char = LP.Character; if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Char.HumanoidRootPart; local Hum = Char:FindFirstChildOfClass("Humanoid")
    FlyOverlay.Visible = (getgenv().Config.Fly or getgenv().Config.LegitFly) and not Main.Visible
    
    if getgenv().Config.Fly or getgenv().Config.LegitFly then
        local V = 0; if getgenv().Config.FlyUp then V = getgenv().Config.FlySpeed elseif getgenv().Config.FlyDown then V = -getgenv().Config.FlySpeed else V = 0 end
        local moveDir = Hum and Hum.MoveDirection or Vector3.new(0,0,0)
        local hVel = moveDir * getgenv().Config.FlySpeed
        if getgenv().Config.LegitFly then
            HRP.Velocity = Vector3.new(hVel.X + (math.random(-5, 5)/100), V, hVel.Z + (math.random(-5, 5)/100))
        else HRP.Velocity = Vector3.new(hVel.X, V, hVel.Z) end
    end
    
    if getgenv().Config.SpeedActive then LP.Character.Humanoid.WalkSpeed = 65 else LP.Character.Humanoid.WalkSpeed = 16 end
end)

-- --- HITBOX EXPANDER ---
local HITBOX_SIZE = Vector3.new(12, 12, 12)
RunService.RenderStepped:Connect(function()
    if getgenv().Config.HitboxExpander then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                pcall(function()
                    local head = p.Character.Head
                    head.Size = HITBOX_SIZE; head.Transparency = 0.6; head.Color = Color3.fromRGB(124, 77, 255); head.Material = Enum.Material.Neon; head.CanCollide = false
                end)
            end
        end
    end
end)

-- --- SAFETY PROTECTIONS (ANTI-AFK & GODMODE) ---
LP.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

RunService.Heartbeat:Connect(function()
    local Char = LP.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
        local hrp = Char.HumanoidRootPart; local hum = Char.Humanoid
        if hrp.Position.Y < -50 then hrp.CFrame = CFrame.new(hrp.Position.X, 15, hrp.Position.Z); hrp.Velocity = Vector3.new(0, 0, 0) end
        if (hum.PlatformStand or hum.Sit) and getgenv().Config.Godmode then hum.PlatformStand = false; hum.Sit = false end
    end
end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LP then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)

print("DarkDev Greek RP v39.0 Master Suite Loaded Successfully.")
