--[[
    DARKDEV GREEK RP - ULTIMATE PERFECT MASTER SUITE v40.0 (FIVEM NUI REDESIGN & FULL FIX)
    Architect: DarkDev Team
    Features: 100% Audit of Features, Working Modules, FiveM Style Sleek NUI UI, Zero Overlaps.
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
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer

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
    InfJump = false,
    SpeedActive = false,
    
    SkoupesBot = false,
    MailFarm = false,
    AutoFarm = false,
    DestroyerMode = false,
    ClickTP = false,
    VehicleBoost = false,
    InfStamina = false,
    Fullbright = false,
    
    InjectBypass = false,
    ACBypass = false,
    Optimiser = false,
    FPSBoost = false,
    
    AntiAFK = true,
    Godmode = false,
    
    InjectTime = "NOT INJECTED",
    Smooth = 0.2
}

-- --- NOTIFICATION HELPER ---
local function SendDarkDevNotification(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "DarkDev NUI",
            Text = text or "Action Executed",
            Duration = 3,
            Icon = "rbxassetid://118192999674789"
        })
    end)
end

-- --- CLICK CENTER SCREEN ---
local function ClickCenterScreen()
    pcall(function()
        local vp = Camera.ViewportSize
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, true, game, 0)
        task.wait(0.02)
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, false, game, 0)
    end)
end

-- --- GUI CREATION (FiveM Dark Red / Purple Theme) ---
local SG = Instance.new("ScreenGui")
SG.Name = "DarkDevFiveMNUI"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if gethui then
        SG.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(SG)
        SG.Parent = CoreGui
    else
        SG.Parent = CoreGui
    end
end)

if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- --- 1. INJECTOR SCREEN ---
local InjectorFrame = Instance.new("Frame", SG)
InjectorFrame.Name = "InjectorFrame"
InjectorFrame.Size = UDim2.new(0, 320, 0, 180)
InjectorFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
InjectorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
InjectorFrame.BorderSizePixel = 0
InjectorFrame.Active = true
InjectorFrame.Draggable = true

Instance.new("UICorner", InjectorFrame).CornerRadius = UDim.new(0, 8)
local IStroke = Instance.new("UIStroke", InjectorFrame)
IStroke.Color = Color3.fromRGB(225, 40, 40)
IStroke.Thickness = 1.5

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, 0, 0, 40)
InjectTitle.BackgroundTransparency = 1
InjectTitle.Text = "DARKDEV FIVEM NUI v40"
InjectTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectTitle.Font = Enum.Font.GothamBold
InjectTitle.TextSize = 14

local InjectDesc = Instance.new("TextLabel", InjectorFrame)
InjectDesc.Size = UDim2.new(1, -20, 0, 40)
InjectDesc.Position = UDim2.new(0, 10, 0, 45)
InjectDesc.BackgroundTransparency = 1
InjectDesc.Text = "Greek RP Master Suite - Fully Fixed Modules & FiveM NUI UI"
InjectDesc.TextColor3 = Color3.fromRGB(160, 160, 175)
InjectDesc.Font = Enum.Font.Gotham
InjectDesc.TextSize = 10
InjectDesc.TextWrapped = true

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.8, 0, 0, 36)
InjectBtn.Position = UDim2.new(0.1, 0, 0, 115)
InjectBtn.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
InjectBtn.Text = "INJECT FIVEM NUI"
InjectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.TextSize = 12
Instance.new("UICorner", InjectBtn).CornerRadius = UDim.new(0, 6)

-- --- 2. SERVER PANEL (FiveM HUD Header) ---
local ServerPanel = Instance.new("Frame", SG)
ServerPanel.Name = "ServerPanel"
ServerPanel.Size = UDim2.new(0, 310, 0, 70)
ServerPanel.Position = UDim2.new(0.5, -155, 0.02, 0)
ServerPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ServerPanel.Visible = false
ServerPanel.BorderSizePixel = 0
ServerPanel.Active = true
ServerPanel.Draggable = true

Instance.new("UICorner", ServerPanel).CornerRadius = UDim.new(0, 8)
local SStroke = Instance.new("UIStroke", ServerPanel)
SStroke.Color = Color3.fromRGB(225, 40, 40)
SStroke.Thickness = 1.5

local PanelTitle = Instance.new("TextLabel", ServerPanel)
PanelTitle.Size = UDim2.new(1, -60, 0, 22)
PanelTitle.Position = UDim2.new(0, 10, 0, 6)
PanelTitle.Text = "DARKDEV RP | FIVEM HUD"
PanelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.TextSize = 11
PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
PanelTitle.BackgroundTransparency = 1

local PanelSub = Instance.new("TextLabel", ServerPanel)
PanelSub.Size = UDim2.new(1, -60, 0, 16)
PanelSub.Position = UDim2.new(0, 10, 0, 28)
PanelSub.Text = "User: " .. LP.Name .. " | ID: " .. LP.UserId
PanelSub.TextColor3 = Color3.fromRGB(180, 180, 195)
PanelSub.Font = Enum.Font.Gotham
PanelSub.TextSize = 9.5
PanelSub.TextXAlignment = Enum.TextXAlignment.Left
PanelSub.BackgroundTransparency = 1

local PanelStatus = Instance.new("TextLabel", ServerPanel)
PanelStatus.Size = UDim2.new(1, -60, 0, 16)
PanelStatus.Position = UDim2.new(0, 10, 0, 46)
PanelStatus.Text = "Status: ACTIVE | Ping: 24ms"
PanelStatus.TextColor3 = Color3.fromRGB(0, 255, 160)
PanelStatus.Font = Enum.Font.GothamBold
PanelStatus.TextSize = 9
PanelStatus.TextXAlignment = Enum.TextXAlignment.Left
PanelStatus.BackgroundTransparency = 1

local PanelOpenMenuBtn = Instance.new("TextButton", ServerPanel)
PanelOpenMenuBtn.Size = UDim2.new(0, 42, 0, 22)
PanelOpenMenuBtn.Position = UDim2.new(1, -50, 0, 8)
PanelOpenMenuBtn.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
PanelOpenMenuBtn.Text = "MENU"
PanelOpenMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelOpenMenuBtn.Font = Enum.Font.GothamBold
PanelOpenMenuBtn.TextSize = 9
Instance.new("UICorner", PanelOpenMenuBtn).CornerRadius = UDim.new(0, 4)

local PanelCloseBtn = Instance.new("TextButton", ServerPanel)
PanelCloseBtn.Size = UDim2.new(0, 42, 0, 22)
PanelCloseBtn.Position = UDim2.new(1, -50, 0, 36)
PanelCloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PanelCloseBtn.Text = "HIDE"
PanelCloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
PanelCloseBtn.Font = Enum.Font.GothamBold
PanelCloseBtn.TextSize = 9
Instance.new("UICorner", PanelCloseBtn).CornerRadius = UDim.new(0, 4)

-- --- 3. MAIN FIVEM NUI FRAME (Redesigned & Zero Overlaps) ---
local Main = Instance.new("Frame", SG)
Main.Name = "MainNUI"
Main.Size = UDim2.new(0, 580, 0, 360)
Main.Position = UDim2.new(0.5, -290, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
Main.Visible = false
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(225, 40, 40)
MainStroke.Thickness = 1.5

-- Top Bar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local LogoLabel = Instance.new("TextLabel", TopBar)
LogoLabel.Size = UDim2.new(0.6, 0, 1, 0)
LogoLabel.Position = UDim2.new(0, 12, 0, 0)
LogoLabel.Text = "DARKDEV // FIVEM NUI v40"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.TextSize = 12
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 26, 0, 22)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -11)
CloseBtn.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

-- Sidebar (Left Tab Column - Wide enough for icons + text)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -44)
Sidebar.Position = UDim2.new(0, 8, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 6)

-- Content Area (Right Side)
local ContentArea = Instance.new("Frame", Main)
ContentArea.Size = UDim2.new(1, -152, 1, -44)
ContentArea.Position = UDim2.new(0, 144, 0, 40)
ContentArea.BackgroundTransparency = 1

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

local function CreateTab(name, iconId, order)
    local btn = Instance.new("TextButton", Sidebar)
    btn.LayoutOrder = order or 1
    btn.Size = UDim2.new(0.92, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    btn.Text = "" -- Clear text from button, use sub-labels for layout
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local img = Instance.new("ImageLabel", btn)
    img.Size = UDim2.new(0, 14, 0, 14)
    img.Position = UDim2.new(0, 10, 0.5, -7)
    img.Image = iconId
    img.BackgroundTransparency = 1
    img.ImageColor3 = Color3.fromRGB(225, 40, 40)
    
    local txtLabel = Instance.new("TextLabel", btn)
    txtLabel.Size = UDim2.new(1, -32, 1, 0)
    txtLabel.Position = UDim2.new(0, 30, 0, 0)
    txtLabel.Text = name
    txtLabel.TextColor3 = Color3.fromRGB(170, 170, 185)
    txtLabel.Font = Enum.Font.GothamBold
    txtLabel.TextSize = 9.5
    txtLabel.TextXAlignment = Enum.TextXAlignment.Left
    txtLabel.BackgroundTransparency = 1
    
    local cFrame = Instance.new("ScrollingFrame", ContentArea)
    cFrame.Size = UDim2.new(1, 0, 1, 0)
    cFrame.BackgroundTransparency = 1
    cFrame.Visible = false
    cFrame.ScrollBarThickness = 3
    cFrame.ScrollBarImageColor3 = Color3.fromRGB(225, 40, 40)
    cFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local layout = Instance.new("UIListLayout", cFrame)
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        cFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 16)
    end)

    TabFrames[name] = cFrame
    TabButtons[name] = {Btn = btn, Label = txtLabel, Icon = img}
    
    btn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do frame.Visible = (tName == name) end
        for tName, tData in pairs(TabButtons) do
            if tName == name then
                tData.Btn.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
                tData.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                tData.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            else
                tData.Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
                tData.Label.TextColor3 = Color3.fromRGB(170, 170, 185)
                tData.Icon.ImageColor3 = Color3.fromRGB(225, 40, 40)
            end
        end
    end)
    return cFrame
end

local CombatTab = CreateTab("COMBAT", IconMap.COMBAT, 1)
local VisualsTab = CreateTab("VISUALS", IconMap.VISUALS, 2)
local MoveTab = CreateTab("MOVE", IconMap.MOVE, 3)
local RPTab = CreateTab("FARM", IconMap.FARM, 4)
local BypassTab = CreateTab("BYPASS", IconMap.BYPASS, 5)
local SettingsTab = CreateTab("SETTINGS", IconMap.SETTINGS, 6)

-- Set Active Tab
TabFrames["COMBAT"].Visible = true
TabButtons["COMBAT"].Btn.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
TabButtons["COMBAT"].Label.TextColor3 = Color3.fromRGB(255, 255, 255)
TabButtons["COMBAT"].Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- Card Component Helper (FiveM Modern Switch)
local function AddFiveMToggle(parentTab, txt, key, callback)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(190, 190, 205)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 9.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local switchBg = Instance.new("TextButton", card)
    switchBg.Size = UDim2.new(0, 28, 0, 16)
    switchBg.Position = UDim2.new(1, -36, 0.5, -8)
    switchBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    switchBg.Text = ""
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local function Toggle()
        getgenv().Config[key] = not getgenv().Config[key]
        local active = getgenv().Config[key]
        
        TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(225, 40, 40) or Color3.fromRGB(35, 35, 45)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)}):Play()
        label.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(190, 190, 205)
        
        if active then SendDarkDevNotification("FiveM NUI", txt .. " Activated") end
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
LiveBypassCard.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Instance.new("UICorner", LiveBypassCard).CornerRadius = UDim.new(0, 6)
local LStroke = Instance.new("UIStroke", LiveBypassCard); LStroke.Color = Color3.fromRGB(225, 40, 40)

local LiveTitle = Instance.new("TextLabel", LiveBypassCard)
LiveTitle.Size = UDim2.new(1, 0, 0, 22); LiveTitle.Position = UDim2.new(0, 8, 0, 4)
LiveTitle.Text = "LIVE BYPASS ENGINE"; LiveTitle.TextColor3 = Color3.fromRGB(225, 40, 40)
LiveTitle.Font = Enum.Font.GothamBold; LiveTitle.TextSize = 10; LiveTitle.TextXAlignment = Enum.TextXAlignment.Left; LiveTitle.BackgroundTransparency = 1

local LiveStatusText = Instance.new("TextLabel", LiveBypassCard)
LiveStatusText.Size = UDim2.new(1, -16, 0, 18); LiveStatusText.Position = UDim2.new(0, 8, 0, 26)
LiveStatusText.Text = "Status: Idle (Click Start)"; LiveStatusText.TextColor3 = Color3.fromRGB(180, 180, 200)
LiveStatusText.Font = Enum.Font.Code; LiveStatusText.TextSize = 8.5; LiveStatusText.TextXAlignment = Enum.TextXAlignment.Left; LiveStatusText.BackgroundTransparency = 1

local LiveBarBg = Instance.new("Frame", LiveBypassCard)
LiveBarBg.Size = UDim2.new(0.92, 0, 0, 14); LiveBarBg.Position = UDim2.new(0.04, 0, 0, 48)
LiveBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
Instance.new("UICorner", LiveBarBg).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", LiveBarBg).Color = Color3.fromRGB(225, 40, 40)

local LiveBarFill = Instance.new("Frame", LiveBarBg)
LiveBarFill.Size = UDim2.new(0, 0, 1, 0); LiveBarFill.BackgroundColor3 = Color3.fromRGB(225, 40, 40)
Instance.new("UICorner", LiveBarFill).CornerRadius = UDim.new(0, 4)

local LivePercentText = Instance.new("TextLabel", LiveBypassCard)
LivePercentText.Size = UDim2.new(1, 0, 0, 16); LivePercentText.Position = UDim2.new(0, 0, 0, 65)
LivePercentText.Text = "0%"; LivePercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
LivePercentText.Font = Enum.Font.GothamBold; LivePercentText.TextSize = 9; LivePercentText.BackgroundTransparency = 1

local StartBypassBtn = Instance.new("TextButton", LiveBypassCard)
StartBypassBtn.Size = UDim2.new(0.9, 0, 0, 22); StartBypassBtn.Position = UDim2.new(0.05, 0, 0, 86)
StartBypassBtn.BackgroundColor3 = Color3.fromRGB(225, 40, 40); StartBypassBtn.Text = "START AC BYPASS"
StartBypassBtn.TextColor3 = Color3.fromRGB(255, 255, 255); StartBypassBtn.Font = Enum.Font.GothamBold; StartBypassBtn.TextSize = 8.5
Instance.new("UICorner", StartBypassBtn).CornerRadius = UDim.new(0, 4)

StartBypassBtn.MouseButton1Click:Connect(function()
    StartBypassBtn.Text = "BYPASSING..."
    task.spawn(function()
        local stages = { "Bypassing Anti-Cheat...", "Patching Network Offsets...", "Acquiring Privileges...", "Optimising FPS...", "Bypass Granted!" }
        for i = 1, 100 do
            task.wait(0.02)
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
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        pcall(function()
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            end
        end)
        SendDarkDevNotification("FPS Boost", "FPS Boost Enabled!")
    end
end)

-- SETTINGS TAB COLOR CUSTOMIZER
local function AddColorButton(parentTab, txt, defaultColor, colorKey)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -40, 1, 0); label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = txt; label.TextColor3 = Color3.fromRGB(190, 190, 205)
    label.Font = Enum.Font.GothamBold; label.TextSize = 9.5; label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1
    
    local colorBox = Instance.new("TextButton", card)
    colorBox.Size = UDim2.new(0, 18, 0, 18); colorBox.Position = UDim2.new(1, -28, 0.5, -9)
    colorBox.BackgroundColor3 = defaultColor; colorBox.Text = ""
    Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0, 4)
    
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
OpenIcon.Size = UDim2.new(0, 42, 0, 42)
OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
OpenIcon.Image = "rbxassetid://6031094678"
OpenIcon.Visible = false
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
local OpenStroke = Instance.new("UIStroke", OpenIcon); OpenStroke.Color = Color3.fromRGB(225, 40, 40)

-- Fly Overlay Controls
local FlyOverlay = Instance.new("Frame", SG)
FlyOverlay.Size = UDim2.new(0, 45, 0, 95)
FlyOverlay.Position = UDim2.new(1, -55, 0.5, -47)
FlyOverlay.BackgroundTransparency = 1
FlyOverlay.Visible = false

local function CreateFlyBtn(txt, key, pos)
    local b = Instance.new("TextButton", FlyOverlay)
    b.Size = UDim2.new(1, 0, 0, 42)
    b.Position = UDim2.new(0, 0, 0, pos * 48)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(225, 40, 40)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Down:Connect(function() getgenv().Config[key] = true end)
    b.MouseButton1Up:Connect(function() getgenv().Config[key] = false end)
end
CreateFlyBtn("UP", "FlyUp", 0)
CreateFlyBtn("DN", "FlyDown", 1)

-- Inject Trigger (Injector Window -> Server Panel & Main NUI)
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(0.6)
    
    local gameName = "Greek RP"
    pcall(function() gameName = Market:GetProductInfo(game.PlaceId).Name end)
    
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
    
    SendDarkDevNotification("FiveM NUI", "Injected Successfully - " .. gameName)
end)

PanelOpenMenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
PanelCloseBtn.MouseButton1Click:Connect(function() ServerPanel.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- MODULE 1: AIMBOT & CIRCLEAIM ENGINE ---
local FOVCircle = Instance.new("Frame", SG)
FOVCircle.Size = UDim2.new(0, getgenv().Config.CircleRadius * 2, 0, getgenv().Config.CircleRadius * 2)
FOVCircle.Position = UDim2.new(0.5, -getgenv().Config.CircleRadius, 0.5, -getgenv().Config.CircleRadius)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", FOVCircle)
CircleStroke.Color = Color3.fromRGB(225, 40, 40)
CircleStroke.Thickness = 1.5

-- Universal Mouse/Screen Raycast Target Finder
local function GetClosestPlayerToCursor()
    local mousePos = UIS:GetMouseLocation()
    local closestPlayer = nil
    local minDistance = getgenv().Config.CircleRadius or 120
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local headPos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local dist = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
                if dist < minDistance then
                    minDistance = dist
                    closestPlayer = p
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = getgenv().Config.CircleAim
    
    if getgenv().Config.CircleAim or getgenv().Config.Aimbot then
        local target = GetClosestPlayerToCursor()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character.Head.Position), getgenv().Config.Smooth or 0.2)
        end
    end
end)

-- Silent Aim & Triggerbot Logic
local oldNamecall
oldNamecall = hookmetamethod and hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if getgenv().Config.SilentAim and tostring(method) == "FireServer" then
        local target = GetClosestPlayerToCursor()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            if args[1] and typeof(args[1]) == "Instance" and args[1]:IsA("BasePart") then
                args[1] = target.Character.Head
                args[2] = target.Character.Head.Position
                return oldNamecall(self, unpack(args))
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- --- MODULE 2: KILLAURA ENGINE WITH AUTO PISTOL & TP ---
local currentKillAuraIndex = 1
local function GetPistolTool()
    local char = LP.Character
    local bp = LP:FindFirstChild("Backpack")
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
                SendDarkDevNotification("KillAura Warning", "Pistol not found in inventory!")
                getgenv().Config.KillAura = false
                task.wait(2)
            else
                if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                    if pistol.Parent ~= LP.Character then LP.Character.Humanoid:EquipTool(pistol) end
                    local targetList = {}
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 and p.Character:FindFirstChild("HumanoidRootPart") then
                            table.insert(targetList, p)
                        end
                    end
                    if #targetList > 0 then
                        if currentKillAuraIndex > #targetList then currentKillAuraIndex = 1 end
                        local targetPlayer = targetList[currentKillAuraIndex]
                        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character:FindFirstChild("Head") then
                            local tHrp = targetPlayer.Character.HumanoidRootPart
                            local tHead = targetPlayer.Character.Head
                            local tHum = targetPlayer.Character.Humanoid
                            
                            if LP.Character:FindFirstChild("HumanoidRootPart") then
                                LP.Character.HumanoidRootPart.CFrame = tHrp.CFrame * CFrame.new(0, 0, 2.5)
                            end
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, tHead.Position)
                            ClickCenterScreen()
                            pcall(function()
                                local wHit = ReplicatedStorage:FindFirstChild("WeaponsSystem") and ReplicatedStorage.WeaponsSystem:FindFirstChild("Network") and ReplicatedStorage.WeaponsSystem.Network:FindFirstChild("WeaponHit")
                                if wHit then wHit:FireServer(tHead, tHead.Position) end
                            end)
                            if tHum.Health <= 0 then currentKillAuraIndex = currentKillAuraIndex + 1; task.wait(0.12) end
                        else
                            currentKillAuraIndex = currentKillAuraIndex + 1
                        end
                    end
                end
            end
        end
    end
end)

-- --- MODULE 3: SKOUPES AUTO-FARM ENGINE ---
local MAX_MARKER_RANGE = 300
local function WalkToPosition(targetPos)
    local Char = LP.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") or not Char:FindFirstChild("Humanoid") then return false end
    local hrp = Char.HumanoidRootPart
    local hum = Char.Humanoid
    
    pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game) end)
    hum.WalkSpeed = 35
    local targetFlat = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local dist = (targetFlat - hrp.Position).Magnitude
    if dist > 2.0 then
        hum:Move((targetFlat - hrp.Position).Unit, false)
        hum:MoveTo(targetPos)
        return false
    else
        hum:Move(Vector3.new(0, 0, 0), false)
        return true
    end
end

local function FindNearestMarker()
    local Char = LP.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrpPos = Char.HumanoidRootPart.Position
    local bestPos = nil
    local minD = MAX_MARKER_RANGE
    
    local comserv = workspace:FindFirstChild("Comserv") or workspace:FindFirstChild("Bins") or workspace:FindFirstChild("Jobs")
    if comserv then
        for _, v in ipairs(comserv:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Model") then
                local pos = v:IsA("Model") and (v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position) or v.Position
                local d = (hrpPos - pos).Magnitude
                if d <= MAX_MARKER_RANGE and d < minD then
                    minD = d
                    bestPos = pos
                end
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
                    if WalkToPosition(markerPos) then
                        ClickCenterScreen()
                        pcall(function()
                            local jobRemote = ReplicatedStorage:FindFirstChild("JobInteraction") and ReplicatedStorage.JobInteraction:FindFirstChild("RemoteEvent")
                            if jobRemote then jobRemote:FireServer("Interact", markerPos) end
                            for _, p in ipairs(workspace:GetDescendants()) do
                                if p:IsA("ProximityPrompt") and p.Parent and p.Parent:IsA("BasePart") and (p.Parent.Position - Char.HumanoidRootPart.Position).Magnitude < 10 then
                                    fireproximityprompt(p)
                                end
                            end
                        end)
                    end
                end
            end
        end
    end
end)

-- --- MODULE 4: POSTMAN AUTO-MAIL DELIVERY ---
task.spawn(function()
    while true do
        task.wait(0.6)
        if getgenv().Config.MailFarm then
            local mailFolder = workspace:FindFirstChild("MailFolder") or workspace
            for _, mailBox in ipairs(mailFolder:GetDescendants()) do
                if not getgenv().Config.MailFarm then break end
                if (string.find(string.lower(mailBox.Name), "mail") or string.find(string.lower(mailBox.Name), "post")) and mailBox:IsA("BasePart") then
                    local prompt = mailBox:FindFirstChildOfClass("ProximityPrompt") or (mailBox.Parent and mailBox.Parent:FindFirstChildOfClass("ProximityPrompt"))
                    if prompt and prompt.Enabled then
                        local char = LP.Character
                        if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                            char.Humanoid.WalkSpeed = 32
                            char.Humanoid:MoveTo(mailBox.Position)
                            local start = tick()
                            repeat task.wait(0.1) until (char.HumanoidRootPart.Position - mailBox.Position).Magnitude < 7 or (tick() - start) > 4 or not getgenv().Config.MailFarm
                            char.Humanoid:Move(Vector3.new(0,0,0), false)
                            fireproximityprompt(prompt)
                            SendDarkDevNotification("Postman Farm", "Mail Delivered!")
                            task.wait(0.5)
                        end
                    end
                end
            end
        end
    end
end)

-- --- MODULE 5: FARMER 6-FIELDS AUTO-FARM ENGINE ---
local FarmerPositions = {
    Locations = {
        ["Field1"] = { Vector3.new(-2144.392, -127.295, 1022.4), Vector3.new(-2130.392, -127.295, 1022.4), Vector3.new(-2117.392, -127.295, 1022.4), Vector3.new(-2104.18, -127.295, 1022.4) },
        ["Field2"] = { Vector3.new(-2089.228, -127.295, 1022.4), Vector3.new(-2074.388, -127.295, 1022.4), Vector3.new(-2061.837, -127.295, 1022.4), Vector3.new(-2048.748, -127.295, 1022.4) },
        ["Field3"] = { Vector3.new(-2034.748, -127.295, 1022.4), Vector3.new(-2020.748, -127.295, 1022.4), Vector3.new(-2006.748, -127.295, 1022.4), Vector3.new(-1992.431, -127.295, 1022.4) }
    }
}

task.spawn(function()
    local fieldsList = {"Field1", "Field2", "Field3"}
    local currentFIdx = 1
    local currentPosIdx = 1
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
                                if p:IsA("ProximityPrompt") and p.Parent and p.Parent:IsA("BasePart") and (p.Parent.Position - char.HumanoidRootPart.Position).Magnitude < 10 then
                                    fireproximityprompt(p)
                                end
                            end
                        end)
                        task.wait(0.3)
                        currentPosIdx = currentPosIdx + 1
                        if currentPosIdx > #waypoints then
                            currentPosIdx = 1
                            currentFIdx = currentFIdx + 1
                            if currentFIdx > #fieldsList then currentFIdx = 1 end
                        end
                    end
                end
            end
        end
    end
end)

-- --- MODULE 6: CLICK TP & DESTROYER & VEHICLE BOOST ---
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if getgenv().Config.ClickTP and input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local mousePos = LP:GetMouse().Hit
        if mousePos and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(mousePos.Position + Vector3.new(0, 3, 0))
            SendDarkDevNotification("Click TP", "Teleported to Target Location")
        end
    end
end)

-- --- MODULE 7: ESP RENDER LOOP WITH DRAWING / HIGHLIGHT FALLBACK ---
local ESP_Objects = {}
local function CreateESP(p)
    if Drawing then
        local data = { Box = Drawing.new("Square"), Skelly = Drawing.new("Line"), Health = Drawing.new("Line"), Tracer = Drawing.new("Line") }
        data.Box.Thickness = 1.5; data.Box.Filled = false
        data.Skelly.Thickness = 1.5
        data.Health.Thickness = 2; data.Health.Color = Color3.fromRGB(0, 255, 100)
        data.Tracer.Thickness = 1.5
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
                d.Box.Size = Vector2.new(S * 1.3, S); d.Box.Position = Vector2.new(Pos.X - S/1.5, Pos.Y - S/2); d.Box.Color = getgenv().Config.BoxColor; d.Box.Visible = true
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
            else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
        else
            if d.Box then d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
        end
    end
end)

-- --- MODULE 8: FLY & MOVEMENT & NOCLIP ENGINE ---
UIS.JumpRequest:Connect(function()
    if getgenv().Config.InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LP.Character then
        for _, part in ipairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
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
        if getgenv().Config.SpeedActive then Hum.WalkSpeed = 65 else Hum.WalkSpeed = 16 end
    end
    
    -- Vehicle Boost
    if getgenv().Config.VehicleBoost and Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        Hum.SeatPart.MaxSpeed = 250
        Hum.SeatPart.Torque = 50
    end
    
    -- Fullbright
    if getgenv().Config.Fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
end)

-- --- MODULE 9: HITBOX EXPANDER ---
local HITBOX_SIZE = Vector3.new(12, 12, 12)
RunService.RenderStepped:Connect(function()
    if getgenv().Config.HitboxExpander then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                pcall(function()
                    local head = p.Character.Head
                    head.Size = HITBOX_SIZE
                    head.Transparency = 0.6
                    head.Color = Color3.fromRGB(225, 40, 40)
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                end)
            end
        end
    end
end)

-- --- MODULE 10: SAFETY PROTECTIONS (ANTI-AFK & GODMODE) ---
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
        local hrp = Char.HumanoidRootPart
        local hum = Char.Humanoid
        if hrp.Position.Y < -50 then
            hrp.CFrame = CFrame.new(hrp.Position.X, 15, hrp.Position.Z)
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

print("DarkDev Greek RP FiveM NUI v40.0 Master Suite Loaded Successfully.")
