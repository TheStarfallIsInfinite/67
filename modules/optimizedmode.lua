-- ==========================================
-- THE ULTIMATE 24/7 PS99 MEGA-OPTIMIZER V4
-- (SILENT VERSION - NO LOGGING)
-- ==========================================

local RENDER_DISTANCE = 20  
local REFRESH_INTERVAL = 60 

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- 1. MATERIAL STRIPPER (Anti-Crash Version)
task.spawn(function()
    local count = 0
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            count = count + 1
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
        if count % 150 == 0 then task.wait() end -- Anti-crash throttling
    end
end)

-- 2. PLAYER AURA & ACCESSORY NUKER (Personal Character)
task.spawn(function()
    local function cleanChar(char)
        if not char then return end
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("ShirtGraphic") or v:IsA("BasicPal") then
                v:Destroy()
            end
        end
    end
    LocalPlayer.CharacterAdded:Connect(cleanChar)
    if LocalPlayer.Character then cleanChar(LocalPlayer.Character) end
end)

-- 3. PET MODEL NUKER
task.spawn(function()
    workspace.DescendantAdded:Connect(function(v)
        if v.Name == "Pets" or v.Parent.Name == "Pets" then
            task.wait(0.1)
            v:Destroy()
        end
    end)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Pets" then v:Destroy() end
    end
end)

-- 4. FIXED AUDIO & LIGHTING PURGE
task.spawn(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = 0 v:Stop() end
    end
    Lighting.GlobalShadows = false
    local effects = {"Bloom","Blur","SunRays","ColorCorrection","Atmosphere"}
    for _, n in pairs(effects) do
        local e = Lighting:FindFirstChildOfClass(n)
        if e then e:Destroy() end
    end
end)

-- 5. GHOST SERVER (Hides other players)
task.spawn(function()
    local function hide(p)
        if p ~= LocalPlayer then
            p.CharacterAdded:Connect(function(c) task.wait(0.1) if c then c:Destroy() end end)
            if p.Character then p.Character:Destroy() end
        end
    end
    Players.PlayerAdded:Connect(hide)
    for _, p in pairs(Players:GetPlayers()) do hide(p) end
end)

-- 6. UI & LEAK CLEANER
task.spawn(function()
    pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) end)
    workspace.DescendantAdded:Connect(function(v)
        if v:IsA("BillboardGui") or v:IsA("ParticleEmitter") then
            task.wait() v:Destroy()
        end
    end)
end)

-- 7. PERFORMANCE LOCK (30 FPS)
task.spawn(function()
    while task.wait(30) do
        gcinfo()
        setfpscap(30)
    end
end)

-- 8. ULTRALIGHT RENDER DISTANCE (20 Studs)
task.spawn(function()
    while true do
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local rootPos = char.HumanoidRootPart.Position
            local descendants = workspace:GetDescendants()
            for i, v in pairs(descendants) do
                if v:IsA("BasePart") and not v:IsDescendantOf(char) then
                    if i % 400 == 0 then task.wait() end -- Throttled
                    v.LocalTransparencyModifier = (v.Position - rootPos).Magnitude > RENDER_DISTANCE and 1 or 0
                end
            end
        end
        task.wait(REFRESH_INTERVAL)
    end
end)
