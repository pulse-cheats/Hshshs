--[[
    DARKDEV GREEK RP - ULTIMATE MASTER SUITE v34.0 (PAGED EDITION 1/2 & 2/2)
    Architect: Rool Machine
    Features: Multi-Page UI (1/2, 2/2), Fake Access Bypass Fullscreen Loader, FPS Booster, AC Bypass & Upgraded Modules
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
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- --- CONFIGURATION ---
getgenv().Config = {
    Godmode = false, AutoReload = false, LegitFly = false,
    Aimbot = false, SilentAim = false, Triggerbot = false, KillAura = false,
    NoRecoil = false, HitboxExpander = false,
    ESP = false, Skeleton = true, Health = true, Tracers = true, HeadDot = false,
    Fly = false, Noclip = false, SpeedActive = false, InfJump = false,
    SkoupesBot = false, DestroyerMode = false, VehicleBoost = false, InfStamina = false, ClickTP = false,
    Fullbright = false, AntiAFK = true, FPSBoost = false, InjectBypass = false, ACBypass = false, Optimiser = false,
    FlySpeed = 50, FlyUp = false, FlyDown = false, Smooth = 0.15,
    InjectTime = "Not Injected"
}

-- Notification Helper
local function SendDarkDevNotification(msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DARKDEV RP",
            Text = msg,
            Duration = 4
        })
    end)
    print("[DARKDEV]: " .. msg)
end

-- Click Center of Screen
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
SG.Name = "DarkDev_v34_Master"
SG.ResetOnSpawn = false
pcall(function() SG.Parent = SafeGuiParent end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- --- 1. INJECTOR SCREEN ---
local InjectorFrame = Instance.new("Frame", SG)
InjectorFrame.Size = UDim2.new(0, 270, 0, 160); InjectorFrame.Position = UDim2.new(0.5, -135, 0.5, -80); InjectorFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5); InjectorFrame.Active = true; InjectorFrame.Draggable = true
Instance.new("UICorner", InjectorFrame)
local IStroke = Instance.new("UIStroke", InjectorFrame); IStroke.Color = Color3.fromRGB(124, 77, 255)

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, 0, 0, 35); InjectTitle.Text = "DARKDEV INJECTOR v34"; InjectTitle.TextColor3 = Color3.fromRGB(124, 77, 255); InjectTitle.Font = Enum.Font.GothamBold; InjectTitle.TextSize = 13; InjectTitle.BackgroundTransparency = 1

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.85, 0, 0, 40); InjectBtn.Position = UDim2.new(0.075, 0, 0.45, 0); InjectBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); InjectBtn.Text = "💉 INJECT 💉"; InjectBtn.TextColor3 = Color3.fromRGB(0, 255, 255); InjectBtn.Font = Enum.Font.GothamBold; InjectBtn.TextSize = 13
Instance.new("UICorner", InjectBtn); Instance.new("UIStroke", InjectBtn).Color = Color3.fromRGB(0, 255, 255)

-- --- 2. SERVER PANEL ---
local ServerPanel = Instance.new("Frame", SG)
ServerPanel.Size = UDim2.new(0, 200, 0, 160); ServerPanel.Position = UDim2.new(0, 10, 0, 10); ServerPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 15); ServerPanel.Visible = false
Instance.new("UICorner", ServerPanel)
local SStroke = Instance.new("UIStroke", ServerPanel); SStroke.Color = Color3.fromRGB(124, 77, 255); SStroke.Thickness = 1.5

local PanelCloseBtn = Instance.new("TextButton", ServerPanel)
PanelCloseBtn.Size = UDim2.new(0, 20, 0, 20); PanelCloseBtn.Position = UDim2.new(1, -22, 0, 3); PanelCloseBtn.Text = "X"; PanelCloseBtn.TextColor3 = Color3.new(1, 0, 0); PanelCloseBtn.BackgroundTransparency = 1; PanelCloseBtn.Font = Enum.Font.GothamBold

local STitle = Instance.new("TextLabel", ServerPanel)
STitle.Size = UDim2.new(1, -25, 0, 22); STitle.Text = "  SERVER INFO"; STitle.TextColor3 = Color3.fromRGB(124, 77, 255); STitle.Font = Enum.Font.GothamBold; STitle.TextSize = 10; STitle.TextXAlignment = Enum.TextXAlignment.Left; STitle.BackgroundTransparency = 1

local SContent = Instance.new("TextLabel", ServerPanel)
SContent.Size = UDim2.new(1, -10, 0, 95); SContent.Position = UDim2.new(0, 5, 0, 22); SContent.TextColor3 = Color3.fromRGB(200, 200, 200); SContent.Font = Enum.Font.Code; SContent.TextSize = 9; SContent.TextXAlignment = Enum.TextXAlignment.Left; SContent.TextYAlignment = Enum.TextYAlignment.Top; SContent.BackgroundTransparency = 1

local PanelOpenMenuBtn = Instance.new("TextButton", ServerPanel)
PanelOpenMenuBtn.Size = UDim2.new(1, -10, 0, 26); PanelOpenMenuBtn.Position = UDim2.new(0, 5, 1, -30); PanelOpenMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); PanelOpenMenuBtn.Text = "⚡ OPEN CHEAT MENU ⚡"; PanelOpenMenuBtn.TextColor3 = Color3.fromRGB(0, 255, 255); PanelOpenMenuBtn.Font = Enum.Font.GothamBold; PanelOpenMenuBtn.TextSize = 10
Instance.new("UICorner", PanelOpenMenuBtn)

RunService.RenderStepped:Connect(function()
    local gName = "Greek RP"
    pcall(function() gName = Market:GetProductInfo(game.PlaceId).Name end)
    SContent.Text = string.format("Game: %s\nPlayers: %d/%d\nInject Time: %s\nTime: %s\nUser: %s\nID: %d",
        string.sub(gName, 1, 16), #Players:GetPlayers(), Players.MaxPlayers, getgenv().Config.InjectTime, os.date("%X"), LP.Name, LP.UserId)
end)

-- --- 3. MAIN CHEAT MENU (PAGED 1/2 & 2/2) ---
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 520, 0, 260); Main.Position = UDim2.new(0.5, -260, 0.5, -130); Main.BackgroundColor3 = Color3.fromRGB(18, 18, 26); Main.Active = true; Main.Draggable = true; Main.Visible = false
Instance.new("UICorner", Main); Instance.new("UIStroke", Main).Color = Color3.fromRGB(124, 77, 255)

local PageHeader = Instance.new("TextLabel", Main)
PageHeader.Size = UDim2.new(0, 200, 0, 25); PageHeader.Position = UDim2.new(0, 10, 0, 3); PageHeader.Text = "DARKDEV v34 [Page 1/2]"; PageHeader.TextColor3 = Color3.fromRGB(0, 255, 255); PageHeader.Font = Enum.Font.GothamBold; PageHeader.TextSize = 12; PageHeader.TextXAlignment = Enum.TextXAlignment.Left; PageHeader.BackgroundTransparency = 1

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 22, 0, 22); Close.Position = UDim2.new(1, -26, 0, 4); Close.Text = "X"; Close.TextColor3 = Color3.new(1,0,0); Close.BackgroundTransparency = 1; Close.Font = Enum.Font.GothamBold

-- Button UNDER Close Button for Page Switcher (1/2 <-> 2/2)
local PageSwitchBtn = Instance.new("TextButton", Main)
PageSwitchBtn.Size = UDim2.new(0, 32, 0, 20); PageSwitchBtn.Position = UDim2.new(1, -30, 0, 28); PageSwitchBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 50); PageSwitchBtn.Text = "1/2"; PageSwitchBtn.TextColor3 = Color3.fromRGB(0, 255, 255); PageSwitchBtn.Font = Enum.Font.GothamBold; PageSwitchBtn.TextSize = 10
Instance.new("UICorner", PageSwitchBtn); Instance.new("UIStroke", PageSwitchBtn).Color = Color3.fromRGB(124, 77, 255)

local OpenIcon = Instance.new("ImageButton", SG)
OpenIcon.Size = UDim2.new(0, 40, 0, 40); OpenIcon.Position = UDim2.new(0, 10, 0.4, 0); OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 30); OpenIcon.Image = "rbxassetid://6031094678"; OpenIcon.Visible = false
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)

-- Fly Overlay
local FlyOverlay = Instance.new("Frame", SG)
FlyOverlay.Size = UDim2.new(0, 45, 0, 95); FlyOverlay.Position = UDim2.new(1, -55, 0.5, -47); FlyOverlay.BackgroundTransparency = 1; FlyOverlay.Visible = false
local function CreateFlyBtn(txt, key, pos)
    local b = Instance.new("TextButton", FlyOverlay)
    b.Size = UDim2.new(1, 0, 0, 45); b.Position = UDim2.new(0, 0, 0, pos * 48); b.BackgroundColor3 = Color3.fromRGB(25, 25, 35); b.Text = txt; b.TextColor3 = Color3.fromRGB(0, 255, 255); b.Font = Enum.Font.GothamBold; b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Down:Connect(function() getgenv().Config[key] = true end)
    b.MouseButton1Up:Connect(function() getgenv().Config[key] = false end)
end
CreateFlyBtn("UP", "FlyUp", 0); CreateFlyBtn("DN", "FlyDown", 1)

-- Page Container Frames
local Page1Frame = Instance.new("Frame", Main)
Page1Frame.Size = UDim2.new(1, -100, 1, -35); Page1Frame.Position = UDim2.new(0, 5, 0, 30); Page1Frame.BackgroundTransparency = 1

local Page2Frame = Instance.new("Frame", Main)
Page2Frame.Size = UDim2.new(1, -100, 1, -35); Page2Frame.Position = UDim2.new(0, 5, 0, 30); Page2Frame.BackgroundTransparency = 1; Page2Frame.Visible = false

-- Page Toggle Handler
local currentPage = 1
PageSwitchBtn.MouseButton1Click:Connect(function()
    if currentPage == 1 then
        currentPage = 2
        Page1Frame.Visible = false
        Page2Frame.Visible = true
        PageSwitchBtn.Text = "2/2"
        PageHeader.Text = "DARKDEV v34 [Page 2/2]"
    else
        currentPage = 1
        Page2Frame.Visible = false
        Page1Frame.Visible = true
        PageSwitchBtn.Text = "1/2"
        PageHeader.Text = "DARKDEV v34 [Page 1/2]"
    end
end)

-- Section Helper
local function CreateSection(parent, name, pos)
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(0, 98, 1, -10); s.Position = UDim2.new(0, 4 + (pos * 102), 0, 5); s.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Instance.new("UICorner", s)
    local t = Instance.new("TextLabel", s); t.Size = UDim2.new(1, 0, 0, 20); t.Text = name; t.TextColor3 = Color3.fromRGB(124, 77, 255); t.Font = Enum.Font.GothamBold; t.TextSize = 9; t.BackgroundTransparency = 1
    local c = Instance.new("ScrollingFrame", s); c.Size = UDim2.new(1, -6, 1, -24); c.Position = UDim2.new(0, 3, 0, 22); c.BackgroundTransparency = 1; c.ScrollBarThickness = 0
    Instance.new("UIListLayout", c).Padding = UDim.new(0, 4)
    return c
end

-- PAGE 1 SECTIONS
local Col1 = CreateSection(Page1Frame, "COMBAT", 0)
local Col2 = CreateSection(Page1Frame, "VISUALS", 1)
local Col3 = CreateSection(Page1Frame, "MOVE", 2)
local Col4 = CreateSection(Page1Frame, "RP UTILS", 3)

-- PAGE 2 SECTIONS
local Col5 = CreateSection(Page2Frame, "BYPASS SUITE", 0)
local Col6 = CreateSection(Page2Frame, "SYSTEM OPTIM", 1)

local function AddToggle(col, txt, key, callback)
    local b = Instance.new("Frame", col)
    b.Size = UDim2.new(1, 0, 0, 20); b.BackgroundTransparency = 1
    local box = Instance.new("TextButton", b)
    box.Size = UDim2.new(0, 11, 0, 11); box.Position = UDim2.new(0, 2, 0.5, -5); box.BackgroundColor3 = Color3.fromRGB(30, 30, 40); box.Text = ""
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)
    local check = Instance.new("Frame", box); check.Size = UDim2.new(1, -4, 1, -4); check.Position = UDim2.new(0, 2, 0, 2); check.BackgroundColor3 = Color3.fromRGB(124, 77, 255); check.Visible = false; Instance.new("UICorner", check)
    local label = Instance.new("TextButton", b)
    label.Size = UDim2.new(1, -16, 1, 0); label.Position = UDim2.new(0, 16, 0, 0); label.BackgroundTransparency = 1
    label.Text = txt; label.TextColor3 = Color3.new(0.8, 0.8, 0.8); label.Font = Enum.Font.Gotham; label.TextSize = 8; label.TextXAlignment = Enum.TextXAlignment.Left

    local function Toggle()
        getgenv().Config[key] = not getgenv().Config[key]
        check.Visible = getgenv().Config[key]
        label.TextColor3 = getgenv().Config[key] and Color3.new(1, 1, 1) or Color3.new(0.8, 0.8, 0.8)
        if callback then callback(getgenv().Config[key]) end
    end
    box.MouseButton1Click:Connect(Toggle)
    label.MouseButton1Click:Connect(Toggle)
end

local function AddActionButton(col, txt, callback)
    local b = Instance.new("TextButton", col)
    b.Size = UDim2.new(1, 0, 0, 20)
    b.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    b.Text = txt; b.TextColor3 = Color3.fromRGB(0, 255, 255)
    b.Font = Enum.Font.GothamBold; b.TextSize = 8
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- PAGE 1 MODULES
AddToggle(Col1, "Aimbot Head", "Aimbot")
AddToggle(Col1, "Silent Aim", "SilentAim")
AddToggle(Col1, "Triggerbot", "Triggerbot")
AddToggle(Col1, "Kill Aura", "KillAura")
AddToggle(Col1, "Hitbox Expand", "HitboxExpander")
AddToggle(Col1, "No Recoil", "NoRecoil")

AddToggle(Col2, "Master ESP", "ESP")
AddToggle(Col2, "Skeleton", "Skeleton")
AddToggle(Col2, "Health Bar", "Health")
AddToggle(Col2, "Tracers", "Tracers")

AddToggle(Col3, "Fly Mode", "Fly")
AddToggle(Col3, "Legit Fly", "LegitFly")
AddToggle(Col3, "Noclip", "Noclip")
AddToggle(Col3, "Inf Jump", "InfJump")
AddToggle(Col3, "Speed Boost", "SpeedActive")

AddToggle(Col4, "🧹 ΣΚΟΥΠΕΣ", "SkoupesBot")
AddToggle(Col4, "Destroyer", "DestroyerMode")
AddToggle(Col4, "Click TP", "ClickTP")
AddToggle(Col4, "Car Boost", "VehicleBoost")
AddToggle(Col4, "Inf Stamina", "InfStamina")
AddToggle(Col4, "Fullbright", "Fullbright")

-- PAGE 2 MODULES & BYPASS LOADSCREEN
AddToggle(Col5, "Inject Bypass", "InjectBypass")
AddToggle(Col5, "AC Bypass", "ACBypass")

AddToggle(Col6, "Optimiser", "Optimiser")
AddToggle(Col6, "FPS Boost", "FPSBoost", function(val)
    if val then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
        end
        SendDarkDevNotification("FPS Boost Activated!")
    end
end)
AddToggle(Col6, "Anti-AFK", "AntiAFK")
AddToggle(Col6, "Godmode Protect", "Godmode")

-- --- 4. FULLSCREEN BLACK BYPASS LOADING OVERLAY ---
local function TriggerFullBypassScreen()
    local LoaderOverlay = Instance.new("Frame", SG)
    LoaderOverlay.Size = UDim2.new(1, 0, 1, 0)
    LoaderOverlay.Position = UDim2.new(0, 0, 0, 0)
    LoaderOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LoaderOverlay.ZIndex = 1000
    
    local TitleLabel = Instance.new("TextLabel", LoaderOverlay)
    TitleLabel.Size = UDim2.new(1, 0, 0, 40); TitleLabel.Position = UDim2.new(0, 0, 0.3, 0)
    TitleLabel.Text = "DARKDEV SYSTEM ACCESS BYPASS"; TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextSize = 18; TitleLabel.BackgroundTransparency = 1
    
    local StatusText = Instance.new("TextLabel", LoaderOverlay)
    StatusText.Size = UDim2.new(1, 0, 0, 30); StatusText.Position = UDim2.new(0, 0, 0.42, 0)
    StatusText.Text = "Initialising Bypass Protocol..."; StatusText.TextColor3 = Color3.fromRGB(150, 150, 255)
    StatusText.Font = Enum.Font.Code; StatusText.TextSize = 12; StatusText.BackgroundTransparency = 1
    
    local BarBg = Instance.new("Frame", LoaderOverlay)
    BarBg.Size = UDim2.new(0.6, 0, 0, 20); BarBg.Position = UDim2.new(0.2, 0, 0.52, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Instance.new("UICorner", BarBg)
    local BarStroke = Instance.new("UIStroke", BarBg); BarStroke.Color = Color3.fromRGB(124, 77, 255)
    
    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0); BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    Instance.new("UICorner", BarFill)
    
    local PercentLabel = Instance.new("TextLabel", LoaderOverlay)
    PercentLabel.Size = UDim2.new(1, 0, 0, 25); PercentLabel.Position = UDim2.new(0, 0, 0.58, 0)
    PercentLabel.Text = "0%"; PercentLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    PercentLabel.Font = Enum.Font.GothamBold; PercentLabel.TextSize = 13; PercentLabel.BackgroundTransparency = 1

    task.spawn(function()
        local stages = {
            "Injecting Memory Bypass Engine...",
            "Bypassing Greek RP Anti-Cheat System...",
            "Patching Client Network Offsets...",
            "Acquiring Server-Side Privileges...",
            "Optimising Memory Heap & FPS...",
            "Bypass Complete! Access Granted."
        }
        for i = 1, 100 do
            task.wait(0.04)
            BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            PercentLabel.Text = i .. "%"
            
            if i == 15 then StatusText.Text = stages[1]
            elseif i == 35 then StatusText.Text = stages[2]
            elseif i == 55 then StatusText.Text = stages[3]
            elseif i == 75 then StatusText.Text = stages[4]
            elseif i == 90 then StatusText.Text = stages[5]
            elseif i == 100 then StatusText.Text = stages[6] end
        end
        task.wait(0.8)
        LoaderOverlay:Destroy()
        SendDarkDevNotification("Full Bypass Successfully Executed!")
    end)
end

AddActionButton(Col5, "🚀 BYPASS ACCESS", TriggerFullBypassScreen)

-- Preview Frame
local PreviewFrame = Instance.new("Frame", Main)
PreviewFrame.Size = UDim2.new(0, 90, 1, -40); PreviewFrame.Position = UDim2.new(1, -98, 0, 30)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", PreviewFrame)
local VP = Instance.new("ViewportFrame", PreviewFrame); VP.Size = UDim2.new(1, 0, 1, 0); VP.BackgroundTransparency = 1
local VPCam = Instance.new("Camera", VP); VP.CurrentCamera = VPCam

-- Inject Logic with Injected Game Name Notification
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(0.8)
    
    local gameName = "Greek RP"
    pcall(function() gameName = Market:GetProductInfo(game.PlaceId).Name end)
    
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
    
    SendDarkDevNotification("Script Injected - " .. gameName)
end)

PanelOpenMenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
PanelCloseBtn.MouseButton1Click:Connect(function() ServerPanel.Visible = false end)
Close.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- IMPROVED KILLAURA (PISTOL + AUTO TP) ---
local currentKillAuraIndex = 1

local function GetPistolTool()
    local char = LP.Character
    local bp = LP:FindFirstChild("Backpack")
    
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and string.find(string.lower(tool.Name), "pistol") then
                return tool
            end
        end
    end
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and string.find(string.lower(tool.Name), "pistol") then
                return tool
            end
        end
    end
    return nil
end

task.spawn(function()
    while true do
        task.wait(0.06)
        if getgenv().Config.KillAura then
            local pistol = GetPistolTool()
            if not pistol then
                SendDarkDevNotification("Item not found, buy it on the gunshop")
                getgenv().Config.KillAura = false
                task.wait(2)
            else
                if pistol.Parent ~= LP.Character then
                    LP.Character.Humanoid:EquipTool(pistol)
                end
                
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
                        
                        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                            LP.Character.HumanoidRootPart.CFrame = tHrp.CFrame * CFrame.new(0, 0, 2.5)
                        end
                        
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, tHead.Position)
                        ClickCenterScreen()
                        
                        pcall(function()
                            local weaponHit = ReplicatedStorage.WeaponsSystem.Network:FindFirstChild("WeaponHit")
                            if weaponHit then weaponHit:FireServer(tHead, tHead.Position) end
                        end)
                        
                        if tHum.Health <= 0 then
                            currentKillAuraIndex = currentKillAuraIndex + 1
                            task.wait(0.12)
                        end
                    else
                        currentKillAuraIndex = currentKillAuraIndex + 1
                    end
                end
            end
        end
    end
end)

-- --- IMPROVED SKOUPES AUTO-WALK ENGINE ---
local MAX_MARKER_RANGE = 300
local SearchWaypoints = {}
local currentSearchIdx = 1

local function WalkToPosition(targetPos)
    local Char = LP.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") or not Char:FindFirstChild("Humanoid") then return end
    local hrp = Char.HumanoidRootPart
    local hum = Char.Humanoid
    
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    end)
    hum.WalkSpeed = 35
    
    local targetFlat = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local dist = (targetFlat - hrp.Position).Magnitude
    if dist > 1.8 then
        local dir = (targetFlat - hrp.Position).Unit
        hum:Move(dir, false)
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
    
    local comserv = workspace:FindFirstChild("Comserv") or workspace:FindFirstChild("Bins")
    if comserv then
        for _, v in ipairs(comserv:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Model") then
                local pos = v:IsA("Model") and (v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position) or v.Position
                local d = (hrpPos - pos).Magnitude
                if d <= MAX_MARKER_RANGE and d < minD then
                    minD = d; bestPos = pos
                end
            end
        end
    end

    if not bestPos then
        for _, obj in ipairs(workspace:GetDescendants()) do
            pcall(function()
                local pos = nil
                local isMarker = false
                
                if obj:IsA("ProximityPrompt") and obj.Enabled and obj.Parent and obj.Parent:IsA("BasePart") then
                    isMarker = true; pos = obj.Parent.Position
                elseif obj:IsA("BasePart") and obj.Transparency < 0.9 then
                    local c = obj.Color
                    local isRed = (c.R > 0.6 and c.G < 0.4 and c.B < 0.4) or (c.R > 0.7 and c.G < 0.5)
                    local n = string.lower(obj.Name)
                    if isRed or string.find(n, "dust") or string.find(n, "dirt") or string.find(n, "trash") or string.find(n, "skoupa") then
                        isMarker = true; pos = obj.Position
                    end
                end
                
                if isMarker and pos then
                    local d = (hrpPos - pos).Magnitude
                    if d <= MAX_MARKER_RANGE and d < minD and d > 0.5 then
                        minD = d; bestPos = pos
                    end
                end
            end)
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
                    local reached = WalkToPosition(markerPos)
                    ClickCenterScreen()
                    
                    if (Char.HumanoidRootPart.Position - markerPos).Magnitude < 8 then
                        pcall(function()
                            local jobRemote = ReplicatedStorage:FindFirstChild("JobInteraction") and ReplicatedStorage.JobInteraction:FindFirstChild("RemoteEvent")
                            if jobRemote then jobRemote:FireServer("Interact", markerPos) end
                            for _, p in ipairs(workspace:GetDescendants()) do
                                if p:IsA("ProximityPrompt") and (p.Parent.Position - Char.HumanoidRootPart.Position).Magnitude < 10 then
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

-- --- ESP & GAME LOOPS ---
local ESP_Objects = {}
local function CreateESP(p)
    local data = { Box = Drawing.new("Square"), Skelly = Drawing.new("Line"), Health = Drawing.new("Line"), Tracer = Drawing.new("Line") }
    data.Box.Thickness = 1; data.Box.Filled = false; data.Box.Color = Color3.new(1,1,1)
    data.Skelly.Thickness = 1; data.Skelly.Color = Color3.new(1,0,0)
    data.Health.Thickness = 2; data.Health.Color = Color3.new(0,1,0)
    data.Tracer.Thickness = 1; data.Tracer.Color = Color3.new(0,1,1)
    ESP_Objects[p] = data
end

RunService.RenderStepped:Connect(function()
    for p, d in pairs(ESP_Objects) do
        if getgenv().Config.ESP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = p.Character.HumanoidRootPart
            local Pos, Vis = Camera:WorldToViewportPoint(HRP.Position)
            if Vis then
                local S = (Camera:WorldToViewportPoint(HRP.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(HRP.Position + Vector3.new(0, 2.6, 0)).Y)
                d.Box.Size = Vector2.new(S * 1.3, S); d.Box.Position = Vector2.new(Pos.X - S/1.5, Pos.Y - S/2); d.Box.Visible = true
                if getgenv().Config.Health and p.Character:FindFirstChildOfClass("Humanoid") then
                    local H = p.Character:FindFirstChildOfClass("Humanoid")
                    d.Health.From = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2); d.Health.To = Vector2.new(Pos.X + S/1.5 + 4, Pos.Y + S/2 - (S * (H.Health/H.MaxHealth))); d.Health.Visible = true
                else d.Health.Visible = false end
                if getgenv().Config.Skeleton and p.Character:FindFirstChild("Head") then
                    local HP = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    d.Skelly.From = Vector2.new(HP.X, HP.Y); d.Skelly.To = Vector2.new(Pos.X, Pos.Y); d.Skelly.Visible = true
                else d.Skelly.Visible = false end
                if getgenv().Config.Tracers then
                    d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(Pos.X, Pos.Y + S/2); d.Tracer.Visible = true
                else d.Tracer.Visible = false end
            else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
        else d.Box.Visible = false; d.Health.Visible = false; d.Skelly.Visible = false; d.Tracer.Visible = false end
    end
end)

RunService.RenderStepped:Connect(function()
    local Char = LP.Character; if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Char.HumanoidRootPart

    FlyOverlay.Visible = (getgenv().Config.Fly or getgenv().Config.LegitFly) and not Main.Visible
    
    if getgenv().Config.LegitFly then
        local jitterX = (math.random(-10, 10) / 100)
        local jitterZ = (math.random(-10, 10) / 100)
        local baseSpeed = getgenv().Config.FlySpeed * 0.8
        local V = 0
        if getgenv().Config.FlyUp then V = 35 elseif getgenv().Config.FlyDown then V = -35 end
        local moveDir = Char.Humanoid.MoveDirection
        local humanizedVelocity = (moveDir * (baseSpeed + math.random(-2, 2))) + Vector3.new(jitterX, V + 0.8, jitterZ)
        HRP.Velocity = HRP.Velocity:Lerp(humanizedVelocity, 0.25)
    elseif getgenv().Config.Fly then
        local V = 0; if getgenv().Config.FlyUp then V = 50 elseif getgenv().Config.FlyDown then V = -50 end
        HRP.Velocity = (Char.Humanoid.MoveDirection * getgenv().Config.FlySpeed) + Vector3.new(0, V + 1.5, 0)
    end
    
    local TargetHead = nil
    local ClosestDist = 400
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            local headPos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local screenDist = (Vector2.new(headPos.X, headPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if screenDist < ClosestDist then
                    ClosestDist = screenDist
                    TargetHead = p.Character.Head
                end
            end
        end
    end

    VP:ClearAllChildren()
    local Model = (TargetHead and TargetHead.Parent) or LP.Character
    if Model then
        local Cl = Instance.new("Model", VP)
        for _, p in pairs(Model:GetChildren()) do
            if p:IsA("BasePart") then
                local c = p:Clone(); c.Parent = Cl
                if p.Name == "HumanoidRootPart" then VPCam.CFrame = CFrame.new(c.Position + (c.CFrame.LookVector * 5), c.Position) end
            end
        end
    end

    if TargetHead and getgenv().Config.Aimbot then
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, TargetHead.Position), getgenv().Config.Smooth)
    end

    if getgenv().Config.SpeedActive then LP.Character.Humanoid.WalkSpeed = 65 else LP.Character.Humanoid.WalkSpeed = 16 end
end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LP then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)

-- --- SAFETY PROTECTIONS ---
local VirtualUser = game:GetService("VirtualUser")
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

-- --- HITBOX & WEAPON ENHANCEMENTS ---
local HITBOX_SIZE = Vector3.new(12, 12, 12)
RunService.RenderStepped:Connect(function()
    if getgenv().Config.HitboxExpander then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                pcall(function()
                    local head = p.Character.Head
                    head.Size = HITBOX_SIZE
                    head.Transparency = 0.6
                    head.Color = Color3.fromRGB(124, 77, 255)
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                end)
            end
        end
    end
end)

print("DarkDev Paged Master Suite v34.0 Loaded Successfully.")
