
pcall(function()
--[[
for _,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
end

for _,v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
    v:Disable()
end
]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()


---------------------------------------------- NAMETAG ESP
function nametag()
local T = Enum.KeyCode.F1
local a = {}
local b = false

local function c(d)
    if not d.Character then return end
    local e = d.Character:FindFirstChildOfClass("Humanoid")
    if not e then return end

    local f = Instance.new("BillboardGui")
    f.Size = UDim2.new(0, 100, 0, 25)
    f.StudsOffset = Vector3.new(0, 3, 0)
    f.Parent = d.Character.Head
    f.AlwaysOnTop = true

    local g = Instance.new("Frame")
    g.Size = UDim2.new(1, 0, 1, 0)
    g.BackgroundTransparency = 1
    g.Parent = f

    local h = Instance.new("TextLabel")
    h.Size = UDim2.new(1, 0, 0.5, 0)
    h.Position = UDim2.new(0, 0, 0, 0)
    h.BackgroundTransparency = 1
    h.TextScaled = true
    h.TextColor3 = Color3.new(1, 1, 0) 
    h.TextStrokeTransparency = 0.75 
    h.TextStrokeColor3 = Color3.new(0, 0, 0) 
    h.Font = Enum.Font.Arcade
    h.Parent = g

    local i = Instance.new("TextLabel")
    i.Size = UDim2.new(1, 0, 0.5, 0)
    i.Position = UDim2.new(0, 0, 0.5, 0)
    i.BackgroundTransparency = 1
    i.TextScaled = true
    i.Font = Enum.Font.Arcade
    i.Text = d.Name
    i.TextColor3 = Color3.new(0, 1, 0) 
    i.TextTransparency = 0.15
    i.TextStrokeTransparency = 0.95
    i.TextStrokeColor3 = Color3.new(0, 0, 0) 
    i.Parent = g

    local j = function()
        h.Text = tostring(math.ceil(e.Health))
    end
    e.HealthChanged:Connect(j)
    j()

    local k = function()
        local l = d.Character:FindFirstChild("ShifterHolder")
        if l then
            shift = l.Value
        if shift == "Attack" or shift == "Jaw" then
        i.TextColor3 = Color3.fromRGB(25, 25, 255)
            elseif d:FindFirstChild("Shifter") then
        i.TextColor3 = Color3.fromRGB(255, 175, 25)
            else
        i.TextColor3 = Color3.fromRGB(255, 25, 25)
            end
        end
    end

    local m = d.Character:FindFirstChild("ShifterHolder")
    if m then
        m.Changed:Connect(k)
        k()
    end

    a[d] = {
        BillboardGui = f,
        UsernameTextLabel = i
    }
end

local n = function(o)
    if a[o] then
        a[o].BillboardGui:Destroy()
        a[o] = nil
    end
end

local p = function()
    b = not b 
    if b then
        for _, q in ipairs(game.Players:GetPlayers()) do
            if q ~= game.Players.LocalPlayer then
                c(q)
            end
        end
    else
        for r, _ in pairs(a) do
            n(r)
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(s)
if s.KeyCode == T then
    p()
end
end)
end


---------------------------------------------- DISTANCE ESP
--[[
function studs()
    local T = Enum.KeyCode.F2
    local a = {}
    local b = false

    local function c(d)
        if not d.Character then return end
        local e = d.Character:FindFirstChildOfClass("Humanoid")
        if not e then return end

        local f = Instance.new("BillboardGui")
        f.Size = UDim2.new(0, 100, 0, 25)
        f.StudsOffset = Vector3.new(0, -10, 0) -- Offset
        f.Parent = d.Character:FindFirstChild("Head") or d.Character:FindFirstChildOfClass("BasePart")
        f.AlwaysOnTop = true

        local g = Instance.new("Frame")
        g.Size = UDim2.new(1, 0, 1, 0)
        g.BackgroundTransparency = 1
        g.Parent = f

        local h = Instance.new("TextLabel")
        h.Size = UDim2.new(1, 0, 0.5, 0)
        h.Position = UDim2.new(0, 0, 0, 0)
        h.BackgroundTransparency = 1
        h.TextScaled = true
        h.TextColor3 = Color3.new(1, 1, 0) -- Yellow
        h.TextStrokeTransparency = 0.75
        h.TextStrokeColor3 = Color3.new(0, 0, 0)
        h.Font = Enum.Font.Arcade
        h.Parent = g

        local player = game.Players.LocalPlayer

        local function update()
            if d.Character and player.Character then
                local primaryPart = d.Character.PrimaryPart
                local pPrimaryPart = player.Character.PrimaryPart
            if primaryPart and pPrimaryPart then
                local distance = (primaryPart.Position - pPrimaryPart.Position).Magnitude
                h.Text = tostring(math.floor(distance))
            end
            end
        end

        game:GetService("RunService").Heartbeat:Connect(update)
        update()

        a[d] = {
            BillboardGui = f,
        }
    end

    local n = function(o)
        if a[o] then
            a[o].BillboardGui:Destroy()
            a[o] = nil
        end
    end

    local p = function()
        b = not b 
        if b then
            for _, q in ipairs(game.Players:GetPlayers()) do
                if q ~= game.Players.LocalPlayer then
                    c(q)
                end
            end
        else
            for r, _ in pairs(a) do
                n(r)
            end
        end
    end

    game:GetService("UserInputService").InputBegan:Connect(function(s)
        if s.KeyCode == T then
            p()
        end
    end)
end
]]

---------------------------------------------- Character Trails
--[[
function trail()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local color = Color3.new(1, 1, 1)
local lifetime = 1
local trailz = false

local function createTrail(part)
    local trail = part:FindFirstChildOfClass("Trail")
    if not trail then
        trail = Instance.new("Trail")
        trail.Color = ColorSequence.new(color)
        trail.Lifetime = lifetime

        local attachment0 = Instance.new("Attachment")
        attachment0.Parent = part
        trail.Attachment0 = attachment0

        local attachment1 = Instance.new("Attachment")
        attachment1.Position = Vector3.new(0, -1, 0)
        attachment1.Parent = part
        trail.Attachment1 = attachment1
        trail.Name = "Portland"

trail.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 1)
})
trail.WidthScale = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 0.5)
})

        trail.Parent = part
    end
    return trail
end

local function setTrailVisibility(character, visible)
    for _, child in ipairs(character:GetDescendants()) do
        if child:IsA("Trail") and child.Name == "Portland" then
            child.Enabled = visible
        end
    end
end

local function manageTrails()
    for _, player in ipairs(Players:GetPlayers()) do
        player.CharacterAdded:Connect(function(character)
            local primaryPart = character:WaitForChild("HumanoidRootPart", 5)
            if primaryPart then
                local trail = createTrail(primaryPart)
                trail.Enabled = trailz
            end
        end)

        local character = player.Character
        if character then
            local primaryPart = character:FindFirstChild("HumanoidRootPart")
            if primaryPart then
                local trail = createTrail(primaryPart)
                trail.Enabled = trailz
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F2 then
        trailz = not trailz
        for _, player in ipairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                setTrailVisibility(character, trailz)
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local primaryPart = character:WaitForChild("HumanoidRootPart", 5)
        if primaryPart then
            local trail = createTrail(primaryPart)
            trail.Enabled = trailz
        end
    end)
end)

manageTrails()
end
]]

---------------------------------------------- PLAYER ESP

function PlayerESP()
    local espObjects = {}
    local enabled = false
    local RunService = game:GetService("RunService")

    local sharingan = Instance.new("Sound")
    sharingan.SoundId = "rbxassetid://405593386"
    sharingan.Volume = 0.25
    sharingan.Parent = game.Workspace

    local deactivate = Instance.new("Sound")
    deactivate.SoundId = "rbxassetid://405596045"
    deactivate.Volume = 0.25
    deactivate.Parent = game.Workspace

    local function updateESP()
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local character = player.Character
                if character then
                    local shifterHolder = character:FindFirstChild("ShifterHolder")
                    local highlight = character:FindFirstChild("Highlight")
                    local shiftColor
                    local fillTransparency = 0.87
                    local outlineTransparency = 0

                    if shifterHolder then
                        local shift = shifterHolder.Value
                        if shift == "Attack" or shift == "Jaw" then
                            shiftColor = Color3.fromRGB(25, 25, 255)
                            fillTransparency = 0.9
                        elseif character:FindFirstChild("Shifter") then
                            shiftColor = Color3.fromRGB(255, 175, 25)
                            fillTransparency = 0.9
                        else
                            shiftColor = Color3.fromRGB(255, 25, 25)
                        end
                    else
                        shiftColor = Color3.fromRGB(0, 255, 0)
                    end

                    if not highlight then
                        highlight = Instance.new("Highlight", character)
                        espObjects[player] = highlight
                    end

                    highlight.FillColor = shiftColor
                    highlight.OutlineColor = shiftColor
                    highlight.FillTransparency = fillTransparency
                    highlight.OutlineTransparency = outlineTransparency
                end
            end
        end
    end

    game.Players.PlayerAdded:Connect(function(player)
        if enabled then
            updateESP()
        end
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Backquote then
            enabled = not enabled
            if enabled then
                updateESP()
                sharingan:Play()
            else
                for _, highlight in pairs(espObjects) do
                    highlight:Destroy()
                end
                espObjects = {}
                deactivate:Play()
            end
        end
    end)

    RunService.Stepped:Connect(function()
        if enabled then
            updateESP()
        end
    end)
end

wait(1)

pcall(function()
for key, value in pairs(getgc(true)) do
    if pcall(function() return rawget(value, "indexInstance") end)
        and type(rawget(value, "indexInstance")) == "table"
        and (rawget(value, "indexInstance"))[1] == "kick" then
        value.xyz = {"kick", function() return game.Workspace:WaitForChild("") end}
    end
end
end)

--[[ SOLARA PLEASE ADD HOOKFUNCTION UNC RAHHHHH
wait(1)

local gp
gp = hookmetamethod(game, "__namecall", function(bw, ...)
    if bw.Name == "HitEvent" and getnamecallmethod() == "FireServer" then
        local ry = {...}
        local di = ry[2]
        if di >= 400 and di <= 600 then
            local random_value = math.random(1, 10)
            if random_value <= 5 then
                ry[2] = 670 -- 50% chance
            elseif random_value <= 7 then
                ry[2] = 690 -- 20% chance
            else
                ry[2] = 680 -- 30% chance
            end
        elseif di > 1280 then
            local random_value = math.random(1, 10)
            if random_value <= 5 then
                ry[2] = 1170 -- 50% chance
            elseif random_value <= 7 then
                ry[2] = 1190 -- 20% chance
            else
                ry[2] = 1180 -- 30% chance
            end
        end
        return gp(bw, unpack(ry))
    end
    return gp(bw, ...)
end) 
--]]

wait(1)

PlayerESP() ---------- RUN ESP
nametag()
--studs()
--trail()

wait(1)

local Window = Fluent:CreateWindow({
    Title = "(╯°□°）╯︵ ┻━┻  " .. "mons",
    SubTitle = "Freedom War",
    TabWidth = 85,
    Size = UDim2.fromOffset(350, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Delete
})
 
-- existing tabs --

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Toggles = Window:AddTab({ Title = "Toggles", Icon = "" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "" }),
    Rage = Window:AddTab({ Title = "Rage", Icon = "" }),
    Cosmetics = Window:AddTab({ Title = "Cosmetics", Icon = "" }),
    Squads = Window:AddTab({ Title = "Squads", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "separator-horizontal" })
}

-- SettingsTab --

Tabs.Settings:AddParagraph({
    Title = "no lifes",
    Content = "jagt#5941\n.automic"
})

Tabs.Settings:AddParagraph({
    Title = "Toggle UI",
    Content = "Delete"
})

Tabs.Settings:AddParagraph({
    Title = "Toggle Soldier/Warrior ESP",
    Content = "` [HIGHLIGHT] - F1 [NAMETAGS]"
})

Tabs.Settings:AddParagraph({
    Title = "    NAPE SIZE",
    Content = "----------------------------------"
})

local xslider = Tabs.Settings:AddSlider("Slider", {
    Title = "X",
    Description = "---",
    Default = 4.5,
    Min = 0,
    Max = 40,
    Rounding = 1,
    Callback = function()
    end
})

local yslider = Tabs.Settings:AddSlider("Slider", {
    Title = "Y",
    Description = "---",
    Default = 3.5,
    Min = 0,
    Max = 40,
    Rounding = 1,
    Callback = function()
    end
})

local zslider = Tabs.Settings:AddSlider("Slider", {
    Title = "Z",
    Description = "---",
    Default = 1.2,
    Min = 0,
    Max = 40,
    Rounding = 1,
    Callback = function()
    end
})

local TraValue = 1

local Tra = Tabs.Settings:AddToggle("Transparent", {Title = "Transparency", Default = true })
Tra:OnChanged(function(Sauce)
    if Sauce then
        TraValue = 1
    else
        TraValue = 0
    end
end)


Tabs.Settings:AddButton({
    Title = "Reset size",
    Description = "(4.5, 3.5, 1.2)",
    Callback = function()
xslider:SetValue(4.5)
yslider:SetValue(3.5)
zslider:SetValue(1.2)
    end
})

Tabs.Settings:AddParagraph({
    Title = "    HOOK ASSIST",
    Content = "----------------------------------"
})

local jetf2 = 1

local jet = Tabs.Settings:AddToggle("Transparent", {Title = "Transparency", Default = true })
jet:OnChanged(function(Sauze)
    if Sauze then
        jetf2 = 1
    else
        jetf2 = 0.5
    end
end)

local circlesize = Tabs.Settings:AddSlider("Slider", {
    Title = "Size",
    Description = "---",
    Default = 17,
    Min = 4,
    Max = 17,
    Rounding = 0,
    Callback = function()
    end
})

local jetf25 = 0.37

local jets = Tabs.Settings:AddSlider("Slider", {
    Title = "Anti-Hook Speed",
    Description = "1=Slow",
    Default = 3,
    Min = 1,
    Max = 4,
    Rounding = 0,
    Callback = function(kream)
        if kream == 1 then
            jetf25 = 0.75
        elseif kream == 2 then
            jetf25 = 0.5
        elseif kream == 3 then
            jetf25 = 0.37
        elseif kream == 4 then
            jetf25 = 0.25
        end
    end
})


-- MainTab --


------- Infinite Yield -------


Tabs.Main:AddButton({
    Title = "Infinite Yield",
    Description = "(•_•)",
    Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})


------- Buy Grenade Keybind -------


local HP = Tabs.Main:AddKeybind("Keybind", {
    Title = "buy grenade",
    Mode = "Toggle",
    Default = "Home", 
    Callback = function() end,
})

HP:OnClick(function()
--[[
    local a = game.Players.LocalPlayer.Character.Humanoid.MaxHealth
    local b = game.Players.LocalPlayer.Character.Humanoid.Health
    local c = 35 -- HEALTH ADDED
    local d = b + c

    if d > a then
        c = a - b
    end

    local e = -c
    local f = {[1] = e}
    workspace:WaitForChild("HumanEvents").DamageEvent:FireServer(unpack(f))
]]
local args = {[1] = "Granada",[2] = 0}
    game:GetService("ReplicatedStorage"):WaitForChild("BuyEvent"):FireServer(unpack(args))
    wait(0.5)
local E = game.Players.LocalPlayer.Character:WaitForChild("Granada"):WaitForChild("Eat")
local N = 3
    for i = 1, N do
E:FireServer()
end
end)


------- Anti Hook -------


local Toggled = false

function AntiHook()
local SB = Tabs.Main:AddKeybind("Keybind", {
    Title = "Anti Hook",
    Mode = "Toggle",
    Default = "End", 
    Callback = function() end,
})

SB:OnClick(function()
    Toggled = SB:GetState()
    local nf = Toggled and "✅ Enabled" or "❌ Disabled"
    local C = game.Players.LocalPlayer.Character
    game.StarterGui:SetCore("SendNotification", 
        {
            Title = "Ackerman Spec",
            Text = nf,
            Icon = "",
            Duration = 0.5,
        })
    while Toggled do
        if C and C:FindFirstChild("Humanoid") and C:FindFirstChild("Gear") then
            local HookL = C.Humanoid.Gear:FindFirstChild("HookTensionL").Value
            local HookR = C.Humanoid.Gear:FindFirstChild("HookTensionR").Value
            local args = {[1] = game.Players.LocalPlayer.Character.HumanoidRootPart}
            local todoai = nil

    if (HookL > 0 and HookR == 0) or (HookL == 0 and HookR > 0) then

            if HookL < HookR then
                todoai = C.Gear.Events.MoreEvents.CastQKey
            elseif HookL > HookR then
                todoai = C.Gear.Events.MoreEvents.CastEKey
            end

    if todoai then
        todoai:FireServer(unpack(args))
    end
end
wait(jetf25)
            else
            Toggled = false
            game.StarterGui:SetCore("SendNotification", 
            {
                Title = "Ackerman Spec",
                Text = "ODM Required",
                Duration = 2,
            })
        end
    end
end)
end
AntiHook()


-- TogglesTab --


------- Unlock Skills -------


local SKG = Tabs.Toggles:AddToggle("SKG", {Title = "Unlock Skills", Default = false })
local RunService = game:GetService("RunService")
local connection

SKG:OnChanged(function()
    local XXX = SKG.Value

    local function changeStats()
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if Humanoid then
            local HumanoidGear = Humanoid:FindFirstChild("Gear")
            if HumanoidGear then
                local Gear = game.Players.LocalPlayer.Character:FindFirstChild("Gear")
                if Gear then
                    if XXX then

                                local mykid = game.Players.LocalPlayer.Character.Humanoid.Gear.Skills:GetChildren()
                                for _, mykid in pairs(mykid) do
                                if mykid:IsA("BoolValue") then
                                mykid.Value = true
                                end
                                end
                                

                    else

                                local mykid = game.Players.LocalPlayer.Character.Humanoid.Gear.Skills:GetChildren()
                                for _, mykid in pairs(mykid) do
                                if mykid:IsA("BoolValue") then
                                mykid.Value = false
                                
                            end
                        end 
                    end
                end
            end
        end
    end

    if XXX then
        connection = RunService.RenderStepped:Connect(changeStats)
    else
        if connection and connection.Connected then
            connection:Disconnect()
            connection = nil
        end

        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if Humanoid then
            local HumanoidGear = Humanoid:FindFirstChild("Gear")
            if HumanoidGear then
                local Gear = game.Players.LocalPlayer.Character:FindFirstChild("Gear")
                if Gear then

                        local mykid = game.Players.LocalPlayer.Character.Humanoid.Gear.Skills:GetChildren()
                        for _, mykid in pairs(mykid) do
                        if mykid:IsA("BoolValue") then
                        mykid.Value = false
                        end
                        end

                end
            end
        end
    end
end)


------- Stats Changer -------


local SC = Tabs.Toggles:AddToggle("SC", {Title = "Stats Changer", Default = false })
local RunService = game:GetService("RunService")
local connection

SC:OnChanged(function()
    local SSS = SC.Value

    local function changeStats()
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if Humanoid then
            local HumanoidGear = Humanoid:FindFirstChild("Gear")
            if HumanoidGear then
                local Gear = game.Players.LocalPlayer.Character:FindFirstChild("Gear")
                if Gear then
                    if SSS then
                        Humanoid.Invinsible.Value = true
                        Humanoid.Sanity.Value = 100
                        HumanoidGear.Upgrades.GasEfficiency.Value = 0.125
                        HumanoidGear.Blades.Value = 8
                        HumanoidGear.Upgrades.AttackSpeed.Value = 0.3
                        HumanoidGear.Upgrades.RunningSpeed.Value = 19
                        HumanoidGear.Upgrades.MentalStrength.Value = 0.3
                        HumanoidGear.Upgrades.HooksRange.Value = 160
                    else
                        Humanoid.Invinsible.Value = false
                        HumanoidGear.Upgrades.GasEfficiency.Value = 0.5
                    end
                end
            end
        end
    end

    if SSS then
        connection = RunService.RenderStepped:Connect(changeStats)
    else
        if connection and connection.Connected then
            connection:Disconnect()
            connection = nil
        end
        
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if Humanoid then
            local HumanoidGear = Humanoid:FindFirstChild("Gear")
            if HumanoidGear then
                local Gear = game.Players.LocalPlayer.Character:FindFirstChild("Gear")
                if Gear then
                    Humanoid.Invinsible.Value = false
                    HumanoidGear.Upgrades.GasEfficiency.Value = 0.5
                end
            end
        end
    end
end)


------- No Cooldown -------


local NC = Tabs.Toggles:AddToggle("NC", { Title = "No Cooldown", Default = false })
local RunService = game:GetService("RunService")
local connection
local old = 0
local cooldown = 1

NC:OnChanged(function()
    local NNN = NC.Value

    local function noCooldown()
        local currentTime = tick()
        if currentTime - old >= cooldown then
            local SkillsGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SkillsGui")
            if SkillsGui then
                local Character = game.Players.LocalPlayer.Character
                if Character then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        local Gear = Character:FindFirstChild("Gear")
                        if Gear then
                            local SkillsSpamLimit = Gear:FindFirstChild("SkillsSpamLimit")
                            if SkillsSpamLimit then
                                for _, b in pairs(SkillsSpamLimit:GetChildren()) do
                                    if b:IsA("IntValue") then
                                    b.Value = 0
                                    end
                                end
                            end
                        end
                    end
                end

                for _, d in pairs(SkillsGui:GetChildren()) do
                    if d:FindFirstChild("Cooldown") then
                    d.Cooldown.Value = 10000
                    end
                end
                old = currentTime
            end
        end
    end

    if NNN then
        connection = RunService.RenderStepped:Connect(noCooldown)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)


------- Nape Resize -------


local NV = Tabs.Toggles:AddToggle("NV", {Title = "Pure Titan Napes", Default = false })
local RunService = game:GetService("RunService")
local connection

NV:OnChanged(function()
    local VVV = NV.Value
    if VVV then
        connection = RunService.RenderStepped:Connect(function()
            local OGT = game.Workspace:FindFirstChild("OnGameTitans")
            if OGT then
                for _, X in ipairs(OGT:GetChildren()) do
                    local N = X:FindFirstChild("Nape")
                    if N then
                        N.Transparency = TraValue
                        N.BrickColor = BrickColor.new("Bright red")
                        N.Size = Vector3.new(xslider.Value, yslider.Value, zslider.Value) -- (4.5, 3.5, 1.2)
                    end
                end
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)


------- Shifter Napes ------- Excluding Armored and Colossal


local SVV = Tabs.Toggles:AddToggle("SVV", {Title = "Shifter Napes", Default = false })
local RunService = game:GetService("RunService")
local connection

SVV:OnChanged(function()
    local eggnog = SVV.Value

    local function updateShifterNapes()
        local objectNames = {"FemaleTitan", "BeastTitan", "CartTitan", "AttackTitan", "JawTitan"}

        local function fetuskun(model)
            local Eyes = model:FindFirstChild("SEyes")
            local b = model:FindFirstChild("SNape")
            local RLeg = model:FindFirstChild("RLegTendons")
            local LLeg = model:FindFirstChild("LLegTendons")
            local RArm = model:FindFirstChild("RArmTendons")
            local LArm = model:FindFirstChild("LArmTendons")

            if b and RLeg and LLeg and RArm and LArm and Eyes then
                local sO = 0
                if model.Name == "CartTitan" or model.Name == "JawTitan" then
                    sO = -2
                elseif model.Name == "BeastTitan" then
                    sO = 1
                end

                RLeg.Size = Vector3.new(5 + sO, 6 + sO, 5 + sO)
                LLeg.Size = Vector3.new(5 + sO, 6 + sO, 5 + sO)
                RArm.Size = Vector3.new(4 + sO, 5 + sO, 4 + sO)
                LArm.Size = Vector3.new(4 + sO, 5 + sO, 4 + sO)
                b.Size = Vector3.new(7 + sO, 2.75 + sO, 6 + sO)
                Eyes.Size = Vector3.new(3.5, 2.4, 1.25)

                RLeg.Transparency = TraValue
                LLeg.Transparency = TraValue
                RArm.Transparency = TraValue
                LArm.Transparency = TraValue
                b.Transparency = TraValue
                Eyes.Transparency = TraValue

                RLeg.BrickColor = BrickColor.new("Bright red")
                LLeg.BrickColor = BrickColor.new("Bright red")
                RArm.BrickColor = BrickColor.new("Bright red")
                LArm.BrickColor = BrickColor.new("Bright red")
                b.BrickColor = BrickColor.new("Bright red")
                Eyes.BrickColor = BrickColor.new("Bright red")
            end
        end

        for _, model in ipairs(workspace:GetChildren()) do
            if model:IsA("Model") then
                for _, objectName in ipairs(objectNames) do
                    if model.Name == objectName then
                        fetuskun(model)
                        break
                    end
                end
            end
        end
    end

    if eggnog then
        connection = RunService.RenderStepped:Connect(updateShifterNapes)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)


------- Auto HandCut -------


local AH = Tabs.Toggles:AddToggle("AH", {Title = "Auto HandCut (20s CD)", Default = false })
local RunService = game:GetService("RunService")
local connection
local old = 0
local cooldown = 20

AH:OnChanged(function()
    local HHH = AH.Value

    local function autoHandCut()
        local currentTime = tick()
        if currentTime - old >= cooldown then
            local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if Humanoid then
                local Gear = game.Players.LocalPlayer.Character:FindFirstChild("Gear")
                if Gear then
                    if Humanoid:FindFirstChild("Grabbed") and Humanoid.Grabbed.Value == true then
                        wait(0.37)
                        Gear.Events.MoreEvents.HandCut:FireServer()
                        old = currentTime
                    end
                end
            end
        end
    end

    if HHH then
        connection = RunService.RenderStepped:Connect(autoHandCut)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)


------- tobirama -------
--[[

local TS = Tabs.Toggles:AddToggle("TS", {Title = "Inf TS", Default = false })
local RunService = game:GetService("RunService")
local connection

TS:OnChanged(function()
    local TSS = TS.Value

    local function refillTS()
        local Character = game.Players.LocalPlayer.Character
        if Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("Gear") then
            local args = {
                [1] = "TS",
                [2] = workspace:WaitForChild("OnGameHorses"):WaitForChild("HorseCarriage"):WaitForChild("Carriage"):WaitForChild("CarriageRefill"):WaitForChild("PromptPart")
            }
            game:GetService("Players").LocalPlayer.Character.Gear.Events.RefillEventServer:FireServer(unpack(args))
        end
    end

    if TSS then
        connection = RunService.RenderStepped:Connect(refillTS)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)
--]]

-- MiscTab --


------- Unlock Skills -------


Tabs.Misc:AddButton({
Title = "Unlock Skills",
Description = "Teehee",
Callback = function()
local mykid = game.Players.LocalPlayer.Character.Humanoid.Gear.Skills:GetChildren()
    for _, mykid in pairs(mykid) do
    if mykid:IsA("BoolValue") then
mykid.Value = true
end
end 
end
})


------- Levi -------


Tabs.Misc:AddButton({
Title = "Rotate Left Hand",
Description = "LEFT HAND 180",
Callback = function()
rotations = 180
game.Players.LocalPlayer.Character.LeftHand.LeftWrist.C1 = game.Players.LocalPlayer.Character.LeftHand.LeftWrist.C1 * CFrame.Angles(0, math.rad(rotations), 0)
end
})

Tabs.Misc:AddButton({
Title = "Rotate Right Hand",
Description = "RIGHT HAND 180",
Callback = function()
rotations = 180
game.Players.LocalPlayer.Character.RightHand.RightWrist.C1 = game.Players.LocalPlayer.Character.RightHand.RightWrist.C1 * CFrame.Angles(0, math.rad(rotations), 0)
end
})


------- Notify Warriors -------


Tabs.Misc:AddButton({
    Title = "Reveal Warriors",
    Description = "(•_•)",
    Callback = function()
local n=""
local v={"Armored","Female","Colossal"}

for _,s in pairs(workspace.WarriorsCandidatesFolder.ShifterHolders:GetChildren())do
    local m=s.Name
    local x=s.Value

    if table.find(v,m)then
        local ch=game.Players:FindFirstChild(x)
        if ch then
            local tl
            if m=="Armored"then
                tl=ch.Character:FindFirstChild("ARLocal")
            elseif m=="Female"then
                tl=ch.Character:FindFirstChild("FELocal")
            elseif m=="Colossal"then
                tl=ch.Character:FindFirstChild("COLocal")
            end

            if tl then
                local st=tl:FindFirstChild("Stats")
                if st then
                    local tm=st:FindFirstChild("Time")
                    if tm then
                        n=n..tm.Value.." : "..m.." : "..x.."\n"
                    end
                end
            end
        end
    end
end

game.StarterGui:SetCore("SendNotification",{
    Title="Warriors",
    Text=n,
    Duration=17
})
    end
})


------- eat this and ur full hp lol -------


Tabs.Misc:AddButton({
Title = "Buffed Granada",
Description = "(•_•)",
Callback = function()
local args = {[1] = "Granada",[2] = 100}
    game:GetService("ReplicatedStorage"):WaitForChild("BuyEvent"):FireServer(unpack(args))
    wait(1)
local E = game.Players.LocalPlayer.Character:WaitForChild("Granada"):WaitForChild("Eat")
local N = 65
    for i = 1, N do
E:FireServer()
end
end
})

-- ClothesTab --

------- Clothes -------

Tabs.Cosmetics:AddButton({
Title = "BDSM Strap on",
Description = "AP Gear",
Callback = function()
local args = {
    [1] = "Rogue",
    [2] = "Guns"
}
game:GetService("ReplicatedStorage"):WaitForChild("Wear3DClothesEvent"):FireServer(unpack(args))
end
})

Tabs.Cosmetics:AddButton({
Title = "Edgy +100 Aura cloak",
Description = "Gray Cloak",
Callback = function()
local args = {
    [1] = "Rogue",
    [2] = "Blades"
}
game:GetService("ReplicatedStorage"):WaitForChild("Wear3DClothesEvent"):FireServer(unpack(args))
end
})

Tabs.Cosmetics:AddButton({
Title = "Jacker",
Description = "Jacket",
Callback = function()
local args = {
    [1] = "Training Corps",
    [2] = "Blades"
}
game:GetService("ReplicatedStorage"):WaitForChild("Wear3DClothesEvent"):FireServer(unpack(args))
end
})

Tabs.Cosmetics:AddButton({
Title = "TATAKAEEEEEE",
Description = "Scout Cloak",
Callback = function()
local args = {
    [1] = "Soldiers",
    [2] = "Blades"
}
game:GetService("ReplicatedStorage"):WaitForChild("Wear3DClothesEvent"):FireServer(unpack(args))
end
})

Tabs.Cosmetics:AddButton({
Title = "nigga what",
Description = "None",
Callback = function()
local args = {
    [1] = "",
    [2] = ""
}
game:GetService("ReplicatedStorage"):WaitForChild("Wear3DClothesEvent"):FireServer(unpack(args))
end
})


-- Squads Tab --


------- Select Player -------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local function names()
local jjs = {} -- player table
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(jjs, player.Name)
        end
    end
    return jjs
end


local Dropdown = Tabs.Squads:AddDropdown("Dropdown", {
Title = "Players",
Values = names(),
Multi = false,
Default = nil,
})
Players.PlayerAdded:Connect(function()
    Dropdown:SetValues(names())
end)
Players.PlayerRemoving:Connect(function()
    Dropdown:SetValues(names())
end)
------i hate this retarded shit

------- Squad Color -------


local squadcolor = Tabs.Squads:AddColorpicker("Colorpicker", {
Title = "Squad Color",
Default = Color3.fromRGB(200, 200, 200)
})


------- Create Squad -------


Tabs.Squads:AddButton({
Title = "Create Squad",
Description = "Custom Squad Color",
Callback = function()

    local args = {
        [1] = squadcolor.Value
    }
    game:GetService("ReplicatedStorage"):WaitForChild("SquadSystem"):WaitForChild("Remotes"):WaitForChild("CreateSquad"):InvokeServer(unpack(args))

end
})


------- Join Squad -------


Tabs.Squads:AddButton({
Title = "Join",
Description = "Join a squad",
Callback = function()

    local args = {
        [1] = Dropdown.Value
    }
    game:GetService("ReplicatedStorage"):WaitForChild("SquadSystem"):WaitForChild("Remotes"):WaitForChild("AcceptInvite"):FireServer(unpack(args))

end
})


------- Invite to Squad -------


Tabs.Squads:AddButton({
Title = "Invite",
Description = "Invite selected",
Callback = function()

    local args = {
        [1] = game.Players:FindFirstChild(Dropdown.Value)
    }
    game:GetService("ReplicatedStorage"):WaitForChild("SquadSystem"):WaitForChild("Remotes"):WaitForChild("SendRequest"):InvokeServer(unpack(args))
    
end
})


------- Kick from Squad -------


Tabs.Squads:AddButton({
Title = "Kick",
Description = "Kick selected",
Callback = function()

    local args = {
        [1] = game.Players:FindFirstChild(Dropdown.Value)
    }
    game:GetService("ReplicatedStorage"):WaitForChild("SquadSystem"):WaitForChild("Remotes"):WaitForChild("KickRequest"):InvokeServer(unpack(args))
            
end
})


------- Leave Squad -------


Tabs.Squads:AddButton({
Title = "Leave",
Description = "Leave current squad",
Callback = function()

    game:GetService("ReplicatedStorage"):WaitForChild("SquadSystem"):WaitForChild("Remotes"):WaitForChild("LeaveSquad"):InvokeServer()

end
})


-- RageTab --


------- Permanent Hood -------


Tabs.Rage:AddButton({
Title = "Permanent Hood",
Description = "Don't lose hood when damage taken",
Callback = function()

    if game.Players.LocalPlayer.PlayerGui.LowHealthGui:FindFirstChild("LoseHoodEvent") then
        game.Players.LocalPlayer.PlayerGui.LowHealthGui.LoseHoodEvent:Destroy()
    end

end
})


------- Infinite Health -------

--[[

Tabs.Rage:AddButton({
Title = "Inf Health",
Description = "God mode",
Callback = function()

        local args = {
            [1] = -100000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        
        workspace:WaitForChild("HumanEvents"):WaitForChild("DamageEvent"):FireServer(unpack(args))

end
})

]]

------- +100 HP -------

--[[

Tabs.Rage:AddButton({
Title = "HP Regen",
Description = "+100 Healh (J)",
Callback = function()


                game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
            if key == "j" then
                local args = {[1] = -100}
            workspace:WaitForChild("HumanEvents"):WaitForChild("DamageEvent"):FireServer(unpack(args))
        end
    end)

end
})

]]


------------------------------------------------------------------------ EXTRA

function hookassist()
    local pl = game:GetService("Players")
    local rs = game:GetService("RunService")
    
    local function ac(pn)
        local ch = pn.Character
        if ch then
            local hr = ch:FindFirstChild("HumanoidRootPart")
            if hr then
                local bh = hr:FindFirstChild("BulletsHitbox")
                if bh then
                    local lc = pl.LocalPlayer.Character
                    local hu = lc:FindFirstChild("Humanoid")
                    if hu then
                        local ge = lc:FindFirstChild("Gear")
                        if ge then
                            if hu:FindFirstChild("Grabbed") and hu.Grabbed.Value == false then
                                if not hr:FindFirstChild("WB") then
                                    if Toggled then
                                    if pn.Team ~= pl.LocalPlayer.Team or pn.Team.Name == "Rogue" then

                                            bh.Reflectance = 0.25
                                            bh.Transparency = jetf2
                                            bh.BrickColor = BrickColor.new("Bright yellow")
                                            bh.Material = Enum.Material.ForceField
                                            bh.Size = Vector3.new(circlesize.Value, circlesize.Value, circlesize.Value)
                                            bh.Shape = Enum.PartType.Ball

                                    end
                                    else

                                            bh.Transparency = 1
                                            bh.Size = Vector3.new(1, 1, 1)

                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

local function cp()
local lp = pl.LocalPlayer
    for _, pn in ipairs(pl:GetPlayers()) do
        if pn ~= lp then
            ac(pn)
        end
    end
end

rs.RenderStepped:Connect(cp)
end

hookassist()

----------------- durr

function sharingan()
    while wait(60) do
        local C = game.Players.LocalPlayer.Character
        if C and C:FindFirstChild("HumanoidRootPart") then
            local HRP = C.HumanoidRootPart
            for _, rizz in pairs(HRP:GetChildren()) do
                if rizz:IsA("Attachment") and (rizz.Name == "QAttachment" or rizz.Name == "EAttachment") then
                    rizz:Destroy() -- fuck you nigga
                end
            end
        end
    end
end

spawn(sharingan) -- background process

end)
