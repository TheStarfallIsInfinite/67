-- [[ 67 HUB | THESTARFALLISINFINITE ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "67 HUB | RNG & Admin",
   LoadingTitle = "Fetching from GitHub...",
   LoadingSubtitle = "by Starfall",
   ConfigurationSaving = { Enabled = false }
})

-- SafeLoad function to prevent UI errors if a file is missing
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        Rayfield:Notify({
            Title = "Load Error",
            Content = "Check your GitHub file path!",
            Duration = 5
        })
    end
end

-- [[ RNG TAB ]]
local RngTab = Window:CreateTab("RNG Events", 4483362458)

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

-- THE WORKING CODEX SCRIPT
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
