local addonName = ...

local function colorBorder(unitFrame, r, g, b)
    unitFrame.healthBar.border:SetVertexColor(r, g, b)
end

local function onEvent(self, event, unit)
    local namePlate = C_NamePlate.GetNamePlateForUnit(unit)

    if namePlate.UnitFrame and event == 'NAME_PLATE_UNIT_ADDED' or event == 'NAME_PLATE_UNIT_REMOVED' then
        namePlate.UnitFrame.allowBorderColor = true

        if UnitIsUnit(unit, "target") then
            colorBorder(namePlate.UnitFrame, 1, 0, 0)
        else
            colorBorder(namePlate.UnitFrame, 0, 0, 1)
        end


    else
        namePlate.UnitFrame.allowBorderColor = nil
    end

end

local function updateHealthBorder(unitFrame)
    if unitFrame.allowBorderColor then
        if UnitIsUnit(unitFrame.unit, "target") then
            colorBorder(unitFrame, 1, 0, 0)
        else
            colorBorder(unitFrame, 0, 0, 1)
        end
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
