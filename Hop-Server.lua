if not game:IsLoaded() then game.Loaded:Wait() end

setclipboard("@Purplelzy")

-- Config
local CONFIG = {
    TargetPlaceId = 126884695634066,
    MaxPlaceVersion = 1273
}

local function prompt(title, text)
    if title:match("OLD SERVER DETECTED") or title:match("BLOODMOON DETECTED") then
        return true
    end
    return false
end

local o = loadstring(game:HttpGet("https://paste.ee/r/E9tFZ/0"))()
function nt(n, c)
    o:MakeNotification({
        Name = n,
        Content = c,
        Image = "rbxassetid://4483345998",
        Time = 6
    })
end

if game.PlaceId ~= CONFIG.TargetPlaceId then
    nt("Wrong Game", "This script is for Grow a Garden only!")
    return
end

-- GUI function (no changes)
local function createConfigGui(configTable)
    local guiFinished = Instance.new("BindableEvent")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ConfigVersionGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 150)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansSemibold
    titleLabel.TextSize = 18
    titleLabel.Text = "Configure Max Place Version"
    titleLabel.Parent = mainFrame

    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0.9, 0, 0, 20)
    versionLabel.Position = UDim2.new(0.05, 0, 0, 40)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    versionLabel.Font = Enum.Font.SourceSans
    versionLabel.TextSize = 14
    versionLabel.Text = "Max Place Version:"
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = mainFrame

    local versionInput = Instance.new("TextBox")
    versionInput.Size = UDim2.new(0.9, 0, 0, 30)
    versionInput.Position = UDim2.new(0.05, 0, 0, 60)
    versionInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    versionInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    versionInput.Font = Enum.Font.SourceSans
    versionInput.TextSize = 16
    versionInput.Text = tostring(configTable.MaxPlaceVersion)
    versionInput.ClearTextOnFocus = false
    versionInput.Parent = mainFrame

    local applyButton = Instance.new("TextButton")
    applyButton.Size = UDim2.new(0.4, 0, 0, 30)
    applyButton.Position = UDim2.new(0.05, 0, 0, 105)
    applyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.Font = Enum.Font.SourceSansBold
    applyButton.TextSize = 16
    applyButton.Text = "Apply"
    applyButton.Parent = mainFrame

    local defaultButton = Instance.new("TextButton")
    defaultButton.Size = UDim2.new(0.4, 0, 0, 30)
    defaultButton.Position = UDim2.new(0.55, 0, 0, 105)
    defaultButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    defaultButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    defaultButton.Font = Enum.Font.SourceSansBold
    defaultButton.TextSize = 16
    defaultButton.Text = "Use Default"
    defaultButton.Parent = mainFrame

    applyButton.MouseButton1Click:Connect(function()
        local newVersion = tonumber(versionInput.Text)
        if newVersion and newVersion > 0 then
            configTable.MaxPlaceVersion = math.floor(newVersion)
            nt("Config Updated", "Max Place Version set to: " .. configTable.MaxPlaceVersion)
        else
            nt("Config Error", "Invalid version. Using default: " .. configTable.MaxPlaceVersion)
        end
        screenGui:Destroy()
        guiFinished:Fire()
    end)

    defaultButton.MouseButton1Click:Connect(function()
        nt("Config Info", "Using default Max Place Version: " .. configTable.MaxPlaceVersion)
        screenGui:Destroy()
        guiFinished:Fire()
    end)

    screenGui.DescendantRemoving:Connect(function(descendant)
        if descendant == mainFrame and not guiFinished:IsEventFired() then
            pcall(function() guiFinished:Fire() end)
        end
    end)

    return guiFinished
end

-- ✅ Show GUI only if first join
if not _G.guiAlreadyShown then
    _G.guiAlreadyShown = true
    local guiEvent = createConfigGui(CONFIG)
    guiEvent.Event:Wait()
    guiEvent:Destroy()
end

-- Continue to teleport queue setup, logic, etc.
local q = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end
local shf = [[
if not _G.exeonce then
_G.exeonce = true
repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FearlesssTech/Normal/main/Hop-Server.lua"))()
end
]]
q(shf)

-- Rest of your server hopping logic remains unchanged...
-- (checkBloodMoon, sh(), and main decision logic, etc.)