local autoJumping = true

task.spawn(function()
    while true do
        if autoJumping then
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").Jump = true
            end
        end
        task.wait(60)
    end
end) 
