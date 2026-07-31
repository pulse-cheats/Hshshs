repeat task.wait() until game:IsLoaded()

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("DevNoticeUI") then
    CoreGui:FindFirstChild("DevNoticeUI"):Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "DevNoticeUI"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 340, 0, 95)
main.Position = UDim2.new(0.5, -170, 0, -120)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(220, 60, 60)
stroke.Parent = main

local redLine = Instance.new("Frame")
redLine.Size = UDim2.new(1, 0, 0, 2)
redLine.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
redLine.BorderSizePixel = 0
redLine.Parent = main

local title = Instance.new("TextLabel")
title.Text = "SYSTEM NOTICE"
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0, 16, 0, 14)
title.Size = UDim2.new(1, -50, 0, 16)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = main

local msg = Instance.new("TextLabel")
msg.Text = "Script is currently under development."
msg.Font = Enum.Font.GothamMedium
msg.TextSize = 10
msg.TextColor3 = Color3.fromRGB(160, 160, 175)
msg.Position = UDim2.new(0, 16, 0, 36)
msg.Size = UDim2.new(1, -32, 0, 40)
msg.TextXAlignment = Enum.TextXAlignment.Left
msg.TextYAlignment = Enum.TextYAlignment.Top
msg.TextWrapped = true
msg.BackgroundTransparency = 1
msg.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -26, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.fromRGB(180, 180, 195)
close.TextSize = 10
close.AutoButtonColor = false
close.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = close

local function hide()
    local t = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -170, 0, -120)})
    t:Play()
    t.Completed:Connect(function()
        gui:Destroy()
    end)
end

close.MouseButton1Click:Connect(hide)

TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -170, 0, 20)}):Play()

task.delay(5, function()
    if gui and gui.Parent then
        hide()
    end
end)
