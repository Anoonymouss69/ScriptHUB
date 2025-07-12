-- 🌟 Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local realKey = "Sweetie Fox"

local Window = Rayfield:CreateWindow({
    Name = "🚂 Script Hub - Dead Rails",
    LoadingTitle = "Loading Script Hub...",
    LoadingSubtitle = "by Anonymous",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "DeadRailsScriptHub"
    },
    KeySystem = false,
    Discord = {
        Enabled = true,
        Invite = "7q2TvZ9GYX",
        RememberJoins = true
    },
    Logo = "https://github.com/Anoonymouss69/ScriptHUB/blob/main/hisuanpikachu.png?raw=true"
})

-- 🔑 Key Tab at start
local KeyTab = Window:CreateTab("🔑 Key", 4483362458)

KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Type your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text == realKey then
            Rayfield:Notify({Title="✅ Key Correct", Content="Welcome!", Duration=3})
            wait(0.5)
            local FeaturesTab = ShowFeaturesTab()
            KeyTab.Title = "✅ Key (Done)"
            Window:SelectTab(FeaturesTab)
        else
            Rayfield:Notify({Title="❌ Wrong Key", Content="Check your key or click Get Key.", Duration=3})
        end
    end
})

KeyTab:CreateButton({
    Name = "🔑 Get Key (Linkvertise)",
    Callback = function()
        local link = "https://linkvertise.com/your-real-link" -- replace!
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

-- 🛠 Function to create Features tab
function ShowFeaturesTab()
    local MainTab = Window:CreateTab("⚙️ Features", 4483362458)

    MainTab:CreateButton({
        Name = "Auto Bonds",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
        end
    })

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

    -- ✅ Fixed Fly
    local flying = false
    local flyBV = nil

    MainTab:CreateToggle({
        Name = "Fly (press E)",
        CurrentValue = false,
        Callback = function(v)
            flying = v
            if flying then
                local UIS = game:GetService("UserInputService")
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                UIS.InputBegan:Connect(function(input, gpe)
                    if gpe then return end
                    if input.KeyCode == Enum.KeyCode.E then
                        if flyBV then
                            flyBV:Destroy()
                            flyBV = nil
                            Rayfield:Notify({Title="Fly", Content="Fly Off", Duration=2})
                        else
                            flyBV = Instance.new("BodyVelocity")
                            flyBV.MaxForce = Vector3.new(100000,100000,100000)
                            flyBV.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                            flyBV.Parent = hrp
                            Rayfield:Notify({Title="Fly", Content="Fly On", Duration=2})
                            spawn(function()
                                while flyBV do
                                    flyBV.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                                    task.wait()
                                end
                            end)
                        end
                    end
                end)
            else
                if flyBV then
                    flyBV:Destroy()
                    flyBV = nil
                end
            end
        end
    })

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

    -- 🦘 Infinite Jump
    local IJEnabled = false
    MainTab:CreateToggle({
        Name = "🦘 Infinite Jump",
        CurrentValue = false,
        Callback = function(v)
            IJEnabled = v
            local UIS = game:GetService("UserInputService")
            UIS.JumpRequest:Connect(function()
                if IJEnabled then
                    local player = game.Players.LocalPlayer
                    local char = player.Character or player.CharacterAdded:Wait()
                    local hum = char:FindFirstChildWhichIsA("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    })

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

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
                        local player = game.Players.LocalPlayer
                        local char = player.Character or player.CharacterAdded:Wait()
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

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

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

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

    MainTab:CreateButton({
        Name = "FPS Boost",
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

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

    MainTab:CreateButton({
        Name = "ESP (Soon)",
        Callback = function()
            Rayfield:Notify({Title="ESP", Content="Feature coming soon!", Duration=3})
        end
    })

    MainTab:CreateParagraph({Title="", Content=""}) -- spacing

    -- 📺 YouTube
    MainTab:CreateButton({
        Name = "📺 Visit My YouTube",
        Callback = function()
            setclipboard("https://youtube.com/@scriptfarmer?si=ygLkjZhk4NCrJ_BA")
            Rayfield:Notify({Title="YouTube", Content="Channel link copied!", Duration=3})
        end
    })

    Rayfield:Notify({Title="✅ Script Hub Loaded!", Content="Made by Anonymous with help from ChatGPT", Duration=5})
    return MainTab
end
