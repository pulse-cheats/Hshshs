--[[
    DARKDEV - SCRIPT UNDER DEVELOPMENT NOTIFIER
    Displays a smooth Notification & Center Banner on Execution
--]]

repeat task.wait() until game:IsLoaded()

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- --- CLEANUP PREVIOUS NOTIFIER ---
if CoreGui:FindFirstChild("DarkDevDevNotifier") then
    CoreGui:FindFirstChild("DarkDevDevNotifier"):Destroy()
end

-- --- SCREEN GUI ROOT ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkDevDevNotifier"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

-- --- CENTER BANNER CARD ---
local Banner = Instance.new("Frame")
Banner.Name = "DevBanner"
Banner.Size = UDim2.new(0, 380, 0, 110)
Banner.Position = UDim2.new(0.5, -190, 0, -150) -- Starts off-screen
Banner.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
Banner.BorderSizePixel = 0
Banner.ClipsDescendants = true
Banner.Parent = ScreenGui

local BannerCorner = Instance.new("UICorner")
BannerCorner.CornerRadius = UDim.new(0, 10)
BannerCorner.Parent = Banner

local BannerStroke = Instance.new("UIStroke")
BannerStroke.Thickness = 1.5
BannerStroke.Color = Color3.fromRGB(231, 76, 60) -- Red Accent
BannerStroke.Parent = Banner

-- TOP RED ACCENT LINE
local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 3)
TopLine.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
TopLine.BorderSizePixel = 0
TopLine.Parent = Banner

-- DEV ICON / WARNING BADGE
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0, 32, 0, 32)
Icon.Position = UDim2.new(0, 16, 0.5, -16)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://6031097225"
Icon.ImageColor3 = Color3.fromRGB(231, 76, 60)
Icon.Parent = Banner

-- TITLE & DESCRIPTION
local Title = Instance.new("TextLabel")
Title.Text = "DARKDEV ENGINE NOTICE"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Position = UDim2.new(0, 60, 0, 20)
Title.Size = UDim2.new(1, -70, 0, 18)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Banner

local Message = Instance.new("TextLabel")
Message.Text = "This script is currently UNDER DEVELOPMENT.\nPlease check back later for updates!"
Message.Font = Enum.Font.GothamMedium
Message.TextSize = 10
Message.TextColor3 = Color3.fromRGB(160, 165, 185)
Message.Position = UDim2.new(0, 60, 0, 42)
Message.Size = UDim2.new(1, -70, 0, 36)
Message.TextXAlignment = Enum.TextXAlignment.Left
Message.TextYAlignment = Enum.TextYAlignment.Top
Message.TextWrapped = true
Message.BackgroundTransparency = 1
Message.Parent = Banner

-- DISMISS BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -30, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 195)
CloseBtn.TextSize = 10
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = Banner

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- --- SMOOTH ANIMATION ---
local function HideBanner()
    local animOut = TweenService:Create(Banner, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -190, 0, -150)})
    animOut:Play()
    animOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

CloseBtn.MouseButton1Click:Connect(HideBanner)

-- Slide In Animation
TweenService:Create(Banner, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -190, 0, 25)}):Play()

-- Auto Close after 6 seconds
task.delay(6, function()
    if ScreenGui and ScreenGui.Parent then
        HideBanner()
    end
end)

print("DarkDev: Script under development notification displayed.")
