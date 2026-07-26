--[[
    DARKDEV GREEK RP - ULTIMATE MASTER SUITE v30.0
    Architect: Rool Machine
    Features: Combat, Visuals, Movement, RP Utils, Skoupes Auto-Farm / Cleaning Bot
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
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- --- CONFIGURATION ---
getgenv().Config = {
    -- COMBAT
    Aimbot = false, SilentAim = false, Triggerbot = false, KillAura = false,
    NoRecoil = false, HitboxExpander = false,
    -- VISUALS
    ESP = false, Skeleton = true, Health = true, Tracers = true, HeadDot = false,
    -- MOVEMENT
    Fly = false, Noclip = false, SpeedActive = false, InfJump = false,
    -- RP UTILS & AUTOMATION
    SkoupesBot = false, DestroyerMode = false, VehicleBoost = false, InfStamina = false, ClickTP = false,
    Fullbright = false, AntiAFK = false,
    -- SETTINGS
    FlySpeed = 50, FlyUp = false, FlyDown = false, Smooth = 0.15,
    InjectTime = "Not Injected"
}

-- --- SKOUPES WAYPOINTS (FROM YOUR COORDINATES) ---
local SkoupesWaypoints = {
    Vector3.new(206.84, 3.40, -114.71),
    Vector3.new(194.27, 3.40, -110.15),
    Vector3.new(189.54, 3.40, -119.38),
    Vector3.new(184.81, 3.40, -128.60),
    Vector3.new(179.91, 3.40, -138.16),
    Vector3.new(175.01, 3.40, -147.72),
    Vector3.new(170.11, 3.40, -157.28),
    Vector3.new(165.21, 3.40, -166.83),
    Vector3.new(168.17, 3.40, -170.19),
    Vector3.new(171.13, 3.40, -173.54),
    Vector3.new(176.03, 3.40, -163.98),
    Vector3.new(180.93, 3.40, -154.43),
    Vector3.new(185.83, 3.40, -144.87),
    Vector3.new(190.73, 3.40, -135.31),
    Vector3.new(195.46, 3.40, -126.09),
    Vector3.new(200.19, 3.40, -116.86),
    Vector3.new(205.13, 3.40, -118.65),
    Vector3.new(200.40, 3.40, -127.87),
    Vector3.new(195.67, 3.40, -137.10),
    Vector3.new(190.77, 3.40, -146.66),
    Vector3.new(185.87, 3.40, -156.21),
    Vector3.new(180.97, 3.40, -165.77),
    Vector3.new(176.07, 3.40, -175.33),
    Vector3.new(179.03, 3.40, -178.68),
    Vector3.new(181.99, 3.40, -182.04),
    Vector3.new(186.89, 3.40, -172.48),
    Vector3.new(191.79, 3.40, -162.92),
    Vector3.new(196.69, 3.40, -153.37),
    Vector3.new(201.59, 3.40, -143.81),
    Vector3.new(206.32, 3.40, -134.58),
    Vector3.new(211.05, 3.40, -125.36),
    Vector3.new(212.85, 3.40, -128.85),
    Vector3.new(208.12, 3.40, -138.08),
    Vector3.new(203.39, 3.40, -147.30),
    Vector3.new(198.49, 3.40, -156.86),
    Vector3.new(193.59, 3.40, -166.41),
    Vector3.new(188.69, 3.40, -175.97),
    Vector3.new(183.79, 3.40, -185.53),
    Vector3.new(186.75, 3.40, -188.88),
    Vector3.new(189.71, 3.40, -192.24),
    Vector3.new(194.61, 3.40, -182.68),
    Vector3.new(199.51, 3.40, -173.12),
    Vector3.new(204.41, 3.40, -163.57),
    Vector3.new(209.31, 3.40, -154.01),
    Vector3.new(214.04, 3.40, -144.78),
    Vector3.new(218.77, 3.40, -135.56),
    Vector3.new(220.56, 3.40, -139.05),
    Vector3.new(215.83, 3.40, -148.27),
    Vector3.new(211.10, 3.40, -157.50),
    Vector3.new(206.20, 3.40, -167.05),
    Vector3.new(201.30, 3.40, -176.61),
    Vector3.new(196.40, 3.40, -186.17),
    Vector3.new(191.50, 3.40, -195.73),
    Vector3.new(194.46, 3.40, -199.08),
    Vector3.new(197.42, 3.40, -202.44),
    Vector3.new(202.32, 3.40, -192.88),
    Vector3.new(207.22, 3.40, -183.32),
    Vector3.new(212.12, 3.40, -173.77),
    Vector3.new(217.02, 3.40, -164.21),
    Vector3.new(221.75, 3.40, -154.98),
    Vector3.new(226.48, 3.40, -145.76)
}

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "DarkDev_v30_Skoupes"

-- --- 1. INJECTOR SCREEN ---
local InjectorFrame = Instance.new("Frame", SG)
InjectorFrame.Size = UDim2.new(0, 260, 0, 150); InjectorFrame.Position = UDim2.new(0.5, -130, 0.5, -75); InjectorFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5); InjectorFrame.Active = true; InjectorFrame.Draggable = true
Instance.new("UICorner", InjectorFrame)
local IStroke = Instance.new("UIStroke", InjectorFrame); IStroke.Color = Color3.fromRGB(124, 77, 255)

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, 0, 0, 35); InjectTitle.Text = "DARKDEV INJECTOR v30"; InjectTitle.TextColor3 = Color3.fromRGB(124, 77, 255); InjectTitle.Font = Enum.Font.GothamBold; InjectTitle.TextSize = 13; InjectTitle.BackgroundTransparency = 1

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.8, 0, 0, 38); InjectBtn.Position = UDim2.new(0.1, 0, 0.45, 0); InjectBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); InjectBtn.Text = "💉 INJECT 💉"; InjectBtn.TextColor3 = Color3.fromRGB(0, 255, 255); InjectBtn.Font = Enum.Font.GothamBold; InjectBtn.TextSize = 13
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

-- --- 3. MAIN CHEAT MENU ---
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 520, 0, 260); Main.Position = UDim2.new(0.5, -260, 0.5, -130); Main.BackgroundColor3 = Color3.fromRGB(18, 18, 26); Main.Active = true; Main.Draggable = true; Main.Visible = false
Instance.new("UICorner", Main); Instance.new("UIStroke", Main).Color = Color3.fromRGB(124, 77, 255)

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

-- 4 Sections
local function CreateSection(name, pos)
    local s = Instance.new("Frame", Main)
    s.Size = UDim2.new(0, 98, 1, -40); s.Position = UDim2.new(0, 8 + (pos * 102), 0, 30); s.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Instance.new("UICorner", s)
    local t = Instance.new("TextLabel", s); t.Size = UDim2.new(1, 0, 0, 20); t.Text = name; t.TextColor3 = Color3.fromRGB(124, 77, 255); t.Font = Enum.Font.GothamBold; t.TextSize = 9; t.BackgroundTransparency = 1
    local c = Instance.new("ScrollingFrame", s); c.Size = UDim2.new(1, -6, 1, -24); c.Position = UDim2.new(0, 3, 0, 22); c.BackgroundTransparency = 1; c.ScrollBarThickness = 0
    Instance.new("UIListLayout", c).Padding = UDim.new(0, 4)
    return c
end

local Col1 = CreateSection("COMBAT", 0)
local Col2 = CreateSection("VISUALS", 1)
local Col3 = CreateSection("MOVE", 2)
local Col4 = CreateSection("RP UTILS", 3)

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

-- 1. COMBAT
AddToggle(Col1, "Aimbot Head", "Aimbot")
AddToggle(Col1, "Silent Aim", "SilentAim")
AddToggle(Col1, "Triggerbot", "Triggerbot")
AddToggle(Col1, "Kill Aura", "KillAura")

-- 2. VISUALS
AddToggle(Col2, "Master ESP", "ESP")
AddToggle(Col2, "Skeleton", "Skeleton")
AddToggle(Col2, "Health Bar", "Health")
AddToggle(Col2, "Tracers", "Tracers")

-- 3. MOVEMENT
AddToggle(Col3, "Fly Mode", "Fly")
AddToggle(Col3, "Noclip", "Noclip")
AddToggle(Col3, "Inf Jump", "InfJump")
AddToggle(Col3, "Speed Boost", "SpeedActive")

-- 4. RP UTILS (With Skoupes Auto-Farm)
AddToggle(Col4, "🧹 ΣΚΟΥΠΕΣ", "SkoupesBot")
AddToggle(Col4, "Destroyer", "DestroyerMode")
AddToggle(Col4, "Click TP", "ClickTP")
AddToggle(Col4, "Car Boost", "VehicleBoost")
AddToggle(Col4, "Inf Stamina", "InfStamina")
AddToggle(Col4, "Fullbright", "Fullbright")
AddActionButton(Col4, "Server Hop", function()
    TeleportService:Teleport(game.PlaceId, LP)
end)

-- Preview Frame
local PreviewFrame = Instance.new("Frame", Main)
PreviewFrame.Size = UDim2.new(0, 90, 1, -40); PreviewFrame.Position = UDim2.new(1, -98, 0, 30)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", PreviewFrame)
local VP = Instance.new("ViewportFrame", PreviewFrame); VP.Size = UDim2.new(1, 0, 1, 0); VP.BackgroundTransparency = 1
local VPCam = Instance.new("Camera", VP); VP.CurrentCamera = VPCam

-- Inject Logic
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(1)
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
end)

PanelOpenMenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
PanelCloseBtn.MouseButton1Click:Connect(function() ServerPanel.Visible = false end)
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 20, 0, 20); Close.Position = UDim2.new(1, -24, 0, 4); Close.Text = "X"; Close.TextColor3 = Color3.new(1,0,0); Close.BackgroundTransparency = 1; Close.Font = Enum.Font.GothamBold
Close.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- AUTOMATED SKOUPES BOT TASK THREAD ---
task.spawn(function()
    while true do
        task.wait(0.12) -- Screen Click Delay Interval
        
        if getgenv().Config.SkoupesBot then
            -- 1. Auto Click Center Screen
            pcall(function()
                mouse1click()
            end)

            -- 2. Auto Walk to Waypoints Loop
            local Char = LP.Character
            if Char and Char:FindFirstChild("Humanoid") and Char:FindFirstChild("HumanoidRootPart") then
                local Hum = Char.Humanoid
                for _, waypoint in ipairs(SkoupesWaypoints) do
                    if not getgenv().Config.SkoupesBot then break end
                    
                    Hum:MoveTo(waypoint)
                    
                    -- Wait until reached waypoint or timeout
                    local startTime = tick()
                    repeat
                        task.wait(0.1)
                        pcall(function() mouse1click() end)
                    until (Char.HumanoidRootPart.Position - waypoint).Magnitude < 4 or (tick() - startTime) > 5 or not getgenv().Config.SkoupesBot
                end
            end
        end
    end
end)

-- --- INPUT HANDLERS (CLICK TP & DESTROYER) ---
local function HandleActionAtPosition(targetPos)
    if not targetPos then return end
    
    if getgenv().Config.ClickTP and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    end
    
    if getgenv().Config.DestroyerMode then
        local event = ReplicatedStorage:FindFirstChild("DestroyerEvent")
        if event then event:FireServer(targetPos) end
        local exp = Instance.new("Explosion")
        exp.Position = targetPos; exp.BlastRadius = 12; exp.Parent = workspace
    end
end

Mouse.Button1Down:Connect(function()
    if Mouse.Hit then HandleActionAtPosition(Mouse.Hit.Position) end
end)

UIS.TouchTap:Connect(function(touchPositions, gameProcessed)
    if gameProcessed then return end
    local unitRay = Camera:ViewportPointToRay(touchPositions[1].X, touchPositions[1].Y)
    local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
    if raycastResult then HandleActionAtPosition(raycastResult.Position) end
end)

-- --- CORE ESP & GAME LOOPS ---
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

    FlyOverlay.Visible = getgenv().Config.Fly and not Main.Visible
    if getgenv().Config.Fly then
        local V = 0; if getgenv().Config.FlyUp then V = 50 elseif getgenv().Config.FlyDown then V = -50 end
        HRP.Velocity = (Char.Humanoid.MoveDirection * getgenv().Config.FlySpeed) + Vector3.new(0, V + 1.5, 0)
    end
    
    -- Target Finder
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

    -- Update Preview Box
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

    if getgenv().Config.SpeedActive then LP.Character.Humanoid.WalkSpeed = 60 else LP.Character.Humanoid.WalkSpeed = 16 end
end)

RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LP.Character then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)
UIS.JumpRequest:Connect(function() if getgenv().Config.InfJump then LP.Character.Humanoid:ChangeState("Jumping") end end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LP then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)

print("DarkDev Skoupes Suite v30.0 Loaded.")
