-- Place in: StarterGui > SourceHubGui > LocalScript
-- BEE HUB 🐝🍯 - animations + working shaders + sounds

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================================================
-- COLORS
-- =========================================================
local COLORS = {
    windowBg      = Color3.fromRGB(20, 16, 4),
    headerBg2     = Color3.fromRGB(32, 24, 4),
    tabBg         = Color3.fromRGB(40, 32, 6),
    tabHover      = Color3.fromRGB(70, 55, 10),
    tabText       = Color3.fromRGB(220, 210, 180),
    rowBg         = Color3.fromRGB(38, 30, 6),
    rowBgAlt      = Color3.fromRGB(48, 38, 8),
    rowHover      = Color3.fromRGB(68, 54, 10),
    rowText       = Color3.fromRGB(240, 235, 210),
    white         = Color3.fromRGB(255, 255, 255),
    dimText       = Color3.fromRGB(180, 170, 140),
    green         = Color3.fromRGB(60, 220, 100),

    accent        = Color3.fromRGB(240, 200, 30),
    accentDark    = Color3.fromRGB(60, 45, 6),
    accentHover   = Color3.fromRGB(255, 225, 80),
    border        = Color3.fromRGB(240, 200, 30),
    borderSoft    = Color3.fromRGB(110, 90, 15),
    scrollbar     = Color3.fromRGB(240, 200, 30),

    activeBtn     = Color3.fromRGB(220, 60, 60),
    activeBtnHover= Color3.fromRGB(255, 90, 90),
}

-- =========================================================
-- SOUNDS
-- =========================================================
local SOUND_IDS = {
    click = "rbxassetid://6895079853",
    on    = "rbxassetid://9114693783",
    off   = "rbxassetid://9114694064",
    open  = "rbxassetid://9114693783",
}

local soundFolder = Instance.new("Folder")
soundFolder.Name = "BeeHubSounds"
soundFolder.Parent = SoundService

local function makeSound(name, id, vol, speed)
    local s = Instance.new("Sound")
    s.Name = name
    s.SoundId = id
    s.Volume = vol or 0.5
    s.PlaybackSpeed = speed or 1
    s.Parent = soundFolder
    return s
end

local sounds = {
    click = makeSound("Click", SOUND_IDS.click, 0.5, 1.6),
    on    = makeSound("On",    SOUND_IDS.on,    0.6, 1),
    off   = makeSound("Off",   SOUND_IDS.off,   0.5, 1),
    open  = makeSound("Open",  SOUND_IDS.open,  0.5, 1),
}

local function playSound(name)
    local s = sounds[name]
    if not s then return end
    s.TimePosition = 0
    s:Play()
end

-- =========================================================
-- SCREEN GUI
-- =========================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SourceHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local uiScale = Instance.new("UIScale")
uiScale.Parent = screenGui

local function updateScale()
    local vp = workspace.CurrentCamera.ViewportSize
    local minSide = math.min(vp.X, vp.Y)
    if minSide < 500 then uiScale.Scale = 0.72
    elseif minSide < 800 then uiScale.Scale = 0.9
    else uiScale.Scale = 1 end
end
updateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- =========================================================
-- WINDOW
-- =========================================================
local window = Instance.new("Frame")
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.new(0.5, 0, 0.5, 0)
window.Size = UDim2.new(0, 620, 0, 460)
window.BackgroundColor3 = COLORS.windowBg
window.BorderSizePixel = 0
window.Active = true
window.Draggable = true
window.Parent = screenGui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 6)
windowCorner.Parent = window

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = COLORS.border
windowStroke.Thickness = 1.5
windowStroke.Parent = window

-- =========================================================
-- HEADER
-- =========================================================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = COLORS.accentDark
header.BorderSizePixel = 0
header.Parent = window

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 6)
hc.Parent = header

local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0, 6)
headerCover.Position = UDim2.new(0, 0, 1, -6)
headerCover.BackgroundColor3 = COLORS.accentDark
headerCover.BorderSizePixel = 0
headerCover.ZIndex = 1
headerCover.Parent = header

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, COLORS.accentDark),
    ColorSequenceKeypoint.new(1, COLORS.headerBg2),
})
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Position = UDim2.new(0, 14, 0, 0)
title.Size = UDim2.new(0, 200, 1, 0)
title.BackgroundTransparency = 1
title.Text = "BEE HUB 🐝🍯"
title.TextColor3 = COLORS.accent
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2
title.Parent = header

local discord = Instance.new("TextLabel")
discord.Position = UDim2.new(0, 200, 0, 0)
discord.Size = UDim2.new(0, 180, 1, 0)
discord.BackgroundTransparency = 1
discord.Text = "discord.gg/sourcehubs"
discord.TextColor3 = COLORS.dimText
discord.Font = Enum.Font.GothamMedium
discord.TextSize = 12
discord.TextXAlignment = Enum.TextXAlignment.Left
discord.ZIndex = 2
discord.Parent = header

local scriptsStat = Instance.new("TextLabel")
scriptsStat.AnchorPoint = Vector2.new(1, 0)
scriptsStat.Position = UDim2.new(1, -150, 0, 0)
scriptsStat.Size = UDim2.new(0, 100, 1, 0)
scriptsStat.BackgroundTransparency = 1
scriptsStat.Text = "● 61 SCRIPTS"
scriptsStat.TextColor3 = COLORS.green
scriptsStat.Font = Enum.Font.GothamBold
scriptsStat.TextSize = 11
scriptsStat.TextXAlignment = Enum.TextXAlignment.Right
scriptsStat.ZIndex = 2
scriptsStat.Parent = header

local usersStat = Instance.new("TextLabel")
usersStat.AnchorPoint = Vector2.new(1, 0)
usersStat.Position = UDim2.new(1, -80, 0, 0)
usersStat.Size = UDim2.new(0, 60, 1, 0)
usersStat.BackgroundTransparency = 1
usersStat.Text = "167"
usersStat.TextColor3 = COLORS.white
usersStat.Font = Enum.Font.GothamBold
usersStat.TextSize = 11
usersStat.TextXAlignment = Enum.TextXAlignment.Right
usersStat.ZIndex = 2
usersStat.Parent = header

local pingStat = Instance.new("TextLabel")
pingStat.AnchorPoint = Vector2.new(1, 0)
pingStat.Position = UDim2.new(1, -20, 0, 0)
pingStat.Size = UDim2.new(0, 60, 1, 0)
pingStat.BackgroundTransparency = 1
pingStat.Text = "163ms"
pingStat.TextColor3 = COLORS.white
pingStat.Font = Enum.Font.GothamBold
pingStat.TextSize = 11
pingStat.TextXAlignment = Enum.TextXAlignment.Right
pingStat.ZIndex = 2
pingStat.Parent = header

local minBtn = Instance.new("TextButton")
minBtn.AnchorPoint = Vector2.new(1, 0)
minBtn.Position = UDim2.new(1, -34, 0, 0)
minBtn.Size = UDim2.new(0, 20, 1, 0)
minBtn.BackgroundTransparency = 1
minBtn.Text = "—"
minBtn.TextColor3 = COLORS.accent
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.ZIndex = 3
minBtn.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.Position = UDim2.new(1, -6, 0, 0)
closeBtn.Size = UDim2.new(0, 20, 1, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = COLORS.accent
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.ZIndex = 3
closeBtn.Parent = header

-- =========================================================
-- TABS
-- =========================================================
local tabBar = Instance.new("Frame")
tabBar.Position = UDim2.new(0, 10, 0, 48)
tabBar.Size = UDim2.new(1, -20, 0, 34)
tabBar.BackgroundTransparency = 1
tabBar.Parent = window

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabBar

local function createTab(name, order)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(0.245, 0, 1, 0)
    tab.BackgroundColor3 = COLORS.tabBg
    tab.BorderSizePixel = 0
    tab.Text = name
    tab.TextColor3 = COLORS.tabText
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 12
    tab.AutoButtonColor = false
    tab.LayoutOrder = order
    tab.Parent = tabBar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = tab

    local s = Instance.new("UIStroke")
    s.Color = COLORS.borderSoft
    s.Thickness = 1
    s.Parent = tab

    tab.MouseEnter:Connect(function()
        if tab.BackgroundColor3 ~= COLORS.accent then
            TweenService:Create(tab, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.tabHover}):Play()
        end
    end)
    tab.MouseLeave:Connect(function()
        if tab.BackgroundColor3 ~= COLORS.accent then
            TweenService:Create(tab, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.tabBg}):Play()
        end
    end)

    -- press bounce
    tab.MouseButton1Down:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.06), {Size = UDim2.new(0.235, 0, 0.92, 0)}):Play()
    end)
    tab.MouseButton1Up:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0.245, 0, 1, 0)}):Play()
    end)

    return tab
end

local tabs = {
    createTab("SCRIPTS", 1),
    createTab("SERVER HOP", 2),
    createTab("SHADER", 3),
    createTab("SETTINGS", 4),
}

local activeTab = tabs[3]

local function setActiveTab(tab)
    for _, t in ipairs(tabs) do
        if t == tab then
            t.BackgroundColor3 = COLORS.accent
            t.TextColor3 = Color3.fromRGB(30, 20, 0)
            t.UIStroke.Color = COLORS.border
        else
            t.BackgroundColor3 = COLORS.tabBg
            t.TextColor3 = COLORS.tabText
            t.UIStroke.Color = COLORS.borderSoft
        end
    end
end

-- =========================================================
-- LIST
-- =========================================================
local listContainer = Instance.new("Frame")
listContainer.Position = UDim2.new(0, 10, 0, 90)
listContainer.Size = UDim2.new(1, -20, 1, -100)
listContainer.BackgroundTransparency = 1
listContainer.ClipsDescendants = true
listContainer.Parent = window

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -8, 1, 0)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = COLORS.scrollbar
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.Parent = listContainer

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scroll

local listPadding = Instance.new("UIPadding")
listPadding.PaddingRight = UDim.new(0, 6)
listPadding.PaddingTop = UDim.new(0, 2)
listPadding.PaddingBottom = UDim.new(0, 6)
listPadding.Parent = scroll

local trackedRows = {}
local trackedButtons = {}

-- =========================================================
-- ANIMATION HELPERS
-- =========================================================
-- Smooth slide-in for each row when a tab opens
local function animateRowIn(row, index)
    row.BackgroundTransparency = 1
    row.Position = UDim2.new(-0.15, 0, 0, 0)

    TweenService:Create(row,
        TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, index * 0.035),
        {BackgroundTransparency = 0, Position = UDim2.new(0, 0, 0, 0)}
    ):Play()

    -- animate children too
    for _, child in ipairs(row:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            local originalText = child.TextTransparency
            child.TextTransparency = 1
            TweenService:Create(child,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, index * 0.035 + 0.08),
                {TextTransparency = originalText}
            ):Play()
        end
    end
end

-- Pulse glow ring when shader activates
local function pulseGlow(row, color)
    local glow = Instance.new("Frame")
    glow.Name = "PulseGlow"
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.new(0, 20, 0, 20)
    glow.BackgroundColor3 = color
    glow.BackgroundTransparency = 0.4
    glow.BorderSizePixel = 0
    glow.ZIndex = 5
    glow.Parent = row

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0.5, 0)
    c.Parent = glow

    TweenService:Create(glow, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.4, 0, 3, 0),
        BackgroundTransparency = 1,
    }):Play()

    task.delay(0.55, function()
        glow:Destroy()
    end)
end

-- Fade ripple when shader deactivates
local function fadeRipple(row)
    local ripple = Instance.new("Frame")
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.Size = UDim2.new(1, 0, 1, 0)
    ripple.BackgroundColor3 = COLORS.white
    ripple.BackgroundTransparency = 0.5
    ripple.BorderSizePixel = 0
    ripple.ZIndex = 5
    ripple.Parent = row

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = ripple

    TweenService:Create(ripple, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
    }):Play()

    task.delay(0.45, function()
        ripple:Destroy()
    end)
end

-- Button bounce on click
local function buttonBounce(btn)
    local originalSize = btn.Size
    TweenService:Create(btn, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, originalSize.X.Offset - 8, 0, originalSize.Y.Offset - 4)}):Play()

    task.delay(0.08, function()
        TweenService:Create(btn, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = originalSize}):Play()
    end)
end

-- Row shake when activated
local function shakeRow(row)
    local originalPos = row.Position
    for i = 1, 4 do
        local offset = (i % 2 == 0) and 4 or -4
        TweenService:Create(row, TweenInfo.new(0.04), {Position = originalPos + UDim2.new(0, offset, 0, 0)}):Play()
        task.wait(0.04)
    end
    TweenService:Create(row, TweenInfo.new(0.06), {Position = originalPos}):Play()
end

-- =========================================================
-- ROW CREATOR
-- =========================================================
local function createRow(labelText, order, onActivate)
    local row = Instance.new("Frame")
    row.Name = labelText:gsub("%s", "") .. "Row"
    row.Size = UDim2.new(1, 0, 0, 52)
    row.BackgroundColor3 = (order % 2 == 0) and COLORS.rowBgAlt or COLORS.rowBg
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = scroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = row

    local s = Instance.new("UIStroke")
    s.Color = COLORS.borderSoft
    s.Thickness = 1
    s.Parent = row

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0, 14, 0, 0)
    label.Size = UDim2.new(0.62, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = COLORS.rowText
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local activate = Instance.new("TextButton")
    activate.AnchorPoint = Vector2.new(1, 0.5)
    activate.Position = UDim2.new(1, -12, 0.5, 0)
    activate.Size = UDim2.new(0, 110, 0, 34)
    activate.BackgroundColor3 = COLORS.accent
    activate.BorderSizePixel = 0
    activate.Text = "ACTIVATE"
    activate.TextColor3 = Color3.fromRGB(30, 20, 0)
    activate.Font = Enum.Font.GothamBold
    activate.TextSize = 12
    activate.AutoButtonColor = false
    activate.Parent = row

    local ac = Instance.new("UICorner")
    ac.CornerRadius = UDim.new(0, 4)
    ac.Parent = activate

    local as = Instance.new("UIStroke")
    as.Color = COLORS.border
    as.Thickness = 1
    as.Parent = activate

    local isOn = false

    activate.MouseEnter:Connect(function()
        local hover = isOn and COLORS.activeBtnHover or COLORS.accentHover
        TweenService:Create(activate, TweenInfo.new(0.12), {BackgroundColor3 = hover}):Play()
    end)
    activate.MouseLeave:Connect(function()
        local base = isOn and COLORS.activeBtn or COLORS.accent
        TweenService:Create(activate, TweenInfo.new(0.12), {BackgroundColor3 = base}):Play()
    end)

    activate.MouseButton1Click:Connect(function()
        playSound("click")
        buttonBounce(activate)

        isOn = not isOn

        if isOn then
            -- ✨ ACTIVATE animations
            pulseGlow(row, COLORS.accent)
            shakeRow(row)

            -- button color swap
            activate.Text = "DEACTIVATE"
            TweenService:Create(activate, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.activeBtn}):Play()
            activate.TextColor3 = COLORS.white

            -- row flash
            TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.accent}):Play()
            task.delay(0.2, function()
                local base = (order % 2 == 0) and COLORS.rowBgAlt or COLORS.rowBg
                TweenService:Create(row, TweenInfo.new(0.35), {BackgroundColor3 = base}):Play()
            end)

            playSound("on")
        else
            -- ✨ DEACTIVATE animations
            fadeRipple(row)

            activate.Text = "ACTIVATE"
            TweenService:Create(activate, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.accent}):Play()
            activate.TextColor3 = Color3.fromRGB(30, 20, 0)

            playSound("off")
        end

        if onActivate then onActivate(isOn) end
    end)

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.rowHover}):Play()
    end)
    row.MouseLeave:Connect(function()
        local base = (order % 2 == 0) and COLORS.rowBgAlt or COLORS.rowBg
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = base}):Play()
    end)

    table.insert(trackedRows, {row = row, stroke = s, order = order})
    table.insert(trackedButtons, {btn = activate, stroke = as, getOn = function() return isOn end})

    -- slide-in animation
    animateRowIn(row, order)

    return row
end

-- =========================================================
-- THEME SYSTEM
-- =========================================================
local function applyTheme(r, g, b)
    local accent = Color3.fromRGB(r, g, b)
    local darken = function(c, f) return Color3.fromRGB(math.floor(c.R*f), math.floor(c.G*f), math.floor(c.B*f)) end
    local lighten = function(c, f)
        return Color3.fromRGB(
            math.min(255, math.floor(c.R*f)),
            math.min(255, math.floor(c.G*f)),
            math.min(255, math.floor(c.B*f))
        )
    end

    COLORS.accent      = accent
    COLORS.accentDark  = darken(accent, 0.22)
    COLORS.accentHover = lighten(accent, 1.18)
    COLORS.border      = accent
    COLORS.borderSoft  = darken(accent, 0.45)
    COLORS.scrollbar   = accent

    TweenService:Create(windowStroke, TweenInfo.new(0.3), {Color = accent}):Play()
    TweenService:Create(header, TweenInfo.new(0.3), {BackgroundColor3 = COLORS.accentDark}):Play()
    TweenService:Create(headerCover, TweenInfo.new(0.3), {BackgroundColor3 = COLORS.accentDark}):Play()
    TweenService:Create(title, TweenInfo.new(0.3), {TextColor3 = accent}):Play()
    TweenService:Create(minBtn, TweenInfo.new(0.3), {TextColor3 = accent}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.3), {TextColor3 = accent}):Play()

    for _, t in ipairs(tabs) do
        t.UIStroke.Color = (t.BackgroundColor3 == accent) and accent or COLORS.borderSoft
    end
    setActiveTab(activeTab)

    for _, entry in ipairs(trackedRows) do
        entry.stroke.Color = COLORS.borderSoft
    end

    for _, entry in ipairs(trackedButtons) do
        if entry.getOn and entry.getOn() then
            entry.btn.BackgroundColor3 = COLORS.activeBtn
        else
            TweenService:Create(entry.btn, TweenInfo.new(0.25), {BackgroundColor3 = accent}):Play()
        end
        entry.btn.UIStroke.Color = accent
    end

    scroll.ScrollBarImageColor3 = accent
end

-- =========================================================
-- SHADER EFFECTS
-- =========================================================
local shaderEffects = {
    {
        name = "CINEMATIC BLOOM",
        setup = function()
            local fx = Instance.new("BloomEffect")
            fx.Name = "BeeHub_Bloom"
            fx.Intensity = 1.5
            fx.Size = 32
            fx.Threshold = 0.8
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Bloom")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "VIBRANT COLOR",
        setup = function()
            local fx = Instance.new("ColorCorrectionEffect")
            fx.Name = "BeeHub_Vibrant"
            fx.Saturation = 0.8
            fx.Contrast = 0.25
            fx.Brightness = 0.05
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Vibrant")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "RETRO / SEPIA",
        setup = function()
            local fx = Instance.new("ColorCorrectionEffect")
            fx.Name = "BeeHub_Sepia"
            fx.Saturation = -1
            fx.Contrast = 0.15
            fx.Brightness = 0.02
            fx.TintColor = Color3.fromRGB(230, 190, 120)
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Sepia")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "DEEP NIGHTS",
        setup = function()
            local fx = Instance.new("ColorCorrectionEffect")
            fx.Name = "BeeHub_Night"
            fx.Brightness = -0.15
            fx.Contrast = 0.3
            fx.TintColor = Color3.fromRGB(60, 80, 140)
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Night")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "SOFT BLUR",
        setup = function()
            local fx = Instance.new("BlurEffect")
            fx.Name = "BeeHub_Blur"
            fx.Size = 12
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Blur")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "SUN GLOW",
        setup = function()
            local fx = Instance.new("SunRaysEffect")
            fx.Name = "BeeHub_SunRays"
            fx.Intensity = 0.25
            fx.Spread = 1
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_SunRays")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "FILM GRAIN",
        setup = function()
            local fx = Instance.new("ColorCorrectionEffect")
            fx.Name = "BeeHub_Grain"
            fx.Contrast = 0.6
            fx.Saturation = -0.3
            fx.Brightness = -0.02
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Grain")
            if fx then fx:Destroy() end
        end,
    },
    {
        name = "CHROMATIC ABERRATION",
        setup = function()
            local fx = Instance.new("ColorCorrectionEffect")
            fx.Name = "BeeHub_Chroma"
            fx.Saturation = 1
            fx.Contrast = 0.4
            fx.TintColor = Color3.fromRGB(255, 230, 255)
            fx.Parent = Lighting
        end,
        teardown = function()
            local fx = Lighting:FindFirstChild("BeeHub_Chroma")
            if fx then fx:Destroy() end
        end,
    },
}

for _, shader in ipairs(shaderEffects) do
    shader.teardown()
end

-- =========================================================
-- THEMES
-- =========================================================
local themes = {
    { name = "🐝 HONEY (DEFAULT)", r = 240, g = 200, b = 30  },
    { name = "🔴 RED",             r = 210, g = 25,  b = 25  },
    { name = "🟢 GREEN",           r = 40,  g = 200, b = 70  },
    { name = "🔵 BLUE",            r = 40,  g = 120, b = 230 },
    { name = "🟣 PURPLE",          r = 150, g = 60,  b = 220 },
    { name = "🟡 GOLD",            r = 220, g = 180, b = 30  },
    { name = "🩷 PINK",            r = 230, g = 70,  b = 150 },
    { name = "🌈 CYAN",            r = 40,  g = 200, b = 210 },
    { name = "⚪ WHITE",           r = 220, g = 220, b = 220 },
    { name = "🟠 ORANGE",          r = 240, g = 130, b = 30  },
}

-- =========================================================
-- BUILD LISTS
-- =========================================================
local function clearList()
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    trackedRows = {}
    trackedButtons = {}
end

local function buildShaderList()
    for i, shader in ipairs(shaderEffects) do
        createRow(shader.name, i, function(isOn)
            if isOn then
                shader.setup()
                print("[BEE HUB] " .. shader.name .. " ON")
            else
                shader.teardown()
                print("[BEE HUB] " .. shader.name .. " OFF")
            end
        end)
    end
end

local function buildSettingsList()
    local headerRow = Instance.new("Frame")
    headerRow.Size = UDim2.new(1, 0, 0, 34)
    headerRow.BackgroundTransparency = 1
    headerRow.LayoutOrder = 0
    headerRow.Parent = scroll

    local hl = Instance.new("TextLabel")
    hl.Size = UDim2.new(1, 0, 1, 0)
    hl.BackgroundTransparency = 1
    hl.Text = "🎨  CHOOSE A THEME COLOR"
    hl.TextColor3 = COLORS.dimText
    hl.Font = Enum.Font.GothamBold
    hl.TextSize = 12
    hl.TextXAlignment = Enum.TextXAlignment.Left
    hl.Parent = headerRow

    for i, theme in ipairs(themes) do
        local capturedTheme = theme
        createRow(capturedTheme.name, i, function()
            applyTheme(capturedTheme.r, capturedTheme.g, capturedTheme.b)
            print("[BEE HUB] Theme -> " .. capturedTheme.name)
        end)
    end
end

local placeholderData = {
    SCRIPTS        = { "AUTO FARM", "SPEED HACK", "JUMP POWER", "INFINITE YIELD" },
    ["SERVER HOP"] = { "LOWEST PING", "REGION: ASIA", "REGION: EU", "REGION: US" },
}

local function buildList(tabName)
    clearList()
    if tabName == "SHADER" then
        buildShaderList()
    elseif tabName == "SETTINGS" then
        buildSettingsList()
    else
        local data = placeholderData[tabName] or {}
        for i, name in ipairs(data) do
            createRow(name, i, function()
                print("[BEE HUB] " .. name .. " on " .. tabName)
            end)
        end
    end
end

-- =========================================================
-- TABS
-- =========================================================
for _, t in ipairs(tabs) do
    t.MouseButton1Click:Connect(function()
        playSound("click")
        setActiveTab(t)
        activeTab = t
        buildList(t.Name:gsub("Tab$", ""))
    end)
end

-- =========================================================
-- HEADER BUTTONS
-- =========================================================
closeBtn.MouseButton1Click:Connect(function()
    playSound("click")
    for _, shader in ipairs(shaderEffects) do shader.teardown() end

    -- fade out animation
    TweenService:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
    }):Play()
    task.delay(0.3, function()
        screenGui.Enabled = false
    end)
end)

minBtn.MouseButton1Click:Connect(function()
    playSound("click")
    local visible = listContainer.Visible
    listContainer.Visible = not visible
    TweenService:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = visible and UDim2.new(0, 620, 0, 130) or UDim2.new(0, 620, 0, 460),
    }):Play()
end)

-- =========================================================
-- DRAG
-- =========================================================
do
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
        end
    end)
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- =========================================================
-- INTRO ANIMATION (when GUI opens)
-- =========================================================
local function playIntro()
    local originalSize = window.Size
    local originalPos = window.Position

    window.Size = UDim2.new(0, 0, 0, 0)
    window.BackgroundTransparency = 1
    windowStroke.Transparency = 1

    -- Title shimmer sweep
    local shimmer = Instance.new("Frame")
    shimmer.Name = "TitleShimmer"
    shimmer.Size = UDim2.new(0, 60, 1, 0)
    shimmer.Position = UDim2.new(0, -60, 0, 0)
    shimmer.BackgroundColor3 = COLORS.white
    shimmer.BackgroundTransparency = 0.6
    shimmer.BorderSizePixel = 0
    shimmer.ZIndex = 5
    shimmer.Parent = header

    task.delay(0.25, function()
        TweenService:Create(window, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = originalSize,
            BackgroundTransparency = 0,
        }):Play()
        TweenService:Create(windowStroke, TweenInfo.new(0.45), {Transparency = 0}):Play()

        TweenService:Create(shimmer, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 20, 0, 0),
        }):Play()
    end)

    task.delay(1, function()
        shimmer:Destroy()
    end)

    -- play open sound
    playSound("open")
end

-- =========================================================
-- INIT
-- =========================================================
setActiveTab(activeTab)
buildList("SHADER")
playIntro()

print("[BEE HUB 🐝🍯] Loaded with animations + sounds + working shaders.")