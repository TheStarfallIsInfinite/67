-- [[ 67 HUB - MODULE: chesttp.lua ]]
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Using your verified coordinates
local targetLocation = CFrame.new(4290.561, 2566.594 + 3, -5379.607)

-- Teleport execution
if character then
    character:PivotTo(targetLocation)
end
