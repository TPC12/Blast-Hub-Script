-- Blast Hub v1.0
-- Powered by TPC
-- All Rights Reserved by TPC©

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

--==================================================
-- CENTRAL SCRIPT DATA
--==================================================

local ScriptsData = {
    Categories = {
        {
            Id = "simple",
            Name = "Scripts",
            Icon = "file-code",
        },
        {
            Id = "bloxfruits",
            Name = "Blox Fruits",
            Icon = "gamepad-2",
        },
        {
            Id = "mm2",
            Name = "Murder Mystery 2",
            Icon = "swords",
        },
        {
            Id = "keyboard",
            Name = "Keyboard Map",
            Icon = "keyboard",
        },
        {
            Id = "stealegg",
            Name = "Steal a Egg",
            Icon = "egg",
        },
    },

    Scripts = {
        {
            Category = "simple",
            Name = "Fly Script",
            Description = "Fly anywhere",
            Icon = "plane",
            URL = "https://pastebin.com/raw/a0A1HQDE",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "simple",
            Name = "RTX Script",
            Description = "Makes the game more realistic",
            Icon = "sun",
            URL = "https://pastebin.com/raw/BdWMGnpU",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "simple",
            Name = "Animation Script",
            Description = "Animation script",
            Icon = "person-standing",
            URL = "https://pastebin.com/raw/Uq8vajaM",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "simple",
            Name = "NoClip Script",
            Description = "Walk through walls",
            Icon = "ghost",
            URL = "https://pastebin.com/raw/eHirsG1T",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "simple",
            Name = "Admin Script",
            Description = "Infinite Yield admin commands",
            Icon = "shield",
            URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
            Type = "remote",
            Enabled = true,
        },

        {
            Category = "bloxfruits",
            Name = "REDz Hub",
            Description = "Blox Fruits script",
            Icon = "flame",
            URL = "https://raw.githubusercontent.com/UCT-hub/main/refs/heads/main/redz-v2",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "bloxfruits",
            Name = "Fish Hub",
            Description = "Blox Fruits script",
            Icon = "fish",
            URL = "https://gitlab.com/lotongroup/script/-/raw/main/FishHub.lua",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "bloxfruits",
            Name = "Cokka Hub",
            Description = "Blox Fruits script",
            Icon = "gamepad-2",
            URL = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "bloxfruits",
            Name = "HoHo Hub",
            Description = "Blox Fruits script",
            Icon = "gamepad-2",
            URL = "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI",
            Type = "remote",
            Enabled = true,
        },

        {
            Category = "mm2",
            Name = "Onyx",
            Description = "Murder Mystery 2 script",
            Icon = "diamond",
            URL = "https://raw.githubusercontent.com/OnyxHub-New/OnyxHub/refs/heads/main/mm2",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "mm2",
            Name = "Vynixu",
            Description = "Murder Mystery 2 script",
            Icon = "gem",
            URL = "4001118261",
            Type = "asset",
            Enabled = true,
        },
        {
            Category = "mm2",
            Name = "Magixx",
            Description = "Murder Mystery 2 script",
            Icon = "wand-2",
            URL = "https://pastebin.com/raw/1shHyM48",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "mm2",
            Name = "Waguri",
            Description = "Murder Mystery 2 script",
            Icon = "heart",
            URL = "https://raw.githubusercontent.com/Waguriiiii/Murder-mystery-2/refs/heads/main/Waguri.lua",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "mm2",
            Name = "Vertex",
            Description = "Murder Mystery 2 script",
            Icon = "triangle",
            URL = "https://raw.githubusercontent.com/vertex-peak/vertex/refs/heads/main/loadstring",
            Type = "remote",
            Enabled = true,
        },
        {
            Category = "mm2",
            Name = "HoneLua",
            Description = "Murder Mystery 2 script",
            Icon = "sparkles",
            URL = "https://raw.githubusercontent.com/ThatSick/HoneyLua/refs/heads/main/Loader.luau",
            Type = "remote",
            Enabled = true,
        },

        {
            Category = "keyboard",
            Name = "Script 1",
            Description = "Keyboard Map script",
            Icon = "keyboard",
            URL = "https://api.jnkie.com/api/v1/luascripts/public/4386aea55612ce01731b47a200b9279bdd9edb81f99334a11e874017e5810257/download",
            Type = "remote",
            Enabled = true,
        },
    }
}

--==================================================
-- HELPERS
--==================================================

local function Notify(title, content, duration)
    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Duration = duration or 3,
        })
    end)
end

local function CopyToClipboard(text)
    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    end
end

local function RunRemote(url, name)
    if type(url) ~= "string" or url == "" then
        Notify("Blast Hub", "Invalid URL for " .. tostring(name), 4)
        return
    end

    local ok, result = pcall(function()
        local source = game:HttpGet(url)
        local fn, compileError = loadstring(source)

        if not fn then
            error(compileError or "Failed to compile script")
        end

        return fn()
    end)

    if not ok then
        Notify(
            "Blast Hub",
            tostring(name) .. " failed: " .. tostring(result),
            5
        )
    end
end

local function RunScriptData(item)
    if not item or item.Enabled == false then
        return
    end

    if item.Type == "asset" then
        local ok, result = pcall(function()
            local object = game:GetObjects(
                "rbxassetid://" .. tostring(item.URL)
            )[1]

            if not object then
                error("Asset was not found")
            end

            local source = object.Source

            if type(source) ~= "string" or source == "" then
                error("Asset does not contain executable source")
            end

            local fn, compileError = loadstring(source)

            if not fn then
                error(compileError or "Failed to compile asset source")
            end

            return fn()
        end)

        if not ok then
            Notify(
                "Blast Hub",
                tostring(item.Name) .. " failed: " .. tostring(result),
                5
            )
        end
    else
        RunRemote(item.URL, item.Name)
    end
end

--==================================================
-- WINDOW
--==================================================

local Window = WindUI:CreateWindow({
    Title = "Blast Hub",
    Icon = "flame",
    Author = "Powered by TPC",
    Folder = "BlastHub",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),

    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SidebarWidth = 200,
    BackgroundImageTransparency = 0.42,

    User = {
        Enabled = true,
    },

    KeySystem = {
        Key = {
            "TPC",
            "Medo",
            "MX_SASUKE",
            "MH_KIRA",
            "ZA3EM",
        },
        URL = "https://discord.gg/CZh7ZHB6ag",
        SaveKey = true,
    },

    OpenButton = {
        Title = "Blast Hub",
        Icon = "smartphone",
        CornerRadius = UDim.new(0, 10),
        StrokeThickness = 2,
        Draggable = true,
    },
})

--==================================================
-- HEADER TAGS
--==================================================

pcall(function()
    Window:Tag({
        Title = "v1.0",
        Color = Color3.fromRGB(80, 200, 120),
        Radius = 6,
    })
end)

local FpsTag
local PingTag

pcall(function()
    FpsTag = Window:Tag({
        Title = "FPS: --",
        Radius = 6,
    })

    PingTag = Window:Tag({
        Title = "Ping: --",
        Radius = 6,
    })
end)

--==================================================
-- FPS
--==================================================

task.spawn(function()
    local last = tick()
    local frames = 0

    RunService.RenderStepped:Connect(function()
        frames += 1

        local now = tick()

        if now - last >= 1 then
            local fps = math.floor(frames / (now - last))

            frames = 0
            last = now

            if FpsTag then
                local color

                if fps >= 60 then
                    color = Color3.fromRGB(80, 200, 120)
                elseif fps >= 30 then
                    color = Color3.fromRGB(255, 190, 70)
                else
                    color = Color3.fromRGB(255, 80, 80)
                end

                pcall(function()
                    FpsTag:SetTitle("FPS: " .. tostring(fps))
                    FpsTag:SetColor(color)
                end)
            end
        end
    end)
end)

--==================================================
-- PING
--==================================================

task.spawn(function()
    while task.wait(2) do
        local ping

        pcall(function()
            ping = math.floor(
                LocalPlayer:GetNetworkPing() * 1000
            )
        end)

        if ping and PingTag then
            local color

            if ping <= 80 then
                color = Color3.fromRGB(80, 200, 120)
            elseif ping <= 120 then
                color = Color3.fromRGB(255, 190, 70)
            else
                color = Color3.fromRGB(255, 80, 80)
            end

            pcall(function()
                PingTag:SetTitle(
                    "Ping: " .. tostring(ping) .. "ms"
                )

                PingTag:SetColor(color)
            end)
        end
    end
end)

--==================================================
-- MAIN MENU
--==================================================

local MainTab = Window:Tab({
    Title = "Menu",
    Icon = "house",
    Locked = false,
})

MainTab:Section({
    Title = "Social Media",
    Icon = "bird",
    Opened = true,
})

MainTab:Paragraph({
    Title = "YouTube",
    Desc = "TPC_TubeRblx",
    Image = "https://i.postimg.cc/G3S88tzs/You-Tube.png",
    ImageSize = 30,

    Buttons = {
        {
            Icon = "copy",
            Title = "Copy",

            Callback = function()
                CopyToClipboard(
                    "https://youtube.com/@tpc_tuberblx?si=Th7dMkhZ8OIUcL3-"
                )

                Notify(
                    "Blast Hub",
                    "YouTube link copied",
                    2
                )
            end,
        },
    },
})

MainTab:Paragraph({
    Title = "Discord",
    Desc = "Join our Discord server",
    Image = "https://i.postimg.cc/Y0PY7fbD/Discord.png",
    ImageSize = 30,

    Buttons = {
        {
            Icon = "copy",
            Title = "Copy",

            Callback = function()
                CopyToClipboard(
                    "https://discord.gg/CZh7ZHB6ag"
                )

                Notify(
                    "Blast Hub",
                    "Discord link copied",
                    2
                )
            end,
        },
    },
})

MainTab:Paragraph({
    Title = "Telegram",
    Desc = "TPC Telegram",
    Image = "https://i.postimg.cc/Dfpq1nnr/Telegram.png",
    ImageSize = 30,

    Buttons = {
        {
            Icon = "copy",
            Title = "Copy",

            Callback = function()
                CopyToClipboard(
                    "https://t.me/tpc2009"
                )

                Notify(
                    "Blast Hub",
                    "Telegram link copied",
                    2
                )
            end,
        },
    },
})

--==================================================
-- VISUALS
--==================================================

local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
    Locked = false,
})

VisualsTab:Section({
    Title = "Performance",
    Icon = "gauge",
    Opened = true,
})

--==================================================
-- ANTI AFK
--==================================================

local antiAFKConnection

VisualsTab:Toggle({
    Title = "Anti AFK",
    Desc = "Prevent Roblox idle kick",
    Value = false,

    Callback = function(value)
        if value then
            local VirtualUser =
                game:GetService("VirtualUser")

            if antiAFKConnection then
                antiAFKConnection:Disconnect()
            end

            antiAFKConnection =
                LocalPlayer.Idled:Connect(function()
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(
                            Vector2.new()
                        )
                    end)
                end)

            Notify(
                "Blast Hub",
                "Anti AFK enabled",
                3
            )
        else
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
            end

            Notify(
                "Blast Hub",
                "Anti AFK disabled",
                3
            )
        end
    end,
})

--==================================================
-- ANTI FLING
--==================================================

local antiFlingConnection

VisualsTab:Toggle({
    Title = "Anti Fling",
    Desc = "Block extreme character velocities",
    Value = false,

    Callback = function(value)
        if value then
            if antiFlingConnection then
                antiFlingConnection:Disconnect()
            end

            antiFlingConnection =
                RunService.Heartbeat:Connect(function()
                    for _, player in ipairs(
                        Players:GetPlayers()
                    ) do
                        if player ~= LocalPlayer
                            and player.Character then

                            for _, obj in ipairs(
                                player.Character:GetDescendants()
                            ) do
                                if obj:IsA("BasePart") then
                                    pcall(function()
                                        if obj.AssemblyLinearVelocity.Magnitude > 100 then
                                            obj.AssemblyLinearVelocity =
                                                Vector3.zero
                                        end

                                        if obj.AssemblyAngularVelocity.Magnitude > 100 then
                                            obj.AssemblyAngularVelocity =
                                                Vector3.zero
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end)

            Notify(
                "Blast Hub",
                "Anti Fling enabled",
                3
            )
        else
            if antiFlingConnection then
                antiFlingConnection:Disconnect()
                antiFlingConnection = nil
            end

            Notify(
                "Blast Hub",
                "Anti Fling disabled",
                3
            )
        end
    end,
})

--==================================================
-- ESP
--==================================================

local espEnabled = false
local espFolder

local function ClearESP()
    if espFolder then
        espFolder:Destroy()
        espFolder = nil
    end
end

local function CreateESP()
    ClearESP()

    espFolder = Instance.new("Folder")
    espFolder.Name = "BlastHubESP"
    espFolder.Parent = workspace

    for _, player in ipairs(
        Players:GetPlayers()
    ) do
        if player ~= LocalPlayer
            and player.Character then

            local highlight = Instance.new("Highlight")

            highlight.Name = "PlayerESP"
            highlight.Adornee = player.Character
            highlight.DepthMode =
                Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillTransparency = 0.65
            highlight.OutlineTransparency = 0

            highlight.Parent = espFolder
        end
    end
end

VisualsTab:Toggle({
    Title = "ESP",
    Desc = "Highlight other players",
    Value = false,

    Callback = function(value)
        espEnabled = value

        if value then
            CreateESP()

            Notify(
                "Blast Hub",
                "ESP enabled",
                3
            )
        else
            ClearESP()

            Notify(
                "Blast Hub",
                "ESP disabled",
                3
            )
        end
    end,
})

--==================================================
-- ANTI LAG
--==================================================

local antiLagEnabled = false
local antiLagSaved = {}

local function EnableAntiLag()
    if antiLagEnabled then
        return
    end

    antiLagEnabled = true

    pcall(function()
        antiLagSaved.GlobalShadows = Lighting.GlobalShadows
        antiLagSaved.FogEnd = Lighting.FogEnd
        antiLagSaved.FogStart = Lighting.FogStart

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 0
    end)

    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")

        if terrain then
            antiLagSaved.Decoration = terrain.Decoration
            antiLagSaved.WaterWaveSize = terrain.WaterWaveSize
            antiLagSaved.WaterWaveSpeed = terrain.WaterWaveSpeed
            antiLagSaved.WaterReflectance = terrain.WaterReflectance
            antiLagSaved.WaterTransparency = terrain.WaterTransparency

            terrain.Decoration = false
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end
    end)

    for _, obj in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                antiLagSaved[obj] = {
                    Material = obj.Material,
                    CastShadow = obj.CastShadow,
                }

                obj.CastShadow = false

            elseif obj:IsA("ParticleEmitter")
                or obj:IsA("Trail")
                or obj:IsA("Beam")
                or obj:IsA("Smoke")
                or obj:IsA("Fire")
                or obj:IsA("Sparkles") then

                antiLagSaved[obj] = {
                    Enabled = obj.Enabled,
                }

                obj.Enabled = false
            end
        end)
    end

    Notify(
        "Blast Hub",
        "Anti Lag enabled",
        3
    )
end

local function DisableAntiLag()
    if not antiLagEnabled then
        return
    end

    antiLagEnabled = false

    pcall(function()
        Lighting.GlobalShadows =
            antiLagSaved.GlobalShadows

        Lighting.FogEnd =
            antiLagSaved.FogEnd

        Lighting.FogStart =
            antiLagSaved.FogStart
    end)

    pcall(function()
        local terrain =
            workspace:FindFirstChildOfClass("Terrain")

        if terrain then
            if antiLagSaved.Decoration ~= nil then
                terrain.Decoration =
                    antiLagSaved.Decoration
            end

            if antiLagSaved.WaterWaveSize ~= nil then
                terrain.WaterWaveSize =
                    antiLagSaved.WaterWaveSize
            end

            if antiLagSaved.WaterWaveSpeed ~= nil then
                terrain.WaterWaveSpeed =
                    antiLagSaved.WaterWaveSpeed
            end

            if antiLagSaved.WaterReflectance ~= nil then
                terrain.WaterReflectance =
                    antiLagSaved.WaterReflectance
            end

            if antiLagSaved.WaterTransparency ~= nil then
                terrain.WaterTransparency =
                    antiLagSaved.WaterTransparency
            end
        end
    end)

    for obj, data in pairs(antiLagSaved) do
        if typeof(obj) == "Instance"
            and obj.Parent
            and type(data) == "table" then

            pcall(function()
                if obj:IsA("BasePart") then
                    if data.Material ~= nil then
                        obj.Material = data.Material
                    end

                    if data.CastShadow ~= nil then
                        obj.CastShadow = data.CastShadow
                    end

                elseif data.Enabled ~= nil then
                    obj.Enabled = data.Enabled
                end
            end)
        end
    end

    antiLagSaved = {}

    Notify(
        "Blast Hub",
        "Anti Lag disabled",
        3
    )
end

VisualsTab:Toggle({
    Title = "Anti Lag",
    Desc = "Reduce visual effects for better performance",
    Value = false,

    Callback = function(value)
        if value then
            EnableAntiLag()
        else
            DisableAntiLag()
        end
    end,
})

--==================================================
-- PLAYER
--==================================================

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user-round",
    Locked = false,
})

PlayerTab:Section({
    Title = "Movement",
    Icon = "move",
    Opened = true,
})

local originalGravity = workspace.Gravity
local originalWalkSpeed = 16
local originalJumpPower = 50
local originalJumpHeight = 7.2
local originalUseJumpPower = true

pcall(function()
    local character = LocalPlayer.Character
    local humanoid =
        character and
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        originalWalkSpeed =
            humanoid.WalkSpeed

        originalJumpPower =
            humanoid.JumpPower

        originalJumpHeight =
            humanoid.JumpHeight

        originalUseJumpPower =
            humanoid.UseJumpPower
    end
end)

local selectedSpeed = originalWalkSpeed
local selectedJump = originalJumpPower
local selectedGravity = originalGravity

local function ApplyPlayerValues()
    pcall(function()
        local character = LocalPlayer.Character

        local humanoid =
            character and
            character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.WalkSpeed =
                selectedSpeed

            humanoid.UseJumpPower = true

            humanoid.JumpPower =
                selectedJump
        end

        workspace.Gravity =
            selectedGravity
    end)
end

PlayerTab:Slider({
    Title = "Speed",
    Desc = "WalkSpeed",
    Step = 1,

    Value = {
        Min = 16,
        Max = 200,
        Default = originalWalkSpeed,
    },

    Callback = function(value)
        selectedSpeed =
            tonumber(value) or 16

        ApplyPlayerValues()
    end,
})

PlayerTab:Slider({
    Title = "Jump",
    Desc = "JumpPower",
    Step = 1,

    Value = {
        Min = 50,
        Max = 300,
        Default = originalJumpPower,
    },

    Callback = function(value)
        selectedJump =
            tonumber(value) or 50

        ApplyPlayerValues()
    end,
})

PlayerTab:Slider({
    Title = "Gravity",
    Desc = "Workspace gravity",
    Step = 1,

    Value = {
        Min = 0,
        Max = 500,
        Default = originalGravity,
    },

    Callback = function(value)
        selectedGravity =
            tonumber(value) or 196.2

        ApplyPlayerValues()
    end,
})

local playerCharacterConnection =
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        ApplyPlayerValues()
    end)

--==================================================
-- SETTINGS
--==================================================

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
    Locked = false,
})

SettingsTab:Section({
    Title = "Theme",
    Icon = "palette",
    Opened = true,
})

local Themes = {
    "Dark",
    "Light",
    "Amber",
    "CottonCandy",
    "Crimson",
    "Emerald",
    "Mellowsi",
    "Midnight",
    "MonokaiPro",
    "Plant",
    "Rainbow",
    "Red",
    "Rose",
    "Sky",
    "Violet",
}

SettingsTab:Dropdown({
    Title = "Theme",
    Desc = "Change Blast Hub theme",
    Values = Themes,
    Value = "Dark",

    Callback = function(theme)
        pcall(function()
            WindUI:SetTheme(theme)
        end)
    end,
})

SettingsTab:Section({
    Title = "Server",
    Icon = "server",
    Opened = true,
})

local function GetRequest()
    if request then
        return request

    elseif http_request then
        return http_request

    elseif syn and syn.request then
        return syn.request
    end
end

local function GetServerPage(cursor)
    local req = GetRequest()

    if not req then
        return nil
    end

    local url =
        "https://games.roblox.com/v1/games/" ..
        tostring(game.PlaceId) ..
        "/servers/Public?sortOrder=Asc&limit=100"

    if cursor and cursor ~= "" then
        url =
            url ..
            "&cursor=" ..
            HttpService:UrlEncode(cursor)
    end

    local ok, response = pcall(function()
        return req({
            Url = url,
            Method = "GET",

            Headers = {
                ["Content-Type"] =
                    "application/json",
            },
        })
    end)

    if not ok or not response then
        return nil
    end

    local body =
        response.Body or
        response.body

    if not body then
        return nil
    end

    local decodeOk, data =
        pcall(function()
            return HttpService:JSONDecode(body)
        end)

    if not decodeOk then
        return nil
    end

    return data
end

local function TeleportToServer(jobId)
    if not jobId then
        return
    end

    pcall(function()
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            jobId,
            LocalPlayer
        )
    end)
end

local function FindServer(mode)
    local cursor = nil
    local candidates = {}

    for _ = 1, 5 do
        local data =
            GetServerPage(cursor)

        if not data or not data.data then
            break
        end

        for _, server in ipairs(data.data) do
            if server.id ~= game.JobId
                and server.playing
                and server.maxPlayers
                and server.playing < server.maxPlayers then

                table.insert(
                    candidates,
                    server
                )
            end
        end

        cursor =
            data.nextPageCursor

        if not cursor then
            break
        end
    end

    if #candidates == 0 then
        Notify(
            "Blast Hub",
            "No suitable server found",
            4
        )

        return
    end

    local selected

    if mode == "Small" then
        table.sort(
            candidates,
            function(a, b)
                return a.playing < b.playing
            end
        )

        selected = candidates[1]

    elseif mode == "New" then
        selected =
            candidates[
                math.random(
                    1,
                    #candidates
                )
            ]

    else
        selected = candidates[1]
    end

    Notify(
        "Blast Hub",
        "Teleporting...",
        2
    )

    TeleportToServer(
        selected.id
    )
end

SettingsTab:Button({
    Title = "Rejoin",
    Desc = "Rejoin current server",
    Icon = "refresh-cw",

    Callback = function()
        pcall(function()
            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                game.JobId,
                LocalPlayer
            )
        end)
    end,
})

SettingsTab:Button({
    Title = "New Server",
    Desc = "Join another public server",
    Icon = "shuffle",

    Callback = function()
        FindServer("New")
    end,
})

SettingsTab:Button({
    Title = "Small Server",
    Desc = "Find a server with fewer players",
    Icon = "users-round",

    Callback = function()
        FindServer("Small")
    end,
})

SettingsTab:Button({
    Title = "Kick Yourself",
    Desc = "Kick yourself from the current game",
    Icon = "log-out",

    Callback = function()
        LocalPlayer:Kick(
            "Kicked by Blast Hub"
        )
    end,
})

--==================================================
-- AUTO SCRIPT TABS
--==================================================

local function CreateScriptTab(category)
    local hasScripts = false

    for _, item in ipairs(ScriptsData.Scripts) do
        if item.Category == category.Id
            and item.Enabled ~= false then

            hasScripts = true
            break
        end
    end

    if not hasScripts then
        return
    end

    local scriptTab = Window:Tab({
        Title = category.Name,
        Icon = category.Icon,
        Locked = false,
    })

    scriptTab:Section({
        Title = "↓ " .. category.Name .. " ↓",
        Opened = true,
    })

    for _, item in ipairs(ScriptsData.Scripts) do
        if item.Category == category.Id
            and item.Enabled ~= false then

            scriptTab:Button({
                Title = item.Name,
                Desc = item.Description,
                Icon = item.Icon,
                Locked = false,

                Callback = function()
                    RunScriptData(item)
                end,
            })
        end
    end
end

for _, category in ipairs(
    ScriptsData.Categories
) do
    CreateScriptTab(category)
end

--==================================================
-- CLEANUP
--==================================================

pcall(function()
    Window:OnDestroy(function()

        -- Anti AFK
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end

        -- Anti Fling
        if antiFlingConnection then
            antiFlingConnection:Disconnect()
            antiFlingConnection = nil
        end

        -- Player Character
        if playerCharacterConnection then
            playerCharacterConnection:Disconnect()
            playerCharacterConnection = nil
        end

        -- ESP
        ClearESP()

        -- Anti Lag
        if antiLagEnabled then
            DisableAntiLag()
        end

        -- Restore Gravity
        pcall(function()
            workspace.Gravity =
                originalGravity
        end)

        -- Restore Player Values
        pcall(function()
            local character =
                LocalPlayer.Character

            local humanoid =
                character
                and character:FindFirstChildOfClass(
                    "Humanoid"
                )

            if humanoid then
                humanoid.WalkSpeed =
                    originalWalkSpeed

                humanoid.UseJumpPower =
                    originalUseJumpPower

                humanoid.JumpPower =
                    originalJumpPower

                humanoid.JumpHeight =
                    originalJumpHeight
            end
        end)
    end)
end

--==================================================
-- FINAL
--==================================================

Notify(
    "Blast Hub",
    "Enjoying with Blast Hub!",
    4
)

print(
    "Blast Hub v1.0 loaded successfully"
)
