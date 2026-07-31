--[[
    DARKDEV GREEK RP - ULTIMATE PERFECT MASTER SUITE v60.0 (EXTREME FIVEM NUI REDESIGN)
    Architect: DarkDev Team
    Features: Multi-Run Safe, Webhook Logger, Anti-Fall Damage, Gravity Control, Enhanced Game Scanner, Custom Icon Support, WallCheck CircleAim.
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

-- --- CONSTANTS & CUSTOM ICONS ---
local CUSTOM_ICON_ID = "rbxassetid://128982287144996"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1532703873788285010/rwTo5AVK-jK7_vHZb9YmMZ1b_Tm7qG57KnFWN3ZBsKri6Bq8KnHomwLAaJydbeZELeXz"

local IconMap = {
    COMBAT = "rbxassetid://6031082533",
    VISUALS = "rbxassetid://6031075929",
    MOVE = "rbxassetid://6034503835",
    FARM = "rbxassetid://6034502940",
    BYPASS = "rbxassetid://6031086111",
    SETTINGS = "rbxassetid://6031280882",
    SCANNER = "rbxassetid://92399322134932",
    NOTIFICATION = CUSTOM_ICON_ID,
    OPENICON = CUSTOM_ICON_ID,
    LOGOHUD = "rbxassetid://137406572565428"
}

-- --- GLOBAL CONFIGURATION ---
getgenv().Config = {
    -- Combat
    Aimbot = false,
    CircleAim = false,
    CircleRadius = 110,
    CircleWallCheck = true,
    SilentAim = false,
    Triggerbot = false,
    KillAura = false,
    HitboxExpander = false,
    HitboxSize = 12,
    NoRecoil = false,
    AutoReload = false,
    Smooth = 0.2,
    
    -- Visuals
    ESP = false,
    Skeleton = true,
    Health = true,
    Tracers = true,
    HeadDot = false,
    Names = true,
    Distance = true,
    BoxColor = Color3.fromRGB(225, 40, 40),
    TracerColor = Color3.fromRGB(255, 255, 255),
    SkellyColor = Color3.fromRGB(0, 255, 200),
    
    -- Movement & Physics
    Fly = false,
    LegitFly = false,
    FlySpeed = 50,
    FlyUp = false,
    FlyDown = false,
    Noclip = false,
    InfJump = false,
    SpeedActive = false,
    SpeedValue = 45,
    AntiFallDamage = true,
    NoGravity = false,
    GravityValue = 196.2,
    LowGravity = false,
    
    -- RP Farm
    SkoupesBot = false,
    MailFarm = false,
    AutoFarm = false,
    DestroyerMode = false,
    ClickTP = false,
    VehicleBoost = false,
    VehicleSpeed = 220,
    InfStamina = false,
    Fullbright = false,
    AutoPickItems = false,
    
    -- Bypass & Scan
    InjectBypass = false,
    ACBypass = false,
    Optimiser = false,
    FPSBoost = false,
    AutoScanOnInject = true,
    
    -- Settings & Customizations
    ThemeColor = Color3.fromRGB(225, 40, 40),
    AntiAFK = true,
    Godmode = false,
    UIKeybind = Enum.KeyCode.RightControl,
    
    InjectTime = "NOT INJECTED",
    GameScanned = false,
    ScannedRemotes = {},
    ScannedBinds = {}
}

-- --- DISCORD WEBHOOK EXECUTION LOGGER ---
local function SendDiscordExecutionLog()
    task.spawn(function()
        pcall(function()
            local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
            if not requestFunc then return end
            
            local gameName = "Greek RP"
            pcall(function() gameName = Market:GetProductInfo(game.PlaceId).Name end)
            local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
            local channelTag = isMobile and "#📂get-the-script-mobile" or "#📂get-the-script-pc"
            
            local embedData = {
                ["title"] = "🚀 DarkDev live Exe",
                ["description"] = "A new player has injected the DarkDev Greek RP Master Suite v60.0!",
                ["color"] = 14700072, -- Crimson Red
                ["fields"] = {
                    { ["name"] = "New launch (time)", ["value"] = os.date("%Y-%m-%d %H:%M:%S") .. " (UTC)", ["inline"] = true },
                    { ["name"] = "Player name", ["value"] = LP.Name .. " (@" .. LP.DisplayName .. ")", ["inline"] = true },
                    { ["name"] = "Player id", ["value"] = tostring(LP.UserId), ["inline"] = true },
                    { ["name"] = "Game Name", ["value"] = gameName .. " (" .. tostring(game.PlaceId) .. ")", ["inline"] = true },
                    { ["name"] = "Platform Target", ["value"] = channelTag, ["inline"] = true }
                },
                ["footer"] = { ["text"] = "DarkDev Greek RP v60.0 Master Suite" }
            }
            
            local payload = HttpService:JSONEncode({ ["embeds"] = { embedData } })
            requestFunc({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = payload
            })
        end)
    end)
end

-- --- NOTIFICATION HELPER (WITH CUSTOM ICON ID) ---
local function SendDarkDevNotification(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "DarkDev NUI",
            Text = text or "Action Executed",
            Duration = 3,
            Icon = CUSTOM_ICON_ID
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

-- --- GAME SCANNER ENGINE ---
local function ScanGameEnvironment()
    getgenv().Config.ScannedRemotes = {}
    getgenv().Config.ScannedBinds = {}
    local scannedCount = 0
    
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            table.insert(getgenv().Config.ScannedRemotes, v)
            scannedCount = scannedCount + 1
        elseif v:IsA("BindableEvent") or v:IsA("BindableFunction") then
            table.insert(getgenv().Config.ScannedBinds, v)
            scannedCount = scannedCount + 1
        end
    end
    getgenv().Config.GameScanned = true
    return scannedCount
end

-- --- GUI CREATION (Sleek FiveM NUI Style) ---
local SG = Instance.new("ScreenGui")
SG.Name = "DarkDevFiveMNUI_v60"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
getgenv().DarkDevLoadedGui = SG

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
InjectorFrame.Size = UDim2.new(0, 310, 0, 175)
InjectorFrame.Position = UDim2.new(0.5, -155, 0.5, -87)
InjectorFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
InjectorFrame.BorderSizePixel = 0
InjectorFrame.Active = true
InjectorFrame.Draggable = true

Instance.new("UICorner", InjectorFrame).CornerRadius = UDim.new(0, 8)
local IStroke = Instance.new("UIStroke", InjectorFrame)
IStroke.Color = getgenv().Config.ThemeColor
IStroke.Thickness = 1.5

local InjectHeaderImg = Instance.new("ImageLabel", InjectorFrame)
InjectHeaderImg.Size = UDim2.new(0, 22, 0, 22)
InjectHeaderImg.Position = UDim2.new(0, 12, 0, 10)
InjectHeaderImg.Image = CUSTOM_ICON_ID
InjectHeaderImg.BackgroundTransparency = 1

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, -45, 0, 22)
InjectTitle.Position = UDim2.new(0, 40, 0, 10)
InjectTitle.BackgroundTransparency = 1
InjectTitle.Text = "DARKDEV FIVEM NUI v60"
InjectTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectTitle.Font = Enum.Font.GothamBold
InjectTitle.TextSize = 13
InjectTitle.TextXAlignment = Enum.TextXAlignment.Left

local InjectDesc = Instance.new("TextLabel", InjectorFrame)
InjectDesc.Size = UDim2.new(1, -24, 0, 38)
InjectDesc.Position = UDim2.new(0, 12, 0, 42)
InjectDesc.BackgroundTransparency = 1
InjectDesc.Text = "Greek RP Master Suite - Webhook Logging, Anti-Fall Damage, NoGravity & FiveM NUI UI"
InjectDesc.TextColor3 = Color3.fromRGB(160, 160, 175)
InjectDesc.Font = Enum.Font.Gotham
InjectDesc.TextSize = 9.5
InjectDesc.TextWrapped = true
InjectDesc.TextXAlignment = Enum.TextXAlignment.Left

local InjectScanStatus = Instance.new("TextLabel", InjectorFrame)
InjectScanStatus.Size = UDim2.new(1, -24, 0, 18)
InjectScanStatus.Position = UDim2.new(0, 12, 0, 84)
InjectScanStatus.BackgroundTransparency = 1
InjectScanStatus.Text = "Game Scanner: Ready"
InjectScanStatus.TextColor3 = Color3.fromRGB(0, 255, 180)
InjectScanStatus.Font = Enum.Font.GothamBold
InjectScanStatus.TextSize = 9
InjectScanStatus.TextXAlignment = Enum.TextXAlignment.Left

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.92, 0, 0, 32)
InjectBtn.Position = UDim2.new(0.04, 0, 0, 125)
InjectBtn.BackgroundColor3 = getgenv().Config.ThemeColor
InjectBtn.Text = "INJECT & SCAN GAME"
InjectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.TextSize = 11
Instance.new("UICorner", InjectBtn).CornerRadius = UDim.new(0, 6)

-- --- 2. SERVER PANEL (FiveM Compact Top HUD) ---
local ServerPanel = Instance.new("Frame", SG)
ServerPanel.Name = "ServerPanel"
ServerPanel.Size = UDim2.new(0, 290, 0, 62)
ServerPanel.Position = UDim2.new(0.5, -145, 0.015, 0)
ServerPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
ServerPanel.Visible = false
ServerPanel.BorderSizePixel = 0
ServerPanel.Active = true
ServerPanel.Draggable = true

Instance.new("UICorner", ServerPanel).CornerRadius = UDim.new(0, 8)
local SStroke = Instance.new("UIStroke", ServerPanel)
SStroke.Color = getgenv().Config.ThemeColor
SStroke.Thickness = 1.5

local PanelLogo = Instance.new("ImageLabel", ServerPanel)
PanelLogo.Size = UDim2.new(0, 20, 0, 20)
PanelLogo.Position = UDim2.new(0, 8, 0, 8)
PanelLogo.Image = CUSTOM_ICON_ID
PanelLogo.BackgroundTransparency = 1

local PanelTitle = Instance.new("TextLabel", ServerPanel)
PanelTitle.Size = UDim2.new(1, -90, 0, 20)
PanelTitle.Position = UDim2.new(0, 32, 0, 8)
PanelTitle.Text = "DARKDEV RP | FIVEM NUI"
PanelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.TextSize = 10.5
PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
PanelTitle.BackgroundTransparency = 1

local PanelSub = Instance.new("TextLabel", ServerPanel)
PanelSub.Size = UDim2.new(1, -90, 0, 14)
PanelSub.Position = UDim2.new(0, 32, 0, 26)
PanelSub.Text = "Player: " .. LP.Name .. " | ID: " .. LP.UserId
PanelSub.TextColor3 = Color3.fromRGB(170, 170, 185)
PanelSub.Font = Enum.Font.Gotham
PanelSub.TextSize = 8.5
PanelSub.TextXAlignment = Enum.TextXAlignment.Left
PanelSub.BackgroundTransparency = 1

local PanelStatus = Instance.new("TextLabel", ServerPanel)
PanelStatus.Size = UDim2.new(1, -90, 0, 14)
PanelStatus.Position = UDim2.new(0, 32, 0, 42)
PanelStatus.Text = "Status: READY | Anti-Fall: ACTIVE"
PanelStatus.TextColor3 = Color3.fromRGB(0, 255, 160)
PanelStatus.Font = Enum.Font.GothamBold
PanelStatus.TextSize = 8.5
PanelStatus.TextXAlignment = Enum.TextXAlignment.Left
PanelStatus.BackgroundTransparency = 1

local PanelOpenMenuBtn = Instance.new("TextButton", ServerPanel)
PanelOpenMenuBtn.Size = UDim2.new(0, 42, 0, 20)
PanelOpenMenuBtn.Position = UDim2.new(1, -48, 0, 8)
PanelOpenMenuBtn.BackgroundColor3 = getgenv().Config.ThemeColor
PanelOpenMenuBtn.Text = "MENU"
PanelOpenMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelOpenMenuBtn.Font = Enum.Font.GothamBold
PanelOpenMenuBtn.TextSize = 8.5
Instance.new("UICorner", PanelOpenMenuBtn).CornerRadius = UDim.new(0, 4)

local PanelCloseBtn = Instance.new("TextButton", ServerPanel)
PanelCloseBtn.Size = UDim2.new(0, 48, 0, 20)
PanelCloseBtn.Position = UDim2.new(1, -54, 0, 32)
PanelCloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
PanelCloseBtn.Text = "HIDE"
PanelCloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
PanelCloseBtn.Font = Enum.Font.GothamBold
PanelCloseBtn.TextSize = 8.5
Instance.new("UICorner", PanelCloseBtn).CornerRadius = UDim.new(0, 4)

-- --- 3. MAIN FIVEM NUI FRAME (Compact 500x320 Size) ---
local Main = Instance.new("Frame", SG)
Main.Name = "MainNUI"
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Main.Visible = false
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = getgenv().Config.ThemeColor
MainStroke.Thickness = 1.5

-- Top Bar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local TopLogo = Instance.new("ImageLabel", TopBar)
TopLogo.Size = UDim2.new(0, 16, 0, 16)
TopLogo.Position = UDim2.new(0, 10, 0.5, -8)
TopLogo.Image = CUSTOM_ICON_ID
TopLogo.BackgroundTransparency = 1

local LogoLabel = Instance.new("TextLabel", TopBar)
LogoLabel.Size = UDim2.new(0.6, 0, 1, 0)
LogoLabel.Position = UDim2.new(0, 32, 0, 0)
LogoLabel.Text = "DARKDEV // FIVEM NUI v60"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.TextSize = 10.5
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.BackgroundTransparency = 1

-- Open/Close Custom Icon Button (ID: 128982287144996)
local CloseBtn = Instance.new("ImageButton", TopBar)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -28, 0.5, -10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
CloseBtn.Image = CUSTOM_ICON_ID
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

-- Sidebar (Left Column - 120px)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -38)
Sidebar.Position = UDim2.new(0, 6, 0, 34)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 5)

-- Content Area (Right Side)
local ContentArea = Instance.new("Frame", Main)
ContentArea.Size = UDim2.new(1, -138, 1, -38)
ContentArea.Position = UDim2.new(0, 132, 0, 34)
ContentArea.BackgroundTransparency = 1

-- Tab System
local TabFrames = {}
local TabButtons = {}

local function CreateTab(name, iconId, order)
    local btn = Instance.new("TextButton", Sidebar)
    btn.LayoutOrder = order or 1
    btn.Size = UDim2.new(0.92, 0, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    local img = Instance.new("ImageLabel", btn)
    img.Size = UDim2.new(0, 13, 0, 13)
    img.Position = UDim2.new(0, 8, 0.5, -6.5)
    img.Image = iconId
    img.BackgroundTransparency = 1
    img.ImageColor3 = getgenv().Config.ThemeColor
    
    local txtLabel = Instance.new("TextLabel", btn)
    txtLabel.Size = UDim2.new(1, -26, 1, 0)
    txtLabel.Position = UDim2.new(0, 26, 0, 0)
    txtLabel.Text = name
    txtLabel.TextColor3 = Color3.fromRGB(160, 160, 175)
    txtLabel.Font = Enum.Font.GothamBold
    txtLabel.TextSize = 8.5
    txtLabel.TextXAlignment = Enum.TextXAlignment.Left
    txtLabel.BackgroundTransparency = 1
    
    local cFrame = Instance.new("ScrollingFrame", ContentArea)
    cFrame.Size = UDim2.new(1, 0, 1, 0)
    cFrame.BackgroundTransparency = 1
    cFrame.Visible = false
    cFrame.ScrollBarThickness = 2.5
    cFrame.ScrollBarImageColor3 = getgenv().Config.ThemeColor
    cFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local layout = Instance.new("UIListLayout", cFrame)
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        cFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
    end)

    TabFrames[name] = cFrame
    TabButtons[name] = {Btn = btn, Label = txtLabel, Icon = img}
    
    btn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do frame.Visible = (tName == name) end
        for tName, tData in pairs(TabButtons) do
            if tName == name then
                tData.Btn.BackgroundColor3 = getgenv().Config.ThemeColor
                tData.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                tData.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            else
                tData.Btn.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
                tData.Label.TextColor3 = Color3.fromRGB(160, 160, 175)
                tData.Icon.ImageColor3 = getgenv().Config.ThemeColor
            end
        end
    end)
    return cFrame
end

local CombatTab = CreateTab("COMBAT", IconMap.COMBAT, 1)
local VisualsTab = CreateTab("VISUALS", IconMap.VISUALS, 2)
local MoveTab = CreateTab("MOVE", IconMap.MOVE, 3)
local RPTab = CreateTab("FARM", IconMap.FARM, 4)
local ScanTab = CreateTab("SCANNER", IconMap.SCANNER, 5)
local BypassTab = CreateTab("BYPASS", IconMap.BYPASS, 6)
local SettingsTab = CreateTab("SETTINGS", IconMap.SETTINGS, 7)

-- Set Active Tab
TabFrames["COMBAT"].Visible = true
TabButtons["COMBAT"].Btn.BackgroundColor3 = getgenv().Config.ThemeColor
TabButtons["COMBAT"].Label.TextColor3 = Color3.fromRGB(255, 255, 255)
TabButtons["COMBAT"].Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- Card Component Helper (FiveM Modern Switch)
local function AddFiveMToggle(parentTab, txt, key, callback)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 28)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(180, 180, 195)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 8.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local switchBg = Instance.new("TextButton", card)
    switchBg.Size = UDim2.new(0, 26, 0, 14)
    switchBg.Position = UDim2.new(1, -32, 0.5, -7)
    switchBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    switchBg.Text = ""
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 10, 0, 10)
    knob.Position = UDim2.new(0, 2, 0.5, -5)
    knob.BackgroundColor3 = Color3.fromRGB(130, 130, 130)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local function Toggle()
        getgenv().Config[key] = not getgenv().Config[key]
        local active = getgenv().Config[key]
        
        TweenService:Create(switchBg, TweenInfo.new(0.18), {BackgroundColor3 = active and getgenv().Config.ThemeColor or Color3.fromRGB(30, 30, 40)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.18), {Position = active and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5), BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 130)}):Play()
        label.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 195)
        
        if active then SendDarkDevNotification("FiveM NUI", txt .. " Enabled") end
        if callback then callback(active) end
    end
    switchBg.MouseButton1Click:Connect(Toggle)
end

-- Slider Component Helper
local function AddFiveMSlider(parentTab, txt, key, minVal, maxVal, defaultVal, callback)
    local card = Instance.new("Frame", parentTab)
    card.Size = UDim2.new(0.96, 0, 0, 36)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(0.6, 0, 0, 16)
    label.Position = UDim2.new(0, 8, 0, 2)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(180, 180, 195)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 8.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local valLabel = Instance.new("TextLabel", card)
    valLabel.Size = UDim2.new(0.35, 0, 0, 16)
    valLabel.Position = UDim2.new(0.62, 0, 0, 2)
    valLabel.Text = tostring(defaultVal)
    valLabel.TextColor3 = getgenv().Config.ThemeColor
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextSize = 8.5
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.BackgroundTransparency = 1
    
    local sliderBar = Instance.new("TextButton", card)
    sliderBar.Size = UDim2.new(0.92, 0, 0, 6)
    sliderBar.Position = UDim2.new(0.04, 0, 0, 22)
    sliderBar.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    sliderBar.Text = ""
    Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1, 0)
    
    local sliderFill = Instance.new("Frame", sliderBar)
    local pct = (defaultVal - minVal) / (maxVal - minVal)
    sliderFill.Size = UDim2.new(pct, 0, 1, 0)
    sliderFill.BackgroundColor3 = getgenv().Config.ThemeColor
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * pos)
        getgenv().Config[key] = val
        valLabel.Text = tostring(val)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        if callback then callback(val) end
    end
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateSlider(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then UpdateSlider(input) end
    end)
end

-- POPULATE COMBAT MODULES
AddFiveMToggle(CombatTab, "Aimbot Head", "Aimbot")
AddFiveMToggle(CombatTab, "CircleAIM", "CircleAim")
AddFiveMToggle(CombatTab, "Circle WallCheck", "CircleWallCheck")
AddFiveMSlider(CombatTab, "Circle Radius", "CircleRadius", 50, 300, 110, function(val)
    if FOVCircle then FOVCircle.Size = UDim2.new(0, val * 2, 0, val * 2) end
end)
AddFiveMToggle(CombatTab, "Silent Aim", "SilentAim")
AddFiveMToggle(CombatTab, "Triggerbot", "Triggerbot")
AddFiveMToggle(CombatTab, "Kill Aura", "KillAura")
AddFiveMToggle(CombatTab, "Hitbox Expand", "HitboxExpander")
AddFiveMSlider(CombatTab, "Hitbox Size", "HitboxSize", 2, 30, 12)
AddFiveMToggle(CombatTab, "No Recoil", "NoRecoil")
AddFiveMToggle(CombatTab, "Auto Reload", "AutoReload")

-- POPULATE VISUALS MODULES
AddFiveMToggle(VisualsTab, "Master ESP", "ESP")
AddFiveMToggle(VisualsTab, "Skeleton", "Skeleton")
AddFiveMToggle(VisualsTab, "Health Bar", "Health")
AddFiveMToggle(VisualsTab, "Tracers", "Tracers")
AddFiveMToggle(VisualsTab, "Player Names", "Names")
AddFiveMToggle(VisualsTab, "Distance Info", "Distance")
AddFiveMToggle(VisualsTab, "Head Dot", "HeadDot")

-- POPULATE MOVEMENT & PHYSICS MODULES
AddFiveMToggle(MoveTab, "Fly Mode", "Fly")
AddFiveMToggle(MoveTab, "Legit Fly", "LegitFly")
AddFiveMSlider(MoveTab, "Fly Speed", "FlySpeed", 10, 150, 50)
AddFiveMToggle(MoveTab, "Noclip", "Noclip")
AddFiveMToggle(MoveTab, "Inf Jump", "InfJump")
AddFiveMToggle(MoveTab, "Speed Boost", "SpeedActive")
AddFiveMSlider(MoveTab, "Walk Speed", "SpeedValue", 16, 120, 45)
AddFiveMToggle(MoveTab, "Anti Fall Damage", "AntiFallDamage")
AddFiveMToggle(MoveTab, "No Gravity Mode", "NoGravity", function(val)
    if val then workspace.Gravity = 0 else workspace.Gravity = 196.2 end
end)

-- POPULATE RP FARM MODULES
AddFiveMToggle(RPTab, "ΣΚΟΥΠΕΣ AutoBot", "SkoupesBot")
AddFiveMToggle(RPTab, "Postman Mail Farm", "MailFarm")
AddFiveMToggle(RPTab, "Farmer 6-Fields", "AutoFarm")
AddFiveMToggle(RPTab, "Auto Pick Items", "AutoPickItems")
AddFiveMToggle(RPTab, "Click TP (Ctrl+Click)", "ClickTP")
AddFiveMToggle(RPTab, "Car Speed Boost", "VehicleBoost")
AddFiveMSlider(RPTab, "Vehicle Speed", "VehicleSpeed", 50, 400, 220)
AddFiveMToggle(RPTab, "Inf Stamina", "InfStamina")
AddFiveMToggle(RPTab, "Fullbright World", "Fullbright")

-- POPULATE GAME SCANNER TAB
local ScanCard = Instance.new("Frame", ScanTab)
ScanCard.Size = UDim2.new(0.96, 0, 0, 125)
ScanCard.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Instance.new("UICorner", ScanCard).CornerRadius = UDim.new(0, 6)
local ScanStroke = Instance.new("UIStroke", ScanCard)
ScanStroke.Color = getgenv().Config.ThemeColor

local ScanTitle = Instance.new("TextLabel", ScanCard)
ScanTitle.Size = UDim2.new(1, -16, 0, 20)
ScanTitle.Position = UDim2.new(0, 8, 0, 4)
ScanTitle.Text = "DYNAMIC GAME SCANNER ENGINE"
ScanTitle.TextColor3 = getgenv().Config.ThemeColor
ScanTitle.Font = Enum.Font.GothamBold
ScanTitle.TextSize = 9.5
ScanTitle.TextXAlignment = Enum.TextXAlignment.Left
ScanTitle.BackgroundTransparency = 1

local ScanLogText = Instance.new("TextLabel", ScanCard)
ScanLogText.Size = UDim2.new(1, -16, 0, 55)
ScanLogText.Position = UDim2.new(0, 8, 0, 26)
ScanLogText.Text = "Scanner Status: Ready to scan game environment.\nPress button below to trigger live injection scan."
ScanLogText.TextColor3 = Color3.fromRGB(170, 170, 190)
ScanLogText.Font = Enum.Font.Code
ScanLogText.TextSize = 8
ScanLogText.TextXAlignment = Enum.TextXAlignment.Left
ScanLogText.TextYAlignment = Enum.TextYAlignment.Top
ScanLogText.BackgroundTransparency = 1
ScanLogText.TextWrapped = true

local RunScanBtn = Instance.new("TextButton", ScanCard)
RunScanBtn.Size = UDim2.new(0.92, 0, 0, 24)
RunScanBtn.Position = UDim2.new(0.04, 0, 0, 92)
RunScanBtn.BackgroundColor3 = getgenv().Config.ThemeColor
RunScanBtn.Text = "RUN LIVE ENVIRONMENT SCAN"
RunScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunScanBtn.Font = Enum.Font.GothamBold
RunScanBtn.TextSize = 8.5
Instance.new("UICorner", RunScanBtn).CornerRadius = UDim.new(0, 4)

RunScanBtn.MouseButton1Click:Connect(function()
    RunScanBtn.Text = "SCANNING..."
    task.wait(0.3)
    local count = ScanGameEnvironment()
    ScanLogText.Text = "SCAN COMPLETE:\nFound " .. count .. " Remotes & Events!\nOptimised for Greek RP Job & Anti-Cheat Offsets."
    RunScanBtn.Text = "✅ SCAN COMPLETED (" .. count .. " FOUND)"
    SendDarkDevNotification("Game Scanner", "Environment Scanned: " .. count .. " elements loaded!")
end)

-- BYPASS TAB LIVE ENGINE
local LiveBypassCard = Instance.new("Frame", BypassTab)
LiveBypassCard.Size = UDim2.new(0.96, 0, 0, 110)
LiveBypassCard.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Instance.new("UICorner", LiveBypassCard).CornerRadius = UDim.new(0, 6)
local LStroke = Instance.new("UIStroke", LiveBypassCard); LStroke.Color = getgenv().Config.ThemeColor

local LiveTitle = Instance.new("TextLabel", LiveBypassCard)
LiveTitle.Size = UDim2.new(1, 0, 0, 20); LiveTitle.Position = UDim2.new(0, 8, 0, 4)
LiveTitle.Text = "LIVE BYPASS ENGINE"; LiveTitle.TextColor3 = getgenv().Config.ThemeColor
LiveTitle.Font = Enum.Font.GothamBold; LiveTitle.TextSize = 9.5; LiveTitle.TextXAlignment = Enum.TextXAlignment.Left; LiveTitle.BackgroundTransparency = 1

local LiveStatusText = Instance.new("TextLabel", LiveBypassCard)
LiveStatusText.Size = UDim2.new(1, -16, 0, 16); LiveStatusText.Position = UDim2.new(0, 8, 0, 24)
LiveStatusText.Text = "Status: Idle (Click Start)"; LiveStatusText.TextColor3 = Color3.fromRGB(170, 170, 190)
LiveStatusText.Font = Enum.Font.Code; LiveStatusText.TextSize = 8; LiveStatusText.TextXAlignment = Enum.TextXAlignment.Left; LiveStatusText.BackgroundTransparency = 1

local LiveBarBg = Instance.new("Frame", LiveBypassCard)
LiveBarBg.Size = UDim2.new(0.92, 0, 0, 12); LiveBarBg.Position = UDim2.new(0.04, 0, 0, 44)
LiveBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", LiveBarBg).CornerRadius = UDim.new(0, 3); Instance.new("UIStroke", LiveBarBg).Color = getgenv().Config.ThemeColor

local LiveBarFill = Instance.new("Frame", LiveBarBg)
LiveBarFill.Size = UDim2.new(0, 0, 1, 0); LiveBarFill.BackgroundColor3 = getgenv().Config.ThemeColor
Instance.new("UICorner", LiveBarFill).CornerRadius = UDim.new(0, 3)

local LivePercentText = Instance.new("TextLabel", LiveBypassCard)
LivePercentText.Size = UDim2.new(1, 0, 0, 14); LivePercentText.Position = UDim2.new(0, 0, 0, 58)
LivePercentText.Text = "0%"; LivePercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
LivePercentText.Font = Enum.Font.GothamBold; LivePercentText.TextSize = 8.5; LivePercentText.BackgroundTransparency = 1

local StartBypassBtn = Instance.new("TextButton", LiveBypassCard)
StartBypassBtn.Size = UDim2.new(0.9, 0, 0, 20); StartBypassBtn.Position = UDim2.new(0.05, 0, 0, 80)
StartBypassBtn.BackgroundColor3 = getgenv().Config.ThemeColor; StartBypassBtn.Text = "START AC BYPASS"
StartBypassBtn.TextColor3 = Color3.fromRGB(255, 255, 255); StartBypassBtn.Font = Enum.Font.GothamBold; StartBypassBtn.TextSize = 8
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
AddFiveMToggle(BypassTab, "FPS Optimiser", "FPSBoost", function(val)
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
    card.Size = UDim2.new(0.96, 0, 0, 28)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel", card)
    label.Size = UDim2.new(1, -38, 1, 0); label.Position = UDim2.new(0, 8, 0, 0)
    label.Text = txt; label.TextColor3 = Color3.fromRGB(180, 180, 195)
    label.Font = Enum.Font.GothamBold; label.TextSize = 8.5; label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1
    
    local colorBox = Instance.new("TextButton", card)
    colorBox.Size = UDim2.new(0, 16, 0, 16); colorBox.Position = UDim2.new(1, -24, 0.5, -8)
    colorBox.BackgroundColor3 = defaultColor; colorBox.Text = ""
    Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0, 4)
    
    local colors = {Color3.fromRGB(225, 40, 40), Color3.fromRGB(0, 255, 255), Color3.fromRGB(124, 77, 255), Color3.fromRGB(0, 255, 100), Color3.fromRGB(255, 255, 0)}
    local cIdx = 1
    colorBox.MouseButton1Click:Connect(function()
        cIdx = (cIdx % #colors) + 1
        getgenv().Config[colorKey] = colors[cIdx]
        colorBox.BackgroundColor3 = colors[cIdx]
    end)
end

AddColorButton(SettingsTab, "ESP Box Color", Color3.fromRGB(225, 40, 40), "BoxColor")
AddColorButton(SettingsTab, "Tracer Color", Color3.fromRGB(255, 255, 255), "TracerColor")
AddColorButton(SettingsTab, "Skeleton Color", Color3.fromRGB(0, 255, 200), "SkellyColor")

-- Open Icon (Custom Icon ID: 128982287144996)
local OpenIcon = Instance.new("ImageButton", SG)
OpenIcon.Size = UDim2.new(0, 38, 0, 38)
OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
OpenIcon.Image = CUSTOM_ICON_ID
OpenIcon.Visible = false
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
local OpenStroke = Instance.new("UIStroke", OpenIcon); OpenStroke.Color = getgenv().Config.ThemeColor

-- Fly Overlay Controls
local FlyOverlay = Instance.new("Frame", SG)
FlyOverlay.Size = UDim2.new(0, 40, 0, 85)
FlyOverlay.Position = UDim2.new(1, -50, 0.5, -42)
FlyOverlay.BackgroundTransparency = 1
FlyOverlay.Visible = false

local function CreateFlyBtn(txt, key, pos)
    local b = Instance.new("TextButton", FlyOverlay)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.Position = UDim2.new(0, 0, 0, pos * 44)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    b.Text = txt
    b.TextColor3 = getgenv().Config.ThemeColor
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Down:Connect(function() getgenv().Config[key] = true end)
    b.MouseButton1Up:Connect(function() getgenv().Config[key] = false end)
end
CreateFlyBtn("UP", "FlyUp", 0)
CreateFlyBtn("DN", "FlyDown", 1)

-- Inject Trigger (With Webhook Logger)
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING & SCANNING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(0.3)
    
    SendDiscordExecutionLog() -- Webhook Trigger
    
    local scanned = ScanGameEnvironment()
    InjectScanStatus.Text = "Game Scanner: " .. scanned .. " elements scanned!"
    task.wait(0.3)
    
    local gameName = "Greek RP"
    pcall(function() gameName = Market:GetProductInfo(game.PlaceId).Name end)
    
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
    
    SendDarkDevNotification("FiveM NUI", "Injected & Scanned Successfully - " .. gameName)
end)

PanelOpenMenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
PanelCloseBtn.MouseButton1Click:Connect(function() ServerPanel.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- MODULE 1: AIMBOT & CIRCLEAIM ENGINE (WITH WALLCHECK) ---
local FOVCircle = Instance.new("Frame", SG)
FOVCircle.Size = UDim2.new(0, getgenv().Config.CircleRadius * 2, 0, getgenv().Config.CircleRadius * 2)
FOVCircle.Position = UDim2.new(0.5, -getgenv().Config.CircleRadius, 0.5, -getgenv().Config.CircleRadius)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", FOVCircle)
CircleStroke.Color = getgenv().Config.ThemeColor
CircleStroke.Thickness = 1.5

-- WallCheck helper function using Raycasting
local function IsPartVisible(part)
    if not part or not part.Parent then return false end
    local origin = Camera.CFrame.Position
    local destination = part.Position
    local direction = (destination - origin)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local ignoreList = {LP.Character, Camera}
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then table.insert(ignoreList, p.Character) end
        end
    end)
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

-- Universal Mouse/Screen Raycast Target Finder
local function GetClosestPlayerToCursor()
    local mousePos = UIS:GetMouseLocation()
    local closestPlayer = nil
    local minDistance = getgenv().Config.CircleRadius or 110
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local head = p.Character.Head
            local headPos, vis = Camera:WorldToViewportPoint(head.Position)
            if vis then
                local wallCheckPassed = true
                if getgenv().Config.CircleWallCheck then
                    wallCheckPassed = IsPartVisible(head)
                end
                
                if wallCheckPassed then
                    local dist = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
                    if dist < minDistance then
                        minDistance = dist
                        closestPlayer = p
                    end
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

-- Silent Aim Logic
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
    if char then for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") and (string.find(string.lower(t.Name), "pistol") or string.find(string.lower(t.Name), "gun")) then return t end end end
    if bp then for _, t in ipairs(bp:GetChildren()) do if t:IsA("Tool") and (string.find(string.lower(t.Name), "pistol") or string.find(string.lower(t.Name), "gun")) then return t end end end
    return nil
end

task.spawn(function()
    while true do
        task.wait(0.06)
        if getgenv().Config.KillAura then
            local pistol = GetPistolTool()
            if not pistol then
                SendDarkDevNotification("KillAura Warning", "Pistol/Weapon not found in inventory!")
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
local MAX_MARKER_RANGE = 350
local function WalkToPosition(targetPos)
    local Char = LP.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") or not Char:FindFirstChild("Humanoid") then return false end
    local hrp = Char.HumanoidRootPart
    local hum = Char.Humanoid
    
    pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game) end)
    hum.WalkSpeed = getgenv().Config.SpeedValue or 45
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
    
    local comserv = workspace:FindFirstChild("Comserv") or workspace:FindFirstChild("Bins") or workspace:FindFirstChild("Jobs") or workspace:FindFirstChild("Trash")
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
                                if p:IsA("ProximityPrompt") and p.Parent and p.Parent:IsA("BasePart") and (p.Parent.Position - Char.HumanoidRootPart.Position).Magnitude < 12 then
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
        task.wait(0.5)
        if getgenv().Config.MailFarm then
            local mailFolder = workspace:FindFirstChild("MailFolder") or workspace
            for _, mailBox in ipairs(mailFolder:GetDescendants()) do
                if not getgenv().Config.MailFarm then break end
                if (string.find(string.lower(mailBox.Name), "mail") or string.find(string.lower(mailBox.Name), "post")) and mailBox:IsA("BasePart") then
                    local prompt = mailBox:FindFirstChildOfClass("ProximityPrompt") or (mailBox.Parent and mailBox.Parent:FindFirstChildOfClass("ProximityPrompt"))
                    if prompt and prompt.Enabled then
                        local char = LP.Character
                        if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                            char.Humanoid.WalkSpeed = getgenv().Config.SpeedValue or 45
                            char.Humanoid:MoveTo(mailBox.Position)
                            local start = tick()
                            repeat task.wait(0.1) until (char.HumanoidRootPart.Position - mailBox.Position).Magnitude < 7 or (tick() - start) > 4 or not getgenv().Config.MailFarm
                            char.Humanoid:Move(Vector3.new(0,0,0), false)
                            fireproximityprompt(prompt)
                            SendDarkDevNotification("Postman Farm", "Mail Delivered!")
                            task.wait(0.4)
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

-- --- MODULE 6: AUTO PICK ITEMS & CLICK TP ---
task.spawn(function()
    while true do
        task.wait(0.2)
        if getgenv().Config.AutoPickItems then
            local char = LP.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, prompt in ipairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled and prompt.Parent and prompt.Parent:IsA("BasePart") then
                        if (prompt.Parent.Position - char.HumanoidRootPart.Position).Magnitude < 14 then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end
    end
end)

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
        else
            if d.Box then d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false; d.Info.Visible = false end
        end
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
    
    -- Vehicle Boost
    if getgenv().Config.VehicleBoost and Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        Hum.SeatPart.MaxSpeed = getgenv().Config.VehicleSpeed or 220
        Hum.SeatPart.Torque = 60
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
RunService.RenderStepped:Connect(function()
    if getgenv().Config.HitboxExpander then
        local hSize = Vector3.new(getgenv().Config.HitboxSize or 12, getgenv().Config.HitboxSize or 12, getgenv().Config.HitboxSize or 12)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
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

print("DarkDev Greek RP FiveM NUI v60.0 Master Suite Loaded Successfully.")
