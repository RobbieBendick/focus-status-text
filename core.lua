local _, core = ...;

-- make our own status text
local resourceTextFrame = CreateFrame("FRAME")
resourceTextFrame.text = resourceTextFrame:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
resourceTextFrame.text:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)

-- hook the mana bar to show our own status text
FocusFrameManaBar:HookScript("OnValueChanged", function(self)
    if GetCVar("statusTextDisplay") ~= "NONE" then return end
    local _, powerType = UnitPowerType(self.unit);
    local mana, maxMana = UnitPower(self.unit), UnitPowerMax(self.unit);
    if powerType ~= "MANA" then
        resourceTextFrame.text:SetText(mana .. "/" .. maxMana)
        resourceTextFrame.text:Show()
    else
        resourceTextFrame.text:Hide()
    end
end);

-- hide our own status text when status text is displayed
local frame = CreateFrame("FRAME")
frame:RegisterEvent("CVAR_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "CVAR_UPDATE" then
        local cvar, value = ...;
        if cvar == "STATUS_TEXT_DISPLAY" then
            if value == "NONE" then
                resourceTextFrame.text:Show()
            else
                resourceTextFrame.text:Hide()
            end
        end
    end
end)

-- hide our own status text when entering the world
resourceTextFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
resourceTextFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        resourceTextFrame.text:Hide();
    end
end)
