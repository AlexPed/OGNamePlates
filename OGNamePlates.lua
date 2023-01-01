local addonName = ...

local function colorBorder(unitFrame, r, g, b)
    unitFrame.healthBar.border:SetVertexColor(r, g, b)
end

local function mainColor(unitFrame)
    local unit = unitFrame.unit

    local IsUnitEnemy = UnitIsEnemy(unit, "player")
    local IsUnitFriend = UnitIsFriend(unit, "player")

    if IsUnitEnemy then
        colorBorder(unitFrame, 1, 0, 0)
    end

    if IsUnitFriend then
        colorBorder(unitFrame, 0, 1, 0)
    end

    if UnitIsUnit(unitFrame.unit, "target") then
        colorBorder(unitFrame, 0, 0, 1)
    end
end

local function IsUnitFrameAccessible(namePlate)
    return rawget(namePlate, "UnitFrame") ~= nil
end

local function onEvent(self, event, unit)
    local namePlate = C_NamePlate.GetNamePlateForUnit(unit)

    if UnitIsPlayer(unit) and IsUnitFrameAccessible(namePlate) and (event == 'NAME_PLATE_UNIT_ADDED' or event == 'NAME_PLATE_UNIT_REMOVED') then
        namePlate.UnitFrame.allowBorderColor = true

        mainColor(namePlate.UnitFrame)
    end
end

local function updateHealthBorder(unitFrame)
    if unitFrame.allowBorderColor then
        mainColor(unitFrame)
    end
end

local function HookCompactUnitFrame_UpdateHealthBorder()
    hooksecurefunc('CompactUnitFrame_UpdateHealthBorder', updateHealthBorder)
end

local function InitializeFrame()
    local frame = CreateFrame('Frame')
    frame:RegisterEvent('NAME_PLATE_UNIT_ADDED')
    frame:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
    frame:SetScript('OnEvent', onEvent)
end

InitializeFrame()

HookCompactUnitFrame_UpdateHealthBorder()
