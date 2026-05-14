-- [[ 67 HUB | THESTARFALLISINFINITE ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Utility",
   LoadingTitle = "Connecting to GitHub...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = { Enabled = false }
})

-- Central loader
local function SafeLoad(url)
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

-- [[ RNG TAB ]]
local RngTab = Window:CreateTab("RNG Events", 4483362458)

-- TELEPORT TO MEGA CHEST (Using SafeLoad now!)
RngTab:CreateButton({
   Name = "Teleport to Mega Chest",
   Callback = function()
       SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/chesttp.lua")
       
       Rayfield:Notify({
           Title = "Teleport",
           Content = "Executing chesttp.lua from GitHub...",
           Duration = 3
       })
   end,
})

-- AUTO ROLL
RngTab:CreateToggle({
   Name = "Auto-Roll Dice",
   CurrentValue = false,
   Flag = "AutoRoll",
   Callback = function(Value)
      _G.AutoRollActive = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/autoroll.lua")
      end
   end,
})

-- AUTO CRAFT
RngTab:CreateToggle({
   Name = "Auto-Craft Dice",
   CurrentValue = false,
   Flag = "AutoCraft",
   Callback = function(Value)
      _G.AutoCraftActive = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/autocraft.lua")
      end
   end,
})

-- WEATHER STRIKER
RngTab:CreateToggle({
   Name = "Universal Weather Striker (Mega II)",
   CurrentValue = false,
   Flag = "StormStriker",
   Callback = function(Value)
      _G.StormStrikerActive = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/stormstriker.lua")
      end
   end,
})

-- [[ UTILITY TAB ]]
local UtilTab = Window:CreateTab("Utility", 4483362458)

UtilTab:CreateToggle({
   Name = "Anti-Disconnect (Auto Click)",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
      _G.autoJumping = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/antidirect.lua")
      end
   end,
})

-- [[ ADMIN TAB ]]
local AdminTab = Window:CreateTab("Admin", 4483362458)

AdminTab:CreateToggle({
   Name = "Auto-Claim Admin",
   CurrentValue = false,
   Flag = "AdminToggle",
   Callback = function(Value)
      getgenv().AdminEnabled = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/adminabuse.lua")
      end
   end,
})
