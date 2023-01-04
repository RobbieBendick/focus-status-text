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
