--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameBox = Instance.new("TextBox")
local ToggleOrbit = Instance.new("TextButton")
local ToggleGui = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local function fadeIn()
    MainFrame.Visible = true
    MainFrame.BackgroundTransparency = 1
    for i = 1, 10 do
        MainFrame.BackgroundTransparency = MainFrame.BackgroundTransparency - 0.1
        wait(0.02)
    end
end

Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundTransparency = 1
Title.Text = "Orbit Script"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

NameBox.Size = UDim2.new(0.8, 0, 0.2, 0)
NameBox.Position = UDim2.new(0.1, 0, 0.25, 0)
NameBox.PlaceholderText = "Enter Player Name"
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 14
NameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.Parent = MainFrame

SpeedSlider.Size = UDim2.new(0.8, 0, 0.2, 0)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.5, 0)
SpeedSlider.PlaceholderText = "Orbit Speed (Default: 2)"
SpeedSlider.Font = Enum.Font.Gotham
SpeedSlider.TextSize = 14
SpeedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.Parent = MainFrame

ToggleOrbit.Size = UDim2.new(0.8, 0, 0.2, 0)
ToggleOrbit.Position = UDim2.new(0.1, 0, 0.75, 0)
ToggleOrbit.Text = "Start Orbit"
ToggleOrbit.Font = Enum.Font.GothamBold
ToggleOrbit.TextSize = 14
ToggleOrbit.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
ToggleOrbit.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleOrbit.Parent = MainFrame

ToggleGui.Size = UDim2.new(0, 50, 0, 50)
ToggleGui.Position = UDim2.new(0.92, -55, 0.05, 0)
ToggleGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleGui.Text = "🛰️"
ToggleGui.Font = Enum.Font.GothamBold
ToggleGui.TextSize = 20
ToggleGui.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGui.Parent = ScreenGui
ToggleGui.Active = true
ToggleGui.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 25)
ToggleCorner.Parent = ToggleGui

local orbiting = false
local targetPlayer
local function getTarget()
    local inputText = string.lower(NameBox.Text)
    for _, player in pairs(Players:GetPlayers()) do
        if string.find(string.lower(player.Name), inputText) or string.find(string.lower(player.DisplayName), inputText) then
            return player
        end
    end
end

local function orbitTarget()
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local angle = 0
    local speed = tonumber(SpeedSlider.Text) or 2

    while orbiting do
        if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            orbiting = false
            ToggleOrbit.Text = "Start Orbit"
            game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
            repeat
                wait(1)
                targetPlayer = getTarget()
            until targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            orbiting = true
        end

        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local newPosition = targetPosition + Vector3.new(math.cos(angle) * 2, 0, math.sin(angle) * 2)
        humanoidRootPart.CFrame = CFrame.new(newPosition, targetPosition)
        game.Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")

        angle = angle + math.rad(speed)
        RunService.RenderStepped:Wait()
    end
end

ToggleOrbit.MouseButton1Click:Connect(function()
    if orbiting then
        orbiting = false
        ToggleOrbit.Text = "Start Orbit"
        game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
    else
        targetPlayer = getTarget()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            orbiting = true
            ToggleOrbit.Text = "Stop Orbit"
            orbitTarget()
        end
    end
end)

ToggleGui.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame.Visible = false
    else
        fadeIn()
    end
end)
