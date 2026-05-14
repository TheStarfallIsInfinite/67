-- [[ 67 HUB - MOBILE SAFE ANTI-AFK ]]
_G.autoJumping = true

local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

task.spawn(function()
    -- 1. WAIT 60 SECONDS BEFORE THE VERY FIRST CLICK
    -- This gives you time to close the menu or move around first
    task.wait(60)

    while true do
        if _G.autoJumping then
            local viewportSize = Workspace.CurrentCamera.ViewportSize
            
            -- 2. CLICK BOTTOM RIGHT SAFE ZONE
            -- Avoids center buttons and top-left menu icons seen in your photo
            local clickX = viewportSize.X * 0.9 
            local clickY = viewportSize.Y * 0.9

            -- Simulate Click
            VIM:SendMouseButtonEvent(clickX, clickY, 0, true, game, 1)
            task.wait(0.1)
            VIM:SendMouseButtonEvent(clickX, clickY, 0, false, game, 1)
            
            print("67 HUB: Safe-zone click executed to prevent kick.")
        end
        
        -- 3. WAIT 10 MINUTES UNTIL NEXT CLICK
        task.wait(600)
    end
end)
