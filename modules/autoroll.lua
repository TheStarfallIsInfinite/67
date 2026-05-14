-- MODULE: autoroll.lua (Bypass Edition)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local network = ReplicatedStorage:WaitForChild("Network")
local rollRemote = network:WaitForChild("Rng_Roll")
local hiddenRemote = network:FindFirstChild("Rng_HiddenRoll_Enable")

_G.AutoRollActive = true

-- If the game has a "Hidden Roll" feature, we enable it once
if hiddenRemote then
    pcall(function() hiddenRemote:FireServer(true) end)
end

task.spawn(function()
    while _G.AutoRollActive do
        -- We use task.spawn to fire and IMMEDIATELY move on without waiting for server 'yield'
        task.spawn(function()
            pcall(function()
                -- Trying the "First" argument from image_92a002.png
                rollRemote:InvokeServer("First")
            end)
        end)
        
        -- We reduce the wait to just under the 2s mark. 
        -- If the server is 2s, we try 1.8s to catch the 'window'
        task.wait(0.3) 
    end
end)
