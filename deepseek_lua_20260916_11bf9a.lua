-- Place in: StarterGui > SourceHubGui > LocalScript
-- BEE HUB 🐝🍯 - yellow/honey themed GUI with theme color changer

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================================================
-- BASE COLORS (yellow default)
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

    -- accent-driven (yellow by default)
    accent        = Color3.fromRGB(240, 200, 30),
    accentDark    = Color3.fromRGB(60, 45, 6),
    accentHover   = Color3.fromRGB(255, 225, 80),
    border        = Color3.fromRGB(240, 200, 30),
    borderSoft    = Color3.fromRGB(110, 90, 15),
    scrollbar     = Color3.fromRGB(240, 200, 30),
}

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
window.Name = "Window"
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
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = COLORS.accentDark
header.BorderSizePixel = 0
header.Parent = window

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 6)
headerCorner.Parent = header

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
title.Name = "Title"
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
-- TAB BAR
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
            tab.BackgroundColor3 = COLORS.tabHover
        end
    end)
    tab.MouseLeave:Connect(function()
        if tab.BackgroundColor3 ~= COLORS.accent then
            tab.BackgroundColor3 = COLORS.tabBg
        end
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
            t.TextColor3 = Color3.fromRGB(30, 20, 0) -- dark text on yellow
            t.UIStroke.Color = COLORS.border
        else
            t.BackgroundColor3 = COLORS.tabBg
            t.TextColor3 = COLORS.tabText
            t.UIStroke.Color = COLORS.borderSoft
        end
    end
end

-- =========================================================
-- LIST CONTAINER
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
    activate.TextColor3 = Color3.fromRGB(30, 20, 0) -- dark text on yellow
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

    activate.MouseEnter:Connect(function()
        TweenService:Create(activate, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.accentHover}):Play()
    end)
    activate.MouseLeave:Connect(function()
        TweenService:Create(activate, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.accent}):Play()
    end)

    activate.MouseButton1Click:Connect(function()
        activate.BackgroundColor3 = COLORS.white
        task.wait(0.08)
        activate.BackgroundColor3 = COLORS.accent
        if onActivate then onActivate() end
    end)

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.rowHover}):Play()
    end)
    row.MouseLeave:Connect(function()
        local base = (order % 2 == 0) and COLORS.rowBgAlt or COLORS.rowBg
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = base}):Play()
    end)

    table.insert(trackedRows, {row = row, stroke = s, order = order})
    table.insert(trackedButtons, {btn = activate, stroke = as})

    return row
end

-- =========================================================
-- THEME SYSTEM
-- =========================================================
-- Detects if accent is light (yellow/white/gold) to use dark text
local function isLight(c)
    local luminance = 0.2126 * c.R + 0.7152 * c.G + 0.0722 * c.B
    return luminance > 0.6
end

local function applyTheme(r, g, b)
    local accent = Color3.fromRGB(r, g, b)
    local darken = function(c, f)
        return Color3.fromRGB(math.floor(c.R*f), math.floor(c.G*f), math.floor(c.B*f))
    end
    local lighten = function(c, f)
        return Color3.fromRGB(
            math.min(255, math.floor(c.R*f)),
            math.min(255, math.floor(c.G*f)),
            math.min(255, math.floor(c.B*f))
        )
    end

    local accentDark  = darken(accent, 0.22)
    local accentHover = lighten(accent, 1.18)
    local border      = accent
    local borderSoft  = darken(accent, 0.45)

    COLORS.accent      = accent
    COLORS.accentDark  = accentDark
    COLORS.accentHover = accentHover
    COLORS.border      = border
    COLORS.borderSoft  = borderSoft
    COLORS.scrollbar   = border

    local contrastText = isLight(accent) and Color3.fromRGB(30, 20, 0) or COLORS.white

    -- Window border
    windowStroke.Color = border

    -- Header
    header.BackgroundColor3 = accentDark
    headerCover.BackgroundColor3 = accentDark
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, accentDark),
        ColorSequenceKeypoint.new(1, COLORS.headerBg2),
    })
    title.TextColor3 = accent
    minBtn.TextColor3 = accent
    closeBtn.TextColor3 = accent

    -- Tabs
    for _, t in ipairs(tabs) do
        if t.BackgroundColor3 == COLORS.accent then
            t.BackgroundColor3 = accent
        end
        t.UIStroke.Color = (t.BackgroundColor3 == accent) and border or borderSoft
    end
    setActiveTab(activeTab)

    -- Rows
    for _, entry in ipairs(trackedRows) do
        entry.stroke.Color = borderSoft
        entry.row.BackgroundColor3 = (entry.order % 2 == 0) and COLORS.rowBgAlt or COLORS.rowBg
    end

    -- Activate buttons
    for _, entry in ipairs(trackedButtons) do
        entry.btn.BackgroundColor3 = accent
        entry.btn.TextColor3 = contrastText
        entry.btn.UIStroke.Color = border
    end

    -- Scrollbar
    scroll.ScrollBarImageColor3 = border

    -- Store contrast for active tab text
    _G.__ActiveTabTextColor = contrastText
end

-- =========================================================
-- SHADER ROWS
-- =========================================================
local shaderItems = {
    { name = "CINEMATIC BLOOM",  fn = function() print("[BEE HUB] Cinematic Bloom activated") end },
    { name = "VIBRANT COLOR",    fn = function() print("[BEE HUB] Vibrant Color activated") end },
    { name = "RETRO / SEPIA",    fn = function() print("[BEE HUB] Retro / Sepia activated") end },
    { name = "DEEP NIGHTS",      fn = function() print("[BEE HUB] Deep Nights activated") end },
    { name = "SOFT BLUR",        fn = function() print("[BEE HUB] Soft Blur activated") end },
    { name = "SUN GLOW",         fn = function() print("[BEE HUB] Sun Glow activated") end },
    { name = "FILM GRAIN",       fn = function() print("[BEE HUB] Film Grain activated") end },
    { name = "CHROMATIC ABERRATION", fn = function() print("[BEE HUB] Chromatic Aberration activated") end },
}

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
    for i, item in ipairs(shaderItems) do
        createRow(item.name, i, item.fn)
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
            print("[BEE HUB] Theme changed to " .. capturedTheme.name)
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
                print("[BEE HUB] " .. name .. " activated on " .. tabName)
            end)
        end
    end
end

-- =========================================================
-- TAB CLICKS
-- =========================================================
for _, t in ipairs(tabs) do
    t.MouseButton1Click:Connect(function()
        setActiveTab(t)
        activeTab = t
        buildList(t.Name:gsub("Tab$", ""))
    end)
end

-- =========================================================
-- HEADER BUTTONS
-- =========================================================
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

minBtn.MouseButton1Click:Connect(function()
    local visible = listContainer.Visible
    listContainer.Visible = not visible
    window.Size = visible and UDim2.new(0, 620, 0, 130) or UDim2.new(0, 620, 0, 460)
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
-- INITIAL BUILD
-- =========================================================
setActiveTab(activeTab)
buildList("SHADER")

print("[BEE HUB 🐝🍯] GUI loaded. Go to SETTINGS to change theme.")