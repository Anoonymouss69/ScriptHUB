bit32 = {};
local N = 32;
local P = 2 ^ N;
bit32.bnot = function(x)
	x = x % P;
	return (P - 1) - x;
end;
bit32.band = function(x, y)
	if (y == 255) then
		return x % 256;
	end
	if (y == 65535) then
		return x % 65536;
	end
	if (y == 4294967295) then
		return x % 4294967296;
	end
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 2) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.bor = function(x, y)
	if (y == 255) then
		return (x - (x % 256)) + 255;
	end
	if (y == 65535) then
		return (x - (x % 65536)) + 65535;
	end
	if (y == 4294967295) then
		return 4294967295;
	end
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) >= 1) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.bxor = function(x, y)
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 1) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.lshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount < 0) then
		return math.floor(x * (2 ^ s_amount));
	else
		return (x * (2 ^ s_amount)) % P;
	end
end;
bit32.rshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount > 0) then
		return math.floor(x * (2 ^ -s_amount));
	else
		return (x * (2 ^ -s_amount)) % P;
	end
end;
bit32.arshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount > 0) then
		local add = 0;
		if (x >= (P / 2)) then
			add = P - (2 ^ (N - s_amount));
		end
		return math.floor(x * (2 ^ -s_amount)) + add;
	else
		return (x * (2 ^ -s_amount)) % P;
	end
end;
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))();
local Window = Rayfield:CreateWindow({Name="ðŸš€ Script Hub | Dead Rails",LoadingTitle="Script Hub Loading...",LoadingSubtitle="By Anonymous",ConfigurationSaving={Enabled=false},Discord={Enabled=true,Invite="7q2TvZ9GYX",RememberJoins=false}});
local CorrectKey = "Sweetie Fox";
local KeyTab = Window:CreateTab("ðŸ”‘ Key System", 4483362458);
local userKey = "";
KeyTab:CreateInput({Name="Enter Key",PlaceholderText="Enter your key here...",RemoveTextAfterFocusLost=false,Callback=function(text)
	userKey = text;
end});
KeyTab:CreateButton({Name="âœ… Submit Key",Callback=function()
	if (userKey == CorrectKey) then
		Rayfield:Notify({Title="âœ… Success",Content="Correct key! Loading features...",Duration=3});
		ShowFeaturesTab();
	else
		Rayfield:Notify({Title="âŒ Wrong Key",Content="Please get the correct key from Linkvertise.",Duration=3});
	end
end});
KeyTab:CreateButton({Name="ðŸ”‘ Get Key (Linkvertise)",Callback=function()
	setclipboard("https://link-center.net/1366248/UtvYmmLaX01m");
	Rayfield:Notify({Title="Key Link",Content="Link copied to clipboard!",Duration=4});
end});
function ShowFeaturesTab()
	local MainTab = Window:CreateTab("âš™ï¸ Features", 4483362458);
	MainTab:CreateSlider({Name="WalkSpeed",Range={16,100},Increment=1,CurrentValue=16,Callback=function(value)
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid");
		if hum then
			hum.WalkSpeed = value;
		end
	end});
	local NoclipEnabled = false;
	MainTab:CreateToggle({Name="ðŸ§Š Noclip",CurrentValue=false,Callback=function(v)
		NoclipEnabled = v;
		if v then
			game:GetService("RunService").Stepped:Connect(function()
				if NoclipEnabled then
					local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait();
					for _, part in pairs(char:GetDescendants()) do
						if (part:IsA("BasePart") and part.CanCollide) then
							part.CanCollide = false;
						end
					end
				end
			end);
		end
	end});
	MainTab:CreateButton({Name="ðŸ’° Auto Bonds",Callback=function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))();
	end});
	MainTab:CreateButton({Name="âš¡ FPS Boost",Callback=function()
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic;
			elseif (v:IsA("Decal") or v:IsA("Texture")) then
				v.Transparency = 1;
			elseif (v:IsA("ParticleEmitter") or v:IsA("Trail")) then
				v.Enabled = false;
			end
		end
		setfpscap(60);
		Rayfield:Notify({Title="FPS Boost",Content="FPS cap set & boost applied!",Duration=3});
	end});
	MainTab:CreateButton({Name="ðŸ‘€ ESP (Soon)",Callback=function()
		Rayfield:Notify({Title="ESP",Content="Feature coming soon!",Duration=3});
	end});
	local IJEnabled = false;
	local IJConnection;
	MainTab:CreateToggle({Name="ðŸ¦˜ Infinite Jump",CurrentValue=false,Callback=function(v)
		IJEnabled = v;
		if (IJEnabled and not IJConnection) then
			IJConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
				local player = game.Players.LocalPlayer;
				local char = player.Character or player.CharacterAdded:Wait();
				local hum = char:FindFirstChildWhichIsA("Humanoid");
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Jumping);
				end
			end);
		elseif (not IJEnabled and IJConnection) then
			IJConnection:Disconnect();
			IJConnection = nil;
		end
	end});
	local flying = false;
	local flyConnection;
	local hrp;
	MainTab:CreateToggle({Name="âœˆï¸ Fly (press E)",CurrentValue=false,Callback=function(v)
		flying = v;
		if flying then
			hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart");
			flyConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
				if gpe then
					return;
				end
				if (input.KeyCode == Enum.KeyCode.E) then
					if not hrp:FindFirstChild("BodyVelocity") then
						local bv = Instance.new("BodyVelocity");
						bv.MaxForce = Vector3.new(100000, 100000, 100000);
						bv.Velocity = Vector3.new(0, 0, 0);
						bv.Parent = hrp;
						Rayfield:Notify({Title="Fly",Content="Fly On (use joystick/keys)",Duration=2});
					else
						hrp.BodyVelocity:Destroy();
						Rayfield:Notify({Title="Fly",Content="Fly Off",Duration=2});
					end
				end
			end);
		else
			if flyConnection then
				flyConnection:Disconnect();
			end
			if (hrp and hrp:FindFirstChild("BodyVelocity")) then
				hrp.BodyVelocity:Destroy();
			end
		end
	end});
	MainTab:CreateButton({Name="ðŸ“º Visit My YouTube",Callback=function()
		setclipboard("https://youtube.com/@scriptfarmer?si=ygLkjZhk4NCrJ_BA");
		Rayfield:Notify({Title="YouTube",Content="Channel link copied!",Duration=3});
	end});
	MainTab:CreateButton({Name="ðŸ’¬ Join My Discord",Callback=function()
		setclipboard("https://discord.gg/7q2TvZ9GYX");
		Rayfield:Notify({Title="Discord",Content="Discord invite copied!",Duration=3});
	end});
	MainTab:CreateParagraph({Title="ðŸ›  Coming Soon",Content="More features will be added in future updates!"});
	Rayfield:Notify({Title="âœ… Script Hub Loaded!",Content="Made by Anonymous",Duration=5});
end
