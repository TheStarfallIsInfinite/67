-- MAIN SCRIPT
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "67 Hub"})

local Tab = Window:CreateTab("Admin Events")

Tab:CreateToggle({
   Name = "Auto-Claim Admin",
   Callback = function(Value)
      getgenv().AdminEnabled = Value
      if Value then
          -- Load the specific module from your repo
          loadstring(game:HttpGet("https://raw.githubusercontent.com/TheStarfalllsInfinite/67/main/modules/adminabuse.lua"))()
      end
   end,
})
