-- [[ 67 HUB - MULTI-INSTANCE SAFE VERSION ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Specifically check if the RNG instance is the one active in the container
local function GetCurrentInstance()
    local things = Workspace:FindFirstChild("__THINGS")
    if things then
        local container = things:FindFirstChild("__INSTANCE_CONTAINER")
        if container and container:FindFirstChild("Active") then
            -- We look for RngInstance specifically as seen in image_872f56.png
            local activeInstance = container.Active:FindFirstChildOfClass("Folder") 
            return activeInstance and activeInstance.Name or nil
        end
    end
    return nil
end

local function JoinRngEvent()
    local current = GetCurrentInstance()
    
    -- Only attempt join if we aren't already there
    if current ~= "RngInstance" then
        local network = ReplicatedStorage:WaitForChild("Network")
        -- Using the specific enter remote from image_86d93c.png
        local enterRemote = network:FindFirstChild("Instancing_PlayerEnterInstance")
        
        if enterRemote then
            -- Tell the server we want the RNG world specifically
            enterRemote:InvokeServer("RngInstance")
            warn("67 HUB: Sending request to enter RngInstance...")
            task.wait(3)
        end
    end
end

JoinRngEvent()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Admin",
   LoadingTitle = "Checking Instance State...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = { Enabled = false }
})

-- [[ RNG & CRAFTING TAB ]]
local RngTab = Window:CreateTab("RNG Event", 4483362458)

RngTab:CreateToggle({
   Name = "Auto-Roll Dice (High Speed)",
   CurrentValue = false,
   Flag = "RngAutoRoll",
   Callback = function(Value)
      _G.AutoRollActive = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/autoroll.lua"))()
      end
   end,
})

RngTab:CreateToggle({
   Name = "Auto-Craft (Priority: II -> Mega -> Mega II)",
   CurrentValue = false,
   Flag = "AutoCraftToggle",
   Callback = function(Value)
      _G.AutoCraftActive = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/autocraft.lua"))()
      end
   end,
})

-- [[ ADMIN EVENTS TAB ]]
local AdminTab = Window:CreateTab("Admin Events", 4483362458)
AdminTab:CreateToggle({
   Name = "Auto-Claim Admin",
   CurrentValue = false,
   Flag = "AdminAbuseToggle",
   Callback = function(Value)
      getgenv().AdminEnabled = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/adminabuse.lua"))()
      end
   end,
})

Rayfield:Notify({
   Title = "67 HUB Active",
   Content = "Current Instance: " .. (GetCurrentInstance() or "Main World"),
   Duration = 5
})
