local function colorBorder(frame)
    frame.healthBar.border:SetVertexColor(0.5, 0.5, 1)
end

local function onEvent(self, event, unit)
    local plate = C_NamePlate.GetNamePlateForUnit(unit)
    if event == 'NAME_PLATE_UNIT_ADDED' then
        plate.UnitFrame.allowBorderColor = true
        colorBorder(plate.UnitFrame)
    else
        plate.UnitFrame.allowBorderColor = nil
    end
end

local function updateHealthBorder(unitFrame)
    if unitFrame.allowBorderColor then
        colorBorder(unitFrame)
    end
end

local handler = CreateFrame('Frame')
handler:RegisterEvent('NAME_PLATE_UNIT_ADDED')
handler:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
handler:SetScript('OnEvent', onEvent)

hooksecurefunc('CompactUnitFrame_UpdateHealthBorder', updateHealthBorder)
