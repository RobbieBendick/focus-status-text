local _, core = ...;

-- make our own status text
local resourceTextFrame = CreateFrame("FRAME");
resourceTextFrame.text = resourceTextFrame:CreateFontString(nil, "OVERLAY", "TextStatusBarText");
resourceTextFrame.text:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0);

-- hide our own status text when status text is displayed
local frame = CreateFrame("FRAME");
frame:RegisterEvent("CVAR_UPDATE");
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "CVAR_UPDATE" then
        local cvar, value = ...;
        if cvar == "STATUS_TEXT_DISPLAY" then
            if value == "NONE" then
                resourceTextFrame.text:Show();
            else
                resourceTextFrame.text:Hide();
            end
        end
    end
end);

-- hide our own status text when entering the world
resourceTextFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
resourceTextFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        resourceTextFrame.text:Hide();
    end
end);

-- hide our own status text when focus frame is hidden
FocusFrame:HookScript("OnHide", function(self) resourceTextFrame.text:Hide() end);

-- show our own status text when focus frame is hidden
FocusFrame:HookScript("OnShow", function(self) resourceTextFrame.text:Show() end);

local statusTextObj = {
    ["RAGE"] = function(self, frame)
        local resource = UnitPower(self.unit);
        if class ~= "WARRIOR" then return end

        if resource > 10 and resource < 15 then
            frame.text:SetText("CANNOT REFLECT");
        elseif resource < 10 then
            frame.text:SetText("CANNOT KICK");
        else
            frame.text:SetText(resource);
        end
    end,
    ["ENERGY"] = function(self, frame)
        local resource = UnitPower(self.unit);
        local class = select(2, UnitClass(self.unit));
        if class ~= "ROGUE" then return end

        if resource < 25 then
            frame.text:SetText("CANNOT KICK");
        else
            frame.text:SetText(resource);
        end
    end,
    ["RUNIC_POWER"] = function(self, unit)
        local resource = UnitPower(self.unit);
        local class = select(2, UnitClass(self.unit));
        if class ~= "DEATHKNIGHT" then return end

        -- if the player has less than 25 energy then show text "CANNOT KICK",
        if resource < 20 then
            resourceTextFrame.text:SetText("CANNOT AMS");
        else
            resourceTextFrame.text:SetText(resource);
        end
    end
}

-- hook the mana bar to show our own status text
FocusFrameManaBar:HookScript("OnValueChanged", function(self)
    if GetCVar("statusTextDisplay") ~= "NONE" then return end
    local _, powerType = UnitPowerType(self.unit);
    local resource = UnitPower(self.unit);
    if powerType ~= "MANA" then
        if statusTextObj[powerType] then
            statusTextObj[powerType](self, resourceTextFrame);
        end
        resourceTextFrame.text:Show();
    else
        resourceTextFrame.text:Hide();
    end
end);
