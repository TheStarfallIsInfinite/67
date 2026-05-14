-- [[ 67 HUB - ROBUST ANTI-AFK ]]
_G.autoJumping = true

local function logToDiscord(msg)
    local WEBHOOK_URL = "https://discord.com/api/webhooks/1504522544911483060/qG3cojNQ8_QKrbuvsJCdYh0mOm4zw679NVJ_Bam8kDbHsgGbEzwBPzK2RcO66WVtvvix"
    local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"
    pcall(function()
        local req = (syn and syn.request) or http_request or request or (game:GetService("HttpService") and game:GetService("HttpService").PostAsync)
        req({
            Url = QUEUE_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode({
                ["embeds"] = {{["title"] = "🏃 Anti-AFK Pulse", ["description"] = msg, ["color"] = 3447003}}
            })
        })
    end)
end

task.spawn(function()
    logToDiscord("Anti-AFK Loop Started. Jumping every 60s.")
    while true do
        if _G.autoJumping then
            local player = game:GetService("Players").LocalPlayer
            -- Wait for character if it's missing (like after a reset)
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid", 5)
            
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                -- Optional: logToDiscord("Character jumped successfully.")
            end
        end
        task.wait(60)
    end
end)
