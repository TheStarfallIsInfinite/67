-- [[ 67 HUB - MODULE: antidirect.lua ]]
_G.autoJumping = true

local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

task.spawn(function()
    while true do
        if _G.autoJumping then
            local viewportSize = Workspace.CurrentCamera.ViewportSize
            -- Offset from center to avoid game buttons in image_75e978.png
            local clickX = (viewportSize.X / 2) + 100 
            local clickY = (viewportSize.Y / 2) + 100

            VIM:SendMouseButtonEvent(clickX, clickY, 0, true, game, 1)
            task.wait(0.1)
            VIM:SendMouseButtonEvent(clickX, clickY, 0, false, game, 1)
        end
        task.wait(600)
    end
end)
