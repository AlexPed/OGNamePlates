local addonName = ...

local function colorBorder(unitFrame)
    unitFrame.healthBar.border:SetVertexColor(0, 0, 1)
end

local function log(message)
    if DLAPI then
        DLAPI.DebugLog(addonName, message)
    end
end

local function onEvent(self, event, unit)
    local namePlate = C_NamePlate.GetNamePlateForUnit(unit)

    if namePlate.UnitFrame then
        if event == 'NAME_PLATE_UNIT_ADDED' or event == 'NAME_PLATE_UNIT_REMOVED' then
            namePlate.UnitFrame.allowBorderColor = true
            colorBorder(namePlate.UnitFrame)
        else
            namePlate.UnitFrame.allowBorderColor = nil
        end
    end
end

local function updateHealthBorder(unitFrame)
    if unitFrame.allowBorderColor then
        colorBorder(unitFrame)
    end
end

hooksecurefunc('CompactUnitFrame_UpdateHealthBorder', updateHealthBorder)

local frame = CreateFrame('Frame')
frame:RegisterEvent('NAME_PLATE_UNIT_ADDED')
frame:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
frame:SetScript('OnEvent', onEvent)


