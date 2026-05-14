-- DELTA MAIN SCRIPT (PROXIMITY FIX + 1s COOLDOWN)
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- CONFIRMED WEBHOOK SETUP
local WEBHOOK_URL = "https://discord.com/api/webhooks/1504459060165218334/O0HBmsSOB_SO3aBRQ_nV_Z0S12WgO5K-xBOlHOqFkvxc2NcTHUNtR3r2jQw_GAh9Q7fC"
local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"

local function logToWebhook(title, description, color)
    local request = request or http_request or (http and http.request)
    if request then
        task.spawn(function()
            pcall(function()
                request({
                    Url = QUEUE_URL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode({
                        ["embeds"] = {{
                            ["title"] = title,
                            ["description"] = description,
                            ["color"] = color or 16711680,
                            ["footer"] = {["text"] = "Delta Mobile • " .. os.date("%X")}
                        }}
                    })
                })
            end)
        end)
    end
end

local function claimCharacter(model)
    logToWebhook("⚠️ TARGET DETECTED", "Spawning on: " .. model.Name, 16776960)
    
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    while model.Parent and not model:GetAttribute("Claimed") do
        local targetPart = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
        if targetPart then
            -- 1. Teleport to target
            hrp.CFrame = targetPart.CFrame * CFrame.new(2, 0, 0)
            
            -- 2. NEW: 1 second cooldown to let the character settle
            task.wait(1)
            
            -- 3. Check again if it's still there/unclaimed before pressing E
            if model.Parent and not model:GetAttribute("Claimed") then
                -- Method 1: Direct ProximityPrompt firing
                local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    fireproximityprompt(prompt)
                end
                
                -- Method 2: Keypress Fallback
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(0.05)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end
        end
        task.wait(0.2)
    end
    
    logToWebhook("✅ CLAIM SUCCESSFUL", "Target claimed: " .. model.Name, 65280)
end

-- Scanner Logic
local function startWatching(folder)
    logToWebhook("📡 MONITORING ACTIVE", "Watching for Admin Abuse...", 255)
    folder.ChildAdded:Connect(function(child)
        if child:IsA("Model") then task.spawn(claimCharacter, child) end
    end)
    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") and not v:GetAttribute("Claimed") then task.spawn(claimCharacter, v) end
    end
end

task.spawn(function()
    while true do
        local things = Workspace:FindFirstChild("__THINGS")
        if things then
            local adminFolder = things:FindFirstChild("AdminAbuseCharacters")
            if adminFolder then
                startWatching(adminFolder)
                break
            end
        end
        task.wait(2)
    end
end)