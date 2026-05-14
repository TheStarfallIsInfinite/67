-- [[ 67 HUB - MAIN EXECUTION ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | Multi-Script",
   LoadingTitle = "Initializing Systems...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "67Hub_Config",
      FileName = "MainSettings"
   }
})

-- [[ RNG EVENT TAB ]]
local RngTab = Window:CreateTab("RNG Event", 4483362458)

RngTab:CreateSection("Auto Features")

RngTab:CreateToggle({
   Name = "Auto-Roll Dice (Fixed)",
   CurrentValue = false,
   Flag = "RngAutoRoll",
   Callback = function(Value)
      _G.AutoRollActive = Value
      if Value then
          -- Loads your working autoroll.lua with the "First" argument
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/autoroll.lua"))()
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
          -- Loads your adminabuse.lua module
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/adminabuse.lua"))()
      end
   end,
})

-- [[ SETTINGS TAB ]]
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
      -- Emergency stop for all loops
      _G.AutoRollActive = false
      getgenv().AdminEnabled = false
      Rayfield:Destroy()
   end,
})

-- Notify successful load
Rayfield:Notify({
   Title = "67 HUB Status",
   Content = "All modules synced and ready.",
   Duration = 5,
   Image = 4483362458,
})
