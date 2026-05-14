-- MODULE: autocraft.lua (Fixed Currency: RngCoins2)
local LuckyDiceCmds = require(game.ReplicatedStorage.Library.Client.LuckyDiceCmds)
local CurrencyCmds = require(game.ReplicatedStorage.Library.Client.CurrencyCmds)
local HttpService = game:GetService("HttpService")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1504459060165218334/O0HBmsSOB_SO3aBRQ_nV_Z0S12WgO5K-xBOlHOqFkvxc2NcTHUNtR3r2jQw_GAh9Q7fC"
local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"

local function logToDiscord(msg)
    pcall(function()
        request({
            Url = QUEUE_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({content = "🛠️ **[CRAFT LOG]**: " .. msg})
        })
    end)
end

_G.AutoCraftActive = true

-- Costs and Priority: Lucky II -> Mega -> Mega II
local PriorityList = {
    "Lucky Dice II V2",
    "Mega Lucky Dice V2",
    "Mega Lucky Dice II V2"
}

local Costs = {
    ["Lucky Dice II V2"] = 100,
    ["Mega Lucky Dice V2"] = 100000,
    ["Mega Lucky Dice II V2"] = 300000
}

task.spawn(function()
    while _G.AutoCraftActive do
        -- Fixed Currency Name from image_91b3a1.png
        local currentCoins = CurrencyCmds.Get("RngCoins2") or 0
        
        local craftAttempted = false
        
        for _, diceName in ipairs(PriorityList) do
            if not _G.AutoCraftActive then break end
            
            local maxPossible = LuckyDiceCmds.ComputeMaxCraftable(diceName)
            local costPer = Costs[diceName] or 0
            
            if maxPossible > 0 then
                if currentCoins >= costPer then
                    local affordable = math.floor(currentCoins / costPer)
                    local toCraft = math.min(maxPossible, affordable)
                    
                    local success, err = pcall(function()
                        return LuckyDiceCmds.Craft(diceName, toCraft)
                    end)
                    
                    if success then
                        logToDiscord("✅ Crafted " .. tostring(toCraft) .. "x " .. diceName .. " (Remaining: " .. tostring(currentCoins - (toCraft * costPer)) .. ")")
                        currentCoins = currentCoins - (toCraft * costPer)
                        craftAttempted = true
                    end
                end
            end
        end
        
        -- If we have enough items but not enough coins, log it once so you know
        if not craftAttempted and currentCoins < 100 then
             -- No need to spam log if you're just waiting for coins
        end

        task.wait(10) 
    end
end)
