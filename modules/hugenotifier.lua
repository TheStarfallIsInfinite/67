-- [[ 67 HUB - HUGE / TITANIC / GARGANTUAN HATCH WEBHOOK ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Items = require(ReplicatedStorage.Library.Items)

local WEBHOOK_URL = "https://discord.com/api/webhooks/1504609124292231168/GJi7kXZaK-2H_D_pWTXRbhXEOz630B1KFEoL192L5R2nw1q1FVmLiJdrNTU17XBlA4u8"
local QUEUE_URL = WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") .. "/queue"

local STARTUP_IGNORE_SECONDS = 8
local loadedAt = os.clock()
local sent = {}

local function requestWebhook(payload)
    local requestFunc = syn and syn.request or http_request or request

    if requestFunc then
        return requestFunc({
            Url = QUEUE_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end

    return HttpService:PostAsync(QUEUE_URL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
end

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
        requestWebhook(data)
    end)
end

local function getPetName(petItem)
    local okDir, dir = pcall(function()
        return petItem:Directory()
    end)

    if okDir and dir then
        return dir.name or dir.Name or dir.DisplayName or dir._id
    end

    local okId, id = pcall(function()
        return petItem:GetId()
    end)

    if okId then
        return tostring(id)
    end

    return "Unknown Pet"
end

local function getPetUid(petItem)
    local ok, uid = pcall(function()
        return petItem:GetUID()
    end)

    if ok and uid then
        return tostring(uid)
    end

    return getPetName(petItem) .. ":" .. tostring(os.clock())
end

local function getHugeType(petName)
    local lower = string.lower(petName)

    if lower:find("^gargantuan") then
        return "gargantuan"
    end

    if lower:find("^titanic") then
        return "titanic"
    end

    if lower:find("^huge") then
        return "huge"
    end

    return nil
end

local function handlePetAdded(petItem)
    if os.clock() - loadedAt < STARTUP_IGNORE_SECONDS then
        return
    end

    local uid = getPetUid(petItem)
    if sent[uid] then
        return
    end

    local petName = getPetName(petItem)
    local petType = getHugeType(petName)

    if not petType then
        return
    end

    sent[uid] = true

    logToDiscord(
        "YO BRO",
        ("You hatched a %s: **%s**"):format(petType, petName),
        petType == "gargantuan" and 16711680 or petType == "titanic" and 16753920 or 65280
    )
end

logToDiscord(
    "Huge hatch detector loaded",
    "Watching inventory for new Huge, Titanic, or Gargantuan pets.",
    3447003
)

if Items.Pet and Items.Pet.Added then
    Items.Pet.Added:Connect(handlePetAdded)
else
    warn("Items.Pet.Added was not found. Pet hatch detector cannot attach.")
end
