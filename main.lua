-- [[ 67 HUB | THESTARFALLISINFINITE ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Utility",
   LoadingTitle = "Connecting to GitHub...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = { Enabled = false },
   Keybind = "RightShift" 
})

-- Central loader
local function SafeLoad(url)
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

-- [[ RNG TAB ]]
local RngTab = Window:CreateTab("RNG Events", 4483362458)

RngTab:CreateButton({
   Name = "Teleport to Mega Chest",
   Callback = function()
       SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/chesttp.lua")
   end,
})

-- NEW: HUGE NOTIFIER
RngTab:CreateToggle({
   Name = "Huge Pet Notifier",
   CurrentValue = false,
   Flag = "HugeNotif",
   Callback = function(Value)
      _G.HugeNotifActive = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/hugenotifier.lua")
      end
   end,
})

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

RngTab:CreateToggle({
   Name = "Universal Weather Striker",
   CurrentValue = false,
   Flag = "StormStriker",
   Callback = function(Value)
      _G.StormStrikerActive = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/stormstriker.lua")
      end
   end,
})

-- [[ PERFORMANCE TAB ]]
local PerformanceTab = Window:CreateTab("Performance", 4483362458)

PerformanceTab:CreateToggle({
   Name = "Optimized Mode (Boost FPS)",
   CurrentValue = false,
   Flag = "OptiMode",
   Callback = function(Value)
      _G.OptimizedMode = Value
      if Value then
          SafeLoad("https://raw.githubusercontent.com/TheStarfallIsInfinite/67/main/modules/optimizedmode.lua")
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
