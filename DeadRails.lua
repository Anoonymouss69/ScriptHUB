-- 🌱 Script Hub by Anonymous (with help from ChatGPT)

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Window
local Window = Rayfield:CreateWindow({
    Name = "🚀 Script Hub | Dead Rails",
    LoadingTitle = "Script Hub Loading...",
    LoadingSubtitle = "By Anonymous",
    ConfigurationSaving = { Enabled = false },
    Discord = {
        Enabled = true,
        Invite = "7q2TvZ9GYX",
        RememberJoins = false
    }
})

-- Custom Key
local CorrectKey = "Sweetie Fox"

-- Create Key Tab
local KeyTab = Window:CreateTab("🔑 Key System", 4483362458)

local userKey = ""
KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Enter your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        userKey = text
    end
})

KeyTab:CreateButton({
    Name = "✅ Submit Key",
    Callback = function()
        if userKey == CorrectKey then
            Rayfield:Notify({
                Title = "✅ Success",
                Content = "Correct key! Loading features...",
                Duration = 3
            })
            ShowFeaturesTab()
        else
            Rayfield:Notify({
                Title = "❌ Wrong Key",
                Content = "Please get the correct key from Linkvertise.",
                Duration = 3
            })
        end
    end
})

KeyTab:CreateButton({
    Name = "🔑 Get Key (Linkvertise)",
    Callback = function()
        setclipboard("https://linkvertise.com/123456/your-key-page")
        Rayfield:Notify({Title="Key Link", Content="Link copied to clipboard!", Duration=4})
    end
})

-- ✨ Features tab (hidden until correct key)
function ShowFeaturesTab()
    local MainTab = Window:CreateTab("⚙️ Features", 4483362458)

    -- WalkSpeed slider
    MainTab:CreateSlider({
        Name = "WalkSpeed",
        Range = {16, 100},
        Increment = 1,
        CurrentValue = 16,
        Callback = function(value)
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.WalkSpeed = value end
        end
    })

    -- 🧊 Noclip
    local NoclipEnabled = false
    MainTab:CreateToggle({
        Name = "🧊 Noclip",
        CurrentValue = false,
        Callback = function(v)
            NoclipEnabled = v
            if v then
                game:GetService("RunService").Stepped:Connect(function()
                    if NoclipEnabled then
                        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end
    })

    -- Auto Bonds
    MainTab:CreateButton({
        Name = "💰 Auto Bonds",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
        end
    })

    -- FPS Boost
    MainTab:CreateButton({
        Name = "⚡ FPS Boost",
        Callback = function()
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

    -- ESP soon
    MainTab:CreateButton({
        Name = "👀 ESP (Soon)",
        Callback = function()
            Rayfield:Notify({Title="ESP", Content="Feature coming soon!", Duration=3})
        end
    })

    -- 🦘 Infinite Jump
    local IJEnabled = false
    local IJConnection
    MainTab:CreateToggle({
        Name = "🦘 Infinite Jump",
        CurrentValue = false,
        Callback = function(v)
            IJEnabled = v
            if IJEnabled and not IJConnection then
                IJConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character or player.CharacterAdded:Wait()
                    local hum = char:FindFirstChildWhichIsA("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            elseif not IJEnabled and IJConnection then
                IJConnection:Disconnect()
                IJConnection = nil
            end
        end
    })

    -- ✈️ Fly (press E)
    local flying = false
    local flyConnection
    local hrp
    MainTab:CreateToggle({
        Name = "✈️ Fly (press E)",
        CurrentValue = false,
        Callback = function(v)
            flying = v
            if flying then
                hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                flyConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
                    if gpe then return end
                    if input.KeyCode == Enum.KeyCode.E then
                        if not hrp:FindFirstChild("BodyVelocity") then
                            local bv = Instance.new("BodyVelocity")
                            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                            bv.Velocity = Vector3.new(0,0,0)
                            bv.Parent = hrp
                            Rayfield:Notify({Title="Fly", Content="Fly On (use joystick/keys)", Duration=2})
                        else
                            hrp.BodyVelocity:Destroy()
                            Rayfield:Notify({Title="Fly", Content="Fly Off", Duration=2})
                        end
                    end
                end)
            else
                if flyConnection then flyConnection:Disconnect() end
                if hrp and hrp:FindFirstChild("BodyVelocity") then
                    hrp.BodyVelocity:Destroy()
                end
            end
        end
    })

    -- 📺 YouTube
    MainTab:CreateButton({
        Name = "📺 Visit My YouTube",
        Callback = function()
            setclipboard("https://youtube.com/@scriptfarmer?si=ygLkjZhk4NCrJ_BA")
            Rayfield:Notify({Title="YouTube", Content="Channel link copied!", Duration=3})
        end
    })

    -- 💬 Discord
    MainTab:CreateButton({
        Name = "💬 Join My Discord",
        Callback = function()
            setclipboard("https://discord.gg/7q2TvZ9GYX")
            Rayfield:Notify({Title="Discord", Content="Discord invite copied!", Duration=3})
        end
    })

    -- 🛠 Coming soon
    MainTab:CreateParagraph({
        Title = "🛠 Coming Soon",
        Content = "More features will be added in future updates!"
    })

    Rayfield:Notify({Title="✅ Script Hub Loaded!", Content="Made by Anonymous with help from ChatGPT", Duration=5})
end
