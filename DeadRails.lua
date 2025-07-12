-- 🌟 Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua"))()

local realKey = "Sweetie Fox"
local keyValidated = false

local Window = Rayfield:CreateWindow({
    Name = "🚂 Script Hub - Dead Rails",
    LoadingTitle = "Loading Script Hub...",
    LoadingSubtitle = "by Anonymous",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "DeadRailsScriptHub"
    },
    KeySystem = false
})

-- 🔑 Key Tab
local KeyTab = Window:CreateTab("🔑 Key", 4483362458)

KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Type your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text == realKey then
            keyValidated = true
            Rayfield:Notify({Title="✅ Key Correct", Content="Welcome!", Duration=3})
        else
            Rayfield:Notify({Title="❌ Wrong Key", Content="Check your key or click Get Key.", Duration=3})
        end
    end
})

KeyTab:CreateButton({
    Name = "🔑 Get Key (Linkvertise)",
    Callback = function()
        local link = "https://linkvertise.com/your-real-link" -- replace this!
        setclipboard(link)
        Rayfield:Notify({Title="Get Key", Content="Link copied! Complete task to get your key.", Duration=5})
    end
})

KeyTab:CreateButton({
    Name = "📌 Discord",
    Callback = function()
        setclipboard("https://discord.gg/7q2TvZ9GYX")
        Rayfield:Notify({Title="Discord", Content="Invite copied!", Duration=4})
    end
})

-- ⚙️ Features Tab
local MainTab = Window:CreateTab("⚙️ Features", 4483362458)

MainTab:CreateButton({
    Name = "Auto Bonds",
    Callback = function()
        if keyValidated then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
        else
            Rayfield:Notify({Title="Key Required", Content="Enter correct key first!", Duration=3})
        end
    end
})

MainTab:CreateParagraph({Title="", Content=""}) -- spacing

local FlyEnabled = false
MainTab:CreateToggle({
    Name = "Fly (press E)",
    CurrentValue = false,
    Callback = function(v)
        if not keyValidated then
            Rayfield:Notify({Title="Key Required", Content="Enter correct key first!", Duration=3})
            return
        end
        FlyEnabled = v
        if v then
            local flying = false
            local UIS = game:GetService("UserInputService")
            local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local bp, bg
            UIS.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if input.KeyCode == Enum.KeyCode.E then
                    flying = not flying
                    if flying then
                        bp = Instance.new("BodyPosition", hrp)
                        bp.MaxForce = Vector3.new(400000,400000,400000)
                        bp.P = 10000
                        bp.Position = hrp.Position
                        bg = Instance.new("BodyGyro", hrp)
                        bg.MaxTorque = Vector3.new(400000,400000,400000)
                        bg.CFrame = hrp.CFrame
                        spawn(function()
                            while flying and bp and bg do
                                bp.Position = hrp.Position + (hrp.CFrame.LookVector * 2)
                                bg.CFrame = workspace.CurrentCamera.CFrame
                                task.wait()
                            end
                        end)
                    else
                        if bp then bp:Destroy() end
                        if bg then bg:Destroy() end
                    end
                end
            end)
        end
    end
})

MainTab:CreateParagraph({Title="", Content=""}) -- spacing

MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value)
        if not keyValidated then
            Rayfield:Notify({Title="Key Required", Content="Enter correct key first!", Duration=3})
            return
        end
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = value end
    end
})

MainTab:CreateParagraph({Title="", Content=""}) -- spacing

MainTab:CreateButton({
    Name = "Lag Fix",
    Callback = function()
        if not keyValidated then
            Rayfield:Notify({Title="Key Required", Content="Enter correct key first!", Duration=3})
            return
        end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end
        Rayfield:Notify({Title="Lag Fix", Content="Lag reduced!", Duration=3})
    end
})

MainTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
        if not keyValidated then
            Rayfield:Notify({Title="Key Required", Content="Enter correct key first!", Duration=3})
            return
        end
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        setfpscap(60)
        Rayfield:Notify({Title="FPS Boost", Content="FPS cap set & boost applied!", Duration=3})
    end
})

MainTab:CreateParagraph({Title="", Content=""}) -- spacing

MainTab:CreateButton({
    Name = "ESP (Soon)",
    Callback = function()
        Rayfield:Notify({Title="ESP", Content="Feature coming soon!", Duration=3})
    end
})

-- 📌 Credit
Rayfield:Notify({
    Title="✅ Script Loaded",
    Content="Made by Anonymous with help from ChatGPT",
    Duration=5
})
