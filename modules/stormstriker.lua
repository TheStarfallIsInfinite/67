-- [[ 67 HUB - LIGHTNING ONLY DICE STRIKER ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local NetworkFolder = ReplicatedStorage:WaitForChild("Network")
local ClientNetwork = require(ReplicatedStorage.Library.Client.Network)
local LuckyDiceCmds = require(ReplicatedStorage.Library.Client.LuckyDiceCmds)
local InventoryCmds = require(ReplicatedStorage.Library.Client.InventoryCmds)
local MiscItem = require(ReplicatedStorage.Library.Items.MiscItem)

_G.StormStrikerActive = true

local ITEM_ID = "Mega Lucky Dice II V2"
local AMOUNT_TO_USE = 1
local COOLDOWN = 1.5
local LIGHTNING_WEATHER_ID = "Lightning"

local WEBHOOK_URL = "PUT_NEW_WEBHOOK_HERE"
local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"

local debounce = false
local lightningStormActive = false
local weatherToken = 0

local function logToDiscord(title, desc, color)
    if WEBHOOK_URL == "PUT_NEW_WEBHOOK_HERE" then
        print(title, desc)
        return
    end

    local data = {
        embeds = {{
            title = title,
            description = desc,
            color = color or 16777215,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    pcall(function()
        local requestFunc = syn and syn.request or http_request or request
        if requestFunc then
            requestFunc({
                Url = QUEUE_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end
    end)
end

local function hasDiceInInventory()
    local container = InventoryCmds.Container()
    if not container then
        return false
    end

    return container:CountAny(MiscItem(ITEM_ID)) >= AMOUNT_TO_USE
end

local function hasActiveMegaDice()
    return LuckyDiceCmds.ComputeMegaAmount() > 0
end

local function useDice(reason, token)
    if token ~= weatherToken then
        return false
    end

    if debounce then
        return false
    end

    if not _G.StormStrikerActive or not lightningStormActive then
        return false
    end

    if hasActiveMegaDice() then
        return false
    end

    if not hasDiceInInventory() then
        logToDiscord("No dice left", ("No %s left in inventory."):format(ITEM_ID), 16753920)
        return false
    end

    debounce = true

    local success, result, err = pcall(function()
        return ClientNetwork.Invoke("LuckyDice_ConsumeMega", ITEM_ID, AMOUNT_TO_USE)
    end)

    if success and result then
        logToDiscord("Dice used", ("Used %s. Reason: %s"):format(ITEM_ID, tostring(reason)), 65280)
    else
        logToDiscord("Dice failed", ("Result: %s Error: %s"):format(tostring(result), tostring(err)), 16711680)
    end

    task.delay(COOLDOWN, function()
        debounce = false
    end)

    return success and result
end

NetworkFolder:WaitForChild("Weather_Started").OnClientEvent:Connect(function(weatherId)
    weatherToken += 1
    local token = weatherToken

    print("Weather started:", weatherId)

    if weatherId ~= LIGHTNING_WEATHER_ID then
        lightningStormActive = false
        logToDiscord("Ignoring weather", ("Weather was %s, not Lightning."):format(tostring(weatherId)), 8421504)
        return
    end

    lightningStormActive = true
    logToDiscord("Lightning Storm detected", "Using dice only for Lightning Storm.", 10197915)

    task.delay(0.25, function()
        useDice("Lightning Storm started", token)
    end)
end)

NetworkFolder:WaitForChild("Weather_Ended").OnClientEvent:Connect(function()
    weatherToken += 1
    lightningStormActive = false
    logToDiscord("Weather ended", "Stopped reusing dice.", 8421504)
end)

LuckyDiceCmds.Updated:Connect(function()
    if not _G.StormStrikerActive or not lightningStormActive then
        return
    end

    if hasActiveMegaDice() then
        return
    end

    local token = weatherToken
    task.delay(0.25, function()
        useDice("dice boost spent during Lightning Storm", token)
    end)
end)

logToDiscord(
    "Lightning-only dice striker loaded",
    ("Will use %s only when raw weather id is %s."):format(ITEM_ID, LIGHTNING_WEATHER_ID),
    3447003
)
