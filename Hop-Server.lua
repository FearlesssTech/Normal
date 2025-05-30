if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local function promptInput()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VersionPrompt"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 150)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = "Enter Target Version"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(200, 200, 255)

    local TextBox = Instance.new("TextBox", Frame)
    TextBox.Size = UDim2.new(0.8, 0, 0, 30)
    TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    TextBox.PlaceholderText = "e.g. 1273"
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 16
    TextBox.Text = ""
    TextBox.ClearTextOnFocus = false
    TextBox.TextColor3 = Color3.new(1,1,1)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

    local Submit = Instance.new("TextButton", Frame)
    Submit.Size = UDim2.new(0.6, 0, 0, 30)
    Submit.Position = UDim2.new(0.2, 0, 0.75, 0)
    Submit.Text = "Confirm"
    Submit.Font = Enum.Font.GothamBold
    Submit.TextSize = 14
    Submit.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
    Submit.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 6)

    local version = nil
    Submit.MouseButton1Click:Connect(function()
        local n = tonumber(TextBox.Text)
        if n then
            version = n
            ScreenGui:Destroy()
        else
            TextBox.Text = ""
            TextBox.PlaceholderText = "Please enter a valid number"
        end
    end)

    while ScreenGui.Parent and not version do
        task.wait()
    end

    return version
end

-- Only show GUI if _G.TargetVersion doesn't exist
if not _G.TargetVersion then
    _G.TargetVersion = promptInput()
end

local function checkBloodMoon()
    local shrine = workspace:FindFirstChild("Interaction") and workspace.Interaction:FindFirstChild("UpdateItems") and workspace.Interaction.UpdateItems:FindFirstChild("BloodMoonShrine")
    if shrine and shrine:IsA("Model") then
        local part = shrine.PrimaryPart or shrine:FindFirstChildWhichIsA("BasePart")
        if part then
            return (part.Position - Vector3.new(-83.157, 0.3, -11.295)).Magnitude < 0.1
        end
    end
    return false
end

local function serverHop()
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if not req then warn("No HTTP support") return end

    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")

    local response = req({
        Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
        Method = "GET"
    })

    if response.StatusCode ~= 200 then return end

    local servers = HttpService:JSONDecode(response.Body).data
    for _, server in ipairs(servers) do
        if server.id ~= game.JobId and tonumber(server.placeVersion) <= _G.TargetVersion then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id)
            return
        end
    end
end

local function handleLogic()
    local isOld = game.PlaceVersion <= _G.TargetVersion
    local isBloodMoon = checkBloodMoon()

    if isOld and isBloodMoon then
        print("✅ Perfect server: Old + Bloodmoon!")
    elseif isOld then
        print("🕓 Waiting for Bloodmoon in old version server...")
    elseif isBloodMoon then
        print("⚠️ Bloodmoon found but wrong version. Hopping...")
        serverHop()
    else
        print("❌ New version. Looking for old one...")
        serverHop()
    end
end

-- Re-inject logic on teleport
local queueFunc = queue_on_teleport or (syn and syn.queue_on_teleport)
if queueFunc then
    queueFunc(loadstring(game:HttpGet("https://raw.githubusercontent.com/FearlesssTech/Normal/main/Hop-Server.lua"))()) -- Replace with your hosting URL
end

handleLogic()