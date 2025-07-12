-- 🌟 Load Rayfield (no built-in key system)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua"))()

-- 🗝 Custom key
local realKey = "Sweetie Fox"
local keyEntered = false

-- 🌟 Create hidden window first
local Window = Rayfield:CreateWindow({
    Name = "🚂 Script Hub - Dead Rails",
    LoadingTitle = "Loading Script Hub...",
    LoadingSubtitle = "by Anonymous",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "DeadRailsScriptHub"
    },
    KeySystem = false -- disable built-in
})

-- 🗝 Key Tab
local KeyTab = Window:CreateTab("🔑 Key", 4483362458)

-- TextBox for key input
KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Type your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text == realKey then
            keyEntered = true
            Rayfield:Notify({Title="✅ Key Correct", Content="Access granted!", Duration=3})
            wait(0.5)
            ShowMainGUI() -- show real GUI
        else
            Rayfield:Notify({Title="❌ Wrong Key", Content="Check your key or click Get Key.", Duration=3})
        end
    end
})

-- Get Key button
KeyTab:CreateButton({
    Name = "🔑 Get Key (Linkvertise)",
    Callback = function()
        local link = "https://linkvertise.com/your-real-link" -- replace with real link
        setclipboard(link)
        Rayfield:Notify({
            Title = "Get Key",
            Content = "Link copied! Open & complete task to get your key.",
            Duration = 5
        })
        -- optional open directly
        if syn and syn.open then
            syn.open(link)
        elseif getgenv and getgenv().open then
            getgenv().open(link)
        elseif KRNL_LOADED then
            game:HttpGet(link)
        end
    end
})

-- 📦 Function to create main GUI after key is correct
function ShowMainGUI()
    local MainTab = Window:CreateTab("⚙️ Features", 4483362458)

    MainTab:CreateButton({
        Name = "Auto Bonds",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
        end
    })

    -- Fly toggle
    local FlyEnabled = false
    MainTab:CreateToggle({
        Name = "Fly (press E to toggle)",
        CurrentValue = false,
        Callback = function(v)
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

    -- Anti Lag
    MainTab:CreateButton({
        Name = "Anti Lag",
        Callback = function()
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
            Rayfield:Notify({Title="Anti Lag", Content="Laggy effects removed!", Duration=3})
        end
    })

    -- FPS Boost
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
            Rayfield:Notify({Title="FPS Boost", Content="Applied FPS boost settings!", Duration=3})
        end
    })

    -- Discord button
    MainTab:CreateButton({
        Name = "Join our Discord",
        Callback = function()
            setclipboard("https://discord.gg/7q2TvZ9GYX")
            Rayfield:Notify({Title="Discord", Content="Invite copied to clipboard!", Duration=4})
        end
    })

    -- ESP placeholder
    MainTab:CreateButton({
        Name = "ESP (Coming soon)",
        Callback = function()
            Rayfield:Notify({Title="ESP", Content="Feature not ready yet!", Duration=3})
        end
    })

    Rayfield:Notify({
        Title="✅ Script Hub Loaded!",
        Content="Made by Anonymous with help from ChatGPT",
        Duration=5
    })
end
