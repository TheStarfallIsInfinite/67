-- MODULE: autoroll.lua (Final Stable Version)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Rng_Roll")

_G.AutoRollActive = true

task.spawn(function()
    while _G.AutoRollActive do
        local success, result = pcall(function()
            -- Confirmed "First" is the correct argument for the RNG Egg directory
            return remote:InvokeServer("First") 
        end)

        if not success then
            -- Small wait if the server lags to prevent crashing
            task.wait(1)
        end
        
        -- High speed rolling
        task.wait(0.05) 
    end
end)
