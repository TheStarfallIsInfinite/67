-- [[ 67 HUB - MANUAL INSTANCE VERSION ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Admin",
   LoadingTitle = "Connecting to GitHub...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = { Enabled = false }
})

-- SafeLoad function to prevent the red "Callback Error" box
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        Rayfield:Notify({
            Title = "Fetch Error",
            Content = "Could not find module at the URL. Check GitHub path.",
            Duration = 5
        })
        warn("67 HUB URL Error: " .. tostring(result))
    end
end

-- [[ RNG TAB ]]
local RngTab = Window:CreateTab("RNG Event", 4483362458)

RngTab:CreateSection("Auto Rolling")

RngTab:CreateToggle({
   Name = "Auto-Roll Dice (High Speed)",
   CurrentValue = false,
   Flag = "RngAutoRoll",
   Callback = function(Value)
      _G.AutoRollActive = Value
      if Value then
          -- Uses corrected username: TheStarfallIsInfinite
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/autoroll.lua")
      end
   end,
})

RngTab:CreateSection("Auto Crafting")

RngTab:CreateToggle({
   Name = "Auto-Craft (II -> Mega -> Mega II)",
   CurrentValue = false,
   Flag = "AutoCraftToggle",
   Callback = function(Value)
      _G.AutoCraftActive = Value
      if Value then
          -- Uses corrected username: TheStarfallIsInfinite
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/autocraft.lua")
      end
   end,
})

-- [[ ADMIN TAB ]]
local AdminTab = Window:CreateTab("Admin Events", 4483362458)

AdminTab:CreateToggle({
   Name = "Auto-Claim Admin",
   CurrentValue = false,
   Flag = "AdminAbuseToggle",
   Callback = function(Value)
      getgenv().AdminEnabled = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/adminabuse.lua")
      end
   end,
})

Rayfield:Notify({
   Title = "67 HUB Loaded",
   Content = "Ready. Please ensure you are in the RNG zone before toggling.",
   Duration = 5
})
