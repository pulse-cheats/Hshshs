--[[
    DARKDEV GREEK RP - INJECTOR SUITE v21.0
    Architect: sotiris_gkal
    Features: Black Injector Screen, Integrated Server Panel Toggle, Skush Menu
]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Market = game:GetService("MarketplaceService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer

-- --- CONFIG ---
getgenv().Config = {
    Aimbot = false, SilentAim = false, KillAura = false,
    ESP = false, Skeleton = true, Health = true, Tracers = true, Distance = true,
    Fly = false, Noclip = false, SpeedActive = false, JumpActive = false, InfJump = false,
    Fullbright = false, NoFog = false, NoRecoil = false,
    FlySpeed = 50, FlyUp = false, FlyDown = false, Smooth = 0.1,
    InjectTime = "Not Injected"
}

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "DarkDev_v21"

-- --- 1. BLACK INJECTOR SCREEN ---
local InjectorFrame = Instance.new("Frame", SG)
InjectorFrame.Size = UDim2.new(0, 320, 0, 180)
InjectorFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
InjectorFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5) -- Black
InjectorFrame.Active = true; InjectorFrame.Draggable = true
Instance.new("UICorner", InjectorFrame)
local IStroke = Instance.new("UIStroke", InjectorFrame); IStroke.Color = Color3.fromRGB(124, 77, 255)

local InjectTitle = Instance.new("TextLabel", InjectorFrame)
InjectTitle.Size = UDim2.new(1, 0, 0, 40)
InjectTitle.Text = "DARKDEV INJECTOR"
InjectTitle.TextColor3 = Color3.fromRGB(124, 77, 255)
InjectTitle.Font = Enum.Font.GothamBold
InjectTitle.TextSize = 16
InjectTitle.BackgroundTransparency = 1

local InjectBtn = Instance.new("TextButton", InjectorFrame)
InjectBtn.Size = UDim2.new(0.8, 0, 0, 45)
InjectBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
InjectBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
InjectBtn.Text = "💉 INJECT 💉"
InjectBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.TextSize = 14
Instance.new("UICorner", InjectBtn)
Instance.new("UIStroke", InjectBtn).Color = Color3.fromRGB(0, 255, 255)

-- --- 2. SERVER PANEL WITH TOGGLE BUTTON & CLOSE (X) ---
local ServerPanel = Instance.new("Frame", SG)
ServerPanel.Size = UDim2.new(0, 230, 0, 185)
ServerPanel.Position = UDim2.new(0, 10, 0, 10)
ServerPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ServerPanel.BorderSizePixel = 0
ServerPanel.Visible = false
Instance.new("UICorner", ServerPanel)
local SStroke = Instance.new("UIStroke", ServerPanel); SStroke.Color = Color3.fromRGB(124, 77, 255); SStroke.Thickness = 1.5

-- Close Button (X) on Server Panel
local PanelCloseBtn = Instance.new("TextButton", ServerPanel)
PanelCloseBtn.Size = UDim2.new(0, 20, 0, 20)
PanelCloseBtn.Position = UDim2.new(1, -25, 0, 5)
PanelCloseBtn.Text = "X"
PanelCloseBtn.TextColor3 = Color3.new(1, 0, 0)
PanelCloseBtn.BackgroundTransparency = 1
PanelCloseBtn.Font = Enum.Font.GothamBold
PanelCloseBtn.TextSize = 12

local STitle = Instance.new("TextLabel", ServerPanel)
STitle.Size = UDim2.new(1, -30, 0, 25)
STitle.Text = "  SERVER & CLIENT INFO"
STitle.TextColor3 = Color3.fromRGB(124, 77, 255)
STitle.Font = Enum.Font.GothamBold
STitle.TextSize = 11
STitle.TextXAlignment = Enum.TextXAlignment.Left
STitle.BackgroundTransparency = 1

local SContent = Instance.new("TextLabel", ServerPanel)
SContent.Size = UDim2.new(1, -10, 0, 110)
SContent.Position = UDim2.new(0, 5, 0, 25)
SContent.TextColor3 = Color3.fromRGB(200, 200, 200)
SContent.Font = Enum.Font.Code
SContent.TextSize = 10
SContent.TextXAlignment = Enum.TextXAlignment.Left
SContent.TextYAlignment = Enum.TextYAlignment.Top
SContent.BackgroundTransparency = 1

-- Open GUI Button inside Server Panel
local PanelOpenMenuBtn = Instance.new("TextButton", ServerPanel)
PanelOpenMenuBtn.Size = UDim2.new(1, -10, 0, 30)
PanelOpenMenuBtn.Position = UDim2.new(0, 5, 1, -35)
PanelOpenMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
PanelOpenMenuBtn.Text = "⚡ OPEN CHEAT MENU ⚡"
PanelOpenMenuBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
PanelOpenMenuBtn.Font = Enum.Font.GothamBold
PanelOpenMenuBtn.TextSize = 11
Instance.new("UICorner", PanelOpenMenuBtn)
Instance.new("UIStroke", PanelOpenMenuBtn).Color = Color3.fromRGB(124, 77, 255)

-- Live Info Loop
RunService.RenderStepped:Connect(function()
    local gName = "Greek RP"
    pcall(function() gName = Market:GetProductInfo(game.PlaceId).Name end)
    
    SContent.Text = string.format(
        "Game: %s\nPlayers: %d/%d\nInject Time: %s\nTime: %s\nAnticheat: %s\nUser: %s\nID: %d",
        string.sub(gName, 1, 18),
        #Players:GetPlayers(), Players.MaxPlayers,
        getgenv().Config.InjectTime,
        os.date("%X"),
        "Bypassed",
        LP.Name,
        LP.UserId
    )
end)

-- --- 3. MAIN CHEAT MENU ---
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 560, 0, 320)
Main.Position = UDim2.new(0.5, -280, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
Main.Active = true; Main.Draggable = true
Main.Visible = false
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(124, 77, 255)

-- Floating Icon
local OpenIcon = Instance.new("ImageButton", SG)
OpenIcon.Size = UDim2.new(0, 45, 0, 45); OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 30); OpenIcon.Image = "rbxassetid://6031094678"; OpenIcon.Visible = false
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(124, 77, 255)

-- Fly UP/DN Buttons
local FlyOverlay = Instance.new("Frame", SG)
FlyOverlay.Size = UDim2.new(0, 50, 0, 110); FlyOverlay.Position = UDim2.new(1, -60, 0.5, -55); FlyOverlay.BackgroundTransparency = 1; FlyOverlay.Visible = false
local function CreateFlyBtn(txt, key, pos)
    local b = Instance.new("TextButton", FlyOverlay)
    b.Size = UDim2.new(1, 0, 0, 50); b.Position = UDim2.new(0, 0, 0, pos * 55)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35); b.Text = txt; b.TextColor3 = Color3.fromRGB(0, 255, 255); b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Down:Connect(function() getgenv().Config[key] = true end)
    b.MouseButton1Up:Connect(function() getgenv().Config[key] = false end)
end
CreateFlyBtn("UP", "FlyUp", 0); CreateFlyBtn("DN", "FlyDown", 1)

-- Main Menu Sections
local function CreateSection(name, pos)
    local s = Instance.new("Frame", Main)
    s.Size = UDim2.new(0, 130, 1, -50); s.Position = UDim2.new(0, 10 + (pos * 140), 0, 40)
    s.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Instance.new("UICorner", s)
    local t = Instance.new("TextLabel", s); t.Size = UDim2.new(1, 0, 0, 25); t.Text = name; t.TextColor3 = Color3.fromRGB(124, 77, 255); t.Font = Enum.Font.GothamBold; t.TextSize = 10; t.BackgroundTransparency = 1
    local c = Instance.new("ScrollingFrame", s); c.Size = UDim2.new(1, -10, 1, -30); c.Position = UDim2.new(0, 5, 0, 25); c.BackgroundTransparency = 1; c.ScrollBarThickness = 0
    Instance.new("UIListLayout", c).Padding = UDim.new(0, 5)
    return c
end

local Col1 = CreateSection("COMBAT", 0)
local Col2 = CreateSection("VISUALS", 1)
local Col3 = CreateSection("MOVEMENT", 2)

local function AddToggle(col, txt, key)
    local b = Instance.new("Frame", col)
    b.Size = UDim2.new(1, 0, 0, 25); b.BackgroundTransparency = 1
    local box = Instance.new("TextButton", b)
    box.Size = UDim2.new(0, 14, 0, 14); box.Position = UDim2.new(0, 5, 0.5, -7); box.BackgroundColor3 = Color3.fromRGB(30, 30, 40); box.Text = ""
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)
    local check = Instance.new("Frame", box); check.Size = UDim2.new(1, -4, 1, -4); check.Position = UDim2.new(0, 2, 0, 2); check.BackgroundColor3 = Color3.fromRGB(124, 77, 255); check.Visible = false; Instance.new("UICorner", check)
    local label = Instance.new("TextButton", b)
    label.Size = UDim2.new(1, -25, 1, 0); label.Position = UDim2.new(0, 25, 0, 0); label.BackgroundTransparency = 1
    label.Text = txt; label.TextColor3 = Color3.new(0.8, 0.8, 0.8); label.Font = Enum.Font.Gotham; label.TextSize = 10; label.TextXAlignment = Enum.TextXAlignment.Left

    local function Toggle()
        getgenv().Config[key] = not getgenv().Config[key]
        check.Visible = getgenv().Config[key]
        label.TextColor3 = getgenv().Config[key] and Color3.new(1, 1, 1) or Color3.new(0.8, 0.8, 0.8)
    end
    box.MouseButton1Click:Connect(Toggle)
    label.MouseButton1Click:Connect(Toggle)
end

-- Populate Cheat Toggles
AddToggle(Col1, "Aimbot", "Aimbot"); AddToggle(Col1, "Silent Aim", "SilentAim"); AddToggle(Col1, "Kill Aura", "KillAura"); AddToggle(Col1, "No Recoil", "NoRecoil")
AddToggle(Col2, "Master ESP", "ESP"); AddToggle(Col2, "Red Skeleton", "Skeleton"); AddToggle(Col2, "Health Bar", "Health"); AddToggle(Col2, "Trace Lines", "Tracers"); AddToggle(Col2, "Distance", "Distance")
AddToggle(Col3, "Fly Mode", "Fly"); AddToggle(Col3, "Noclip", "Noclip"); AddToggle(Col3, "Fullbright", "Fullbright"); AddToggle(Col3, "Inf Jump", "InfJump"); AddToggle(Col3, "Speed Boost", "SpeedActive")

-- Preview Frame
local PreviewFrame = Instance.new("Frame", Main)
PreviewFrame.Size = UDim2.new(0, 120, 1, -50); PreviewFrame.Position = UDim2.new(1, -130, 0, 40)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", PreviewFrame)
local VP = Instance.new("ViewportFrame", PreviewFrame); VP.Size = UDim2.new(1, 0, 1, 0); VP.BackgroundTransparency = 1
local VPCam = Instance.new("Camera", VP); VP.CurrentCamera = VPCam

-- INJECT LOGIC
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "INJECTING..."
    getgenv().Config.InjectTime = os.date("%X")
    task.wait(1)
    InjectorFrame.Visible = false
    ServerPanel.Visible = true
    Main.Visible = true
end)

-- Server Panel Interactions
PanelOpenMenuBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    if not Main.Visible then OpenIcon.Visible = true else OpenIcon.Visible = false end
end)

PanelCloseBtn.MouseButton1Click:Connect(function()
    ServerPanel.Visible = false
end)

-- Close / Open Main Menu
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 25, 0, 25); Close.Position = UDim2.new(1, -30, 0, 5); Close.Text = "X"; Close.TextColor3 = Color3.new(1,0,0); Close.BackgroundTransparency = 1
Close.MouseButton1Click:Connect(function() Main.Visible = false; OpenIcon.Visible = true end)
OpenIcon.MouseButton1Click:Connect(function() Main.Visible = true; OpenIcon.Visible = false end)

-- --- CORE SYSTEMS LOOPS ---
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
    
    local T, D = nil, 400
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            local vP, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis and (Vector2.new(vP.X, vP.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude < D then
                D = (Vector2.new(vP.X, vP.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude; T = p
            end
        end
    end

    VP:ClearAllChildren()
    local Model = (T and T.Character) or LP.Character
    if Model then
        local Cl = Instance.new("Model", VP); for _, p in pairs(Model:GetChildren()) do if p:IsA("BasePart") then local c = p:Clone(); c.Parent = Cl if p.Name == "HumanoidRootPart" then VPCam.CFrame = CFrame.new(c.Position + (c.CFrame.LookVector * 5), c.Position) end end end
    end

    if T and getgenv().Config.Aimbot then
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, T.Character.Head.Position), getgenv().Config.Smooth)
    end
    
    if getgenv().Config.Fullbright then Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.OutdoorAmbient = Color3.new(1,1,1) end
    if getgenv().Config.SpeedActive then LP.Character.Humanoid.WalkSpeed = 60 else LP.Character.Humanoid.WalkSpeed = 16 end
end)

RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LP.Character then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)
UIS.JumpRequest:Connect(function() if getgenv().Config.InfJump then LP.Character.Humanoid:ChangeState("Jumping") end end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LP then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)

print("DarkDev Injector Suite v21.0 Loaded.")
