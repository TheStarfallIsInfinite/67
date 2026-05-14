-- [[ 67 HUB - ANTI-AFK AUTOCLICKER ]]
_G.autoJumping = true

local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

-- Function to send a notification through the UI
local function notifyClick()
    -- We use pcall just in case Rayfield isn't fully initialized when the loop runs
    pcall(function()
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        Rayfield:Notify({
            Title = "Anti-AFK System",
            Content = "Center click executed. Session kept active!",
            Duration = 5,
            Image = 4483362458,
        })
    end)
end

task.spawn(function()
    while true do
        if _G.autoJumping then
            -- Get the center of the screen
            local viewportSize = Workspace.CurrentCamera.ViewportSize
            local centerX = viewportSize.X / 2
            local centerY = viewportSize.Y / 2

            -- Click
            VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
            task.wait(0.1)
            VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
            
            -- Show the notification instead of printing
            notifyClick()
        end
        
        -- Wait 10 minutes (600 seconds)
        task.wait(600)
    end
end)
