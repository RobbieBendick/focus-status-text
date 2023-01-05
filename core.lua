local relatedFrames = {
    ["TargetFrameHealthBar"] = TargetFrameTextureFrame.HealthBarText,
    ["TargetFrameManaBar"] = TargetFrameTextureFrame.ManaBarText,
    ["FocusFrameHealthBar"] = FocusFrameTextureFrame.HealthBarText,
    ["PlayerFrameHealthBar"] = PlayerFrameHealthBarText,
    ["PlayerFrameManaBar"] = PlayerFrameManaBarText,
}

-- set status text to numeric
if GetCVar("statusTextDisplay") ~= "NUMERIC" then
    SetCVar("statusTextDisplay", "NUMERIC")
    print(
        "|cff33ff99FocusFrameText|r: Your status text value has been changed to " ..
        string.lower(GetCVar("statusTextDisplay")) .. "."
    );
end

-- hide status text
for _, v in pairs(relatedFrames) do
    v:SetAlpha(0);
end

local function showText(self)
    for i, v in pairs(relatedFrames) do
        if i == self:GetName() then
            v:SetAlpha(1);
            break;
        end
    end
end

local function hideText(self)
    for i, v in pairs(relatedFrames) do
        if i == self:GetName() then
            v:SetAlpha(0);
            break;
        end
    end
end

-- show health and mana bar text on mouseover
for i in pairs(relatedFrames) do
    _G[i]:HookScript("OnEnter", showText);
    _G[i]:HookScript("OnLeave", hideText);
end

-- check focus frame class
local function checkClass(self)
    if not UnitIsPlayer(self.unit) then return end
    local _, class = UnitClass(self.unit);
    if class ~= "ROGUE" or class ~= "WARRIOR" then
        FocusFrameTextureFrame.ManaBarText:SetAlpha(0);
    else
        FocusFrameTextureFrame.ManaBarText:SetAlpha(1);
    end
end

FocusFrame:HookScript("OnShow", checkClass);
