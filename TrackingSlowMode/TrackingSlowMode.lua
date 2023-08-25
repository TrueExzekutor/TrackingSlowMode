local frame = CreateFrame("Frame")
local timer = nil
local player = nil
local timerFrame = nil
local timerText = nil

function TrackingSlowMode_OnLoad(self)
    self:RegisterEvent("CHAT_MSG_CHANNEL")
    frame:SetScript("OnUpdate", function(self, elapsed)
        if timer then
            timer = timer - elapsed
            if timer <= 0 then
                print("Timer has ended ^_^")
                timer = nil
                timerFrame:Hide()
            else
                timerText:SetText(math.ceil(timer))
            end
        end
    end)

    timerFrame = CreateFrame("Frame", nil, ChatFrame1)
    timerFrame:SetSize(20, 20)
    timerFrame:SetPoint("TOPRIGHT", ChatFrame1, "TOPRIGHT")
    timerFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 1, edgeSize = 1,
        })
    timerFrame:SetBackdropColor(0, 0, 0, 1)

    timerText = timerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    timerText:SetPoint("CENTER", timerFrame, "CENTER")
end

function TrackingSlowMode_OnEvent(self, event, ...)
    if event == "CHAT_MSG_CHANNEL" then      
        if player == nil then
            player = GetUnitName("player")
        end
        if arg2 == player then
            timer = 15
            timerFrame:Show()
        end
    end
end