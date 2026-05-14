-- [[ 67 HUB - FINAL STABLE VERSION ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Admin",
   LoadingTitle = "Syncing with GitHub...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "67Hub_Config",
      FileName = "MainSettings"
   }
})

-- [[ RNG & CRAFTING TAB ]]
local RngTab = Window:CreateTab("RNG Event", 4483362458)

RngTab:CreateSection("Auto Rolling")

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

RngTab:CreateSection("Auto Crafting")

RngTab:CreateToggle({
   Name = "Auto-Craft (Priority: II -> Mega -> Mega II)",
   CurrentValue = false,
   Flag = "AutoCraftToggle",
   Callback = function(Value)
      _G.AutoCraftActive = Value
      if Value then
          -- Loads the script using the correct RngCoins2 ID
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/autocraft.lua"))()
      end
   end,
})

-- [[ ADMIN EVENTS TAB ]]
local AdminTab = Window:CreateTab("Admin Events", 4483362458)

AdminTab:CreateSection("Abuse Features")

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

-- [[ SETTINGS TAB ]]
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
      _G.AutoRollActive = false
      _G.AutoCraftActive = false
      getgenv().AdminEnabled = false
      Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "67 HUB Loaded",
   Content = "Auto-Roll and Auto-Craft (RngCoins2) active.",
   Duration = 5,
   Image = 4483362458,
})
