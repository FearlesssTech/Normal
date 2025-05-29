if not game:IsLoaded() then game.Loaded:Wait() end

setclipboard("@Purplelzy")

-- Config
local CONFIG = {
    TargetPlaceId = 126884695634066, -- Example ID, use your actual target
    MaxPlaceVersion = 1273
}

local function prompt(title, text)
    -- Prompt UI function unchanged...
    -- For simplicity, I'll assume your existing prompt function works.
    -- If you need a placeholder for testing:
    --[[
    print("PROMPT:", title, text)
    local result = obstáculos -- or some other way to get user input in your environment
    return result
    --]]
    -- As this function isn't fully provided, its behavior in a real environment might vary.
    -- For this example, I'll make it return true for "yes" to proceed with testing.
    if title:match("OLD SERVER DETECTED") or title:match("BLOODMOON DETECTED") then
        -- Simulating user clicking "Yes" in the prompt to allow server hop testing
        return true
    end
    return false -- Default for other prompts if any
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

-- Function to create and manage the configuration GUI
local function createConfigGui(configTable)
    local guiFinished = Instance.new("BindableEvent")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ConfigVersionGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui") -- Or PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 150)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansSemibold
    titleLabel.TextSize = 18
    titleLabel.Text = "Configure Max Place Version"
    titleLabel.Parent = mainFrame

    local versionLabel = Instance.new("TextLabel")
    versionLabel.Name = "VersionLabel"
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
    versionInput.Name = "VersionInput"
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
    applyButton.Name = "ApplyButton"
    applyButton.Size = UDim2.new(0.4, 0, 0, 30)
    applyButton.Position = UDim2.new(0.05, 0, 0, 105)
    applyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.Font = Enum.Font.SourceSansBold
    applyButton.TextSize = 16
    applyButton.Text = "Apply"
    applyButton.Parent = mainFrame

    local defaultButton = Instance.new("TextButton")
    defaultButton.Name = "DefaultButton"
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
            configTable.MaxPlaceVersion = math.floor(newVersion) -- Ensure it's an integer
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
    
    -- If user closes the GUI via exploit means or disconnects
    screenGui.DescendantRemoving:Connect(function(descendant)
        if descendant == mainFrame and not guiFinished:IsEventFired() then -- Check if already fired
            pcall(function() guiFinished:Fire() end) -- Fire if not already, safely
        end
    end)


    return guiFinished
end

-- Show config GUI and wait for user input
local guiEvent = createConfigGui(CONFIG)
guiEvent.Event:Wait()
guiEvent:Destroy() -- Clean up the BindableEvent itself

-- The rest of your script starts here, using the potentially updated CONFIG.MaxPlaceVersion

local q = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end
local shf = [[
if not _G.exeonce then
_G.exeonce = true
repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FearlesssTech/Normal/main/Hop-Server.lua"))()
end
]]
q(shf)

local function checkBloodMoon()
    local shrine = workspace.Interaction.UpdateItems:FindFirstChild("BloodMoonShrine")
    if shrine and shrine:IsA("Model") then
        local part = shrine.PrimaryPart or shrine:FindFirstChildWhichIsA("BasePart")
        if part then
            -- Increased tolerance slightly for floating point inaccuracies
            return (part.Position - Vector3.new(-83.157, 0.3, -11.295)).Magnitude < 0.5
        end
    end
    return false
end

local lastHopAttempt = 0
local function sh()
    if os.time() - lastHopAttempt < 5 then
        nt("Please Wait", "Server hop cooldown...")
        return false
    end
    lastHopAttempt = os.time()

    local req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request  
    if not req then   
        nt("Error", "No HTTP request function available")  
        return false  
    end  
    task.wait(math.random(1, 3))  

    local hs = game:GetService("HttpService")  
    local tp = game:GetService("TeleportService")  
    local res = req({  
        Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",  
        Method = "GET"  
    })  

    if res.StatusCode == 429 then  
        nt("Rate Limited", "Please wait a few minutes before trying again")  
        return false  
    elseif res.StatusCode ~= 200 then   
        nt("Error", "Server request failed (Code: "..res.StatusCode..")")  
        return false   
    end  

    local success, data = pcall(hs.JSONDecode, hs, res.Body)  
    if not success or not data or not data.data then   
        nt("Error", "Failed to read server data")  
        return false  
    end  

    local list = {}  
    for _, v in ipairs(data.data) do  
        if type(v) == "table" and v.id ~= game.JobId then  
            local playing = tonumber(v.playing) or 0  
            local max = tonumber(v.maxPlayers) or 100  
            local placeVersion = v.placeVersion or 0  
            if playing < max and placeVersion <= CONFIG.MaxPlaceVersion then  -- Uses updated config
                table.insert(list, v.id)  
            end  
        end  
    end  

    if #list > 0 then  
        nt("Server Hop", "Teleporting to better server...")  
        task.wait(0.5)  
        tp:TeleportToPlaceInstance(game.PlaceId, list[math.random(#list)])  
        return true  
    else  
        nt("No Servers", "No available servers found matching version <= "..CONFIG.MaxPlaceVersion) -- More informative
        return false  
    end
end

-- Now these calculations use the (potentially user-modified) CONFIG.MaxPlaceVersion
local isOld = game.PlaceVersion <= CONFIG.MaxPlaceVersion 
local isBloodMoon = checkBloodMoon()

local function waitForBloodMoon()
    local connection 
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        if checkBloodMoon() then
            if connection then connection:Disconnect() end
            nt("BLOOD MOON", "Blood Moon event has started!")
        end
    end)
end

if isOld and isBloodMoon then
    nt("Perfect Server!", "Old version ("..game.PlaceVersion..") + Blood Moon active!")
elseif isOld and not isBloodMoon then
    nt("Old Server!", "Version: "..game.PlaceVersion.. " (Max allowed: " .. CONFIG.MaxPlaceVersion .. ")")
    local e = prompt("OLD SERVER DETECTED", "This server is an old version ("..game.PlaceVersion.."). Would you like to server-hop to find one with a Blood Moon, or stay and wait?")
    if e then -- Assuming prompt returns true for "yes" to hop
        nt("Server-hop accepted.", "Looking for another server...")
        local success_sh = sh()
        if not success_sh then
            task.wait(5)
            sh() -- Try one more time
        end
    else
        nt("Server-hop declined.", "Staying to wait for Blood Moon event.")
        waitForBloodMoon()
    end
elseif isBloodMoon and not isOld then
    nt("New Server with Blood Moon", "Version: "..game.PlaceVersion.." (Max allowed: " .. CONFIG.MaxPlaceVersion .. ")")
    local e = prompt("BLOODMOON DETECTED", "Bloodmoon event detected in this newer server. Hop to find an old server (v" .. CONFIG.MaxPlaceVersion .. " or less) with Bloodmoon?")
    if e then
        nt("Server-hop accepted.", "Looking for an older server with Blood Moon...")
        local success_sh = sh()
        if not success_sh then
            task.wait(5)
            sh()
        end
    else
        nt("Server-hop declined.", "Staying for Blood Moon event in new server.")
    end
else -- Not old and Not Blood Moon
    nt("New Server Detected!", "Version: " .. game.PlaceVersion .. " (Max allowed: " .. CONFIG.MaxPlaceVersion .. ")")
    task.wait(0.5)
    nt("Searching...", "Looking for an old server (v" .. CONFIG.MaxPlaceVersion .. " or less)...")
    local success_sh = sh()
    if not success_sh then
        task.wait(5)
        sh()
    end
end
