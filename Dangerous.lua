--[[
    DARKDEV GREEK RP - SHUTDOWN NOTICE
    Architect: Rool Machine
]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

local SafeGuiParent = (gethui and gethui()) or CoreGui or (LP and LP:WaitForChild("PlayerGui"))

-- Destroy any existing UI
pcall(function()
    if SafeGuiParent:FindFirstChild("DarkDev_Shutdown") then
        SafeGuiParent.DarkDev_Shutdown:Destroy()
    end
end)

local SG = Instance.new("ScreenGui")
SG.Name = "DarkDev_Shutdown"
SG.ResetOnSpawn = false
pcall(function() SG.Parent = SafeGuiParent end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- Shutdown Main Window
local Frame = Instance.new("Frame", SG)
Frame.Size = UDim2.new(0, 320, 0, 190)
Frame.Position = UDim2.new(0.5, -160, 0.5, -95)
Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(255, 50, 50)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "⚠️ SCRIPT IS SHUTDOWN ⚠️"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local Subtitle = Instance.new("TextLabel", Frame)
Subtitle.Size = UDim2.new(1, -20, 0, 40)
Subtitle.Position = UDim2.new(0, 10, 0, 42)
Subtitle.Text = "Script is temporarily under development"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.TextWrapped = true
Subtitle.BackgroundTransparency = 1

local InfoLabel = Instance.new("TextLabel", Frame)
InfoLabel.Size = UDim2.new(1, -20, 0, 25)
InfoLabel.Position = UDim2.new(0, 10, 0, 88)
InfoLabel.Text = "For more info join our discord:"
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextSize = 11
InfoLabel.BackgroundTransparency = 1

local DiscordBox = Instance.new("TextBox", Frame)
DiscordBox.Size = UDim2.new(0.9, 0, 0, 32)
DiscordBox.Position = UDim2.new(0.05, 0, 0.68, 0)
DiscordBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
DiscordBox.Text = "https://discord.gg/PuzUYmM62"
DiscordBox.TextColor3 = Color3.fromRGB(0, 255, 255)
DiscordBox.Font = Enum.Font.Code
DiscordBox.TextSize = 10
DiscordBox.ClearTextOnFocus = false
DiscordBox.TextEditable = false
Instance.new("UICorner", DiscordBox)

local DStroke = Instance.new("UIStroke", DiscordBox)
DStroke.Color = Color3.fromRGB(124, 77, 255)

print("DarkDev Shutdown Notice Loaded.")
