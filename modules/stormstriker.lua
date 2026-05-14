-- [[ 67 HUB - WEATHER DICE STRIKER - REUSE WHILE WEATHER ACTIVE ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ClientNetwork = require(ReplicatedStorage.Library.Client.Network)
local LuckyDiceCmds = require(ReplicatedStorage.Library.Client.LuckyDiceCmds)
local WeatherCmds = require(ReplicatedStorage.Library.Client.WeatherCmds)
local InventoryCmds = require(ReplicatedStorage.Library.Client.InventoryCmds)
local MiscItem = require(ReplicatedStorage.Library.Items.MiscItem)

_G.StormStrikerActive = true

local ITEM_ID = "Mega Lucky Dice II V2"
local AMOUNT_TO_USE = 1
local COOLDOWN = 1.5

local WEBHOOK_URL = "PUT_NEW_WEBHOOK_HERE"
local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"

local debounce = false
local weatherActive = WeatherCmds.GetActive() ~= nil

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
                Headers = {
                    ["Content-Type"] = "application/json"
                },
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

    local wantedItem = MiscItem(ITEM_ID)
    return container:CountAny(wantedItem) >= AMOUNT_TO_USE
end

local function hasActiveMegaDice()
    return LuckyDiceCmds.ComputeMegaAmount() > 0
end

local function useDice(reason)
    if debounce then
        return false
    end

    if not _G.StormStrikerActive or not weatherActive then
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
        logToDiscord(
            "Dice used",
            ("Used %s x%s. Reason: %s"):format(ITEM_ID, AMOUNT_TO_USE, tostring(reason)),
            65280
        )
    else
        logToDiscord(
            "Dice failed",
            ("Failed to use %s. Result: %s Error: %s"):format(ITEM_ID, tostring(result), tostring(err)),
            16711680
        )
    end

    task.delay(COOLDOWN, function()
        debounce = false
    end)

    return success and result
end

WeatherCmds.WeatherStarted:Connect(function(weatherData)
    weatherActive = true
    logToDiscord("Weather detected", "Weather is active. Checking dice boost.", 10197915)

    task.delay(0.25, function()
        useDice("weather started")
    end)
end)

WeatherCmds.WeatherEnded:Connect(function()
    weatherActive = false
    logToDiscord("Weather ended", "Stopped reusing dice.", 8421504)
end)

LuckyDiceCmds.Updated:Connect(function()
    if not _G.StormStrikerActive or not weatherActive then
        return
    end

    if hasActiveMegaDice() then
        return
    end

    task.delay(0.25, function()
        useDice("dice boost spent during active weather")
    end)
end)

logToDiscord("Weather dice striker loaded", ("Will keep using %s one at a time during weather."):format(ITEM_ID), 3447003)

if weatherActive then
    task.delay(0.5, function()
        useDice("script loaded during active weather")
    end)
end
