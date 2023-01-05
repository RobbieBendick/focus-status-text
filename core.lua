local relatedFrames = {
    ["TargetFrameHealthBar"] = TargetFrameTextureFrame.HealthBarText,
    ["TargetFrameManaBar"] = TargetFrameTextureFrame.ManaBarText,
    ["FocusFrameHealthBar"] = FocusFrameTextureFrame.HealthBarText,
    ["PlayerFrameHealthBar"] = PlayerFrameHealthBarText,
    ["PlayerFrameManaBar"] = PlayerFrameManaBarText,
}

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

-- show health and mana bar(s) on mouseover
for i, v in pairs(relatedFrames) do
    _G[i]:HookScript("OnEnter", showText);
    _G[i]:HookScript("OnLeave", hideText);
end

-- check focus frame class
local function checkRage(self)
    if not UnitIsPlayer(self.unit) then return end
    local _, class = UnitClass(self.unit);
    if class ~= "ROGUE" or class ~= "WARRIOR" then
        FocusFrameTextureFrame.ManaBarText:SetAlpha(0);
    else
        FocusFrameTextureFrame.ManaBarText:SetAlpha(1);
    end
end

FocusFrame:HookScript("OnShow", checkRage)
