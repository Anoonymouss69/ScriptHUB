-- 🌱 Simple Custom UI built without Rayfield
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "GardenHubUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 90, 30)
Title.Text = "🌱 Garden Hub PRO"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22

-- Auto Plant Button
local AutoPlantBtn = Instance.new("TextButton", Frame)
AutoPlantBtn.Position = UDim2.new(0, 10, 0, 60)
AutoPlantBtn.Size = UDim2.new(0, 280, 0, 40)
AutoPlantBtn.BackgroundColor3 = Color3.fromRGB(60,160,60)
AutoPlantBtn.Text = "Toggle Auto Plant"
AutoPlantBtn.TextColor3 = Color3.new(1,1,1)
AutoPlantBtn.Font = Enum.Font.SourceSans
AutoPlantBtn.TextSize = 20

local AutoPlant = false
AutoPlantBtn.MouseButton1Click:Connect(function()
    AutoPlant = not AutoPlant
    AutoPlantBtn.Text = AutoPlant and "Auto Plant: ON" or "Auto Plant: OFF"
    if AutoPlant then
        spawn(function()
            while AutoPlant do
                pcall(function()
                    game.ReplicatedStorage.GardenEvents.PlantSeed:FireServer()
                end)
                task.wait(2)
            end
        end)
    end
end)

-- Add more buttons similarly for Auto Water, Auto Sell, Fly, etc.
-- You can duplicate AutoPlantBtn, change Position, Text, and logic.

-- Simple Note
local Note = Instance.new("TextLabel", Frame)
Note.Position = UDim2.new(0, 10, 1, -30)
Note.Size = UDim2.new(1, -20, 0, 20)
Note.BackgroundTransparency = 1
Note.Text = "Made by Anonymous with help from ChatGPT"
Note.TextColor3 = Color3.new(1,1,1)
Note.Font = Enum.Font.SourceSansItalic
Note.TextSize = 14
