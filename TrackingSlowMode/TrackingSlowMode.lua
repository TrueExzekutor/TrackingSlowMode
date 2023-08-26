local frame = CreateFrame("Frame")
local timer = nil
local player = nil
local timerFrame = nil
local timerText = nil
local arg3
local arg8
local ProtectFunction = true


function TrackingSlowMode_OnLoad(self)
    self:RegisterEvent("CHAT_MSG_CHANNEL")
    frame:SetScript("OnUpdate", function(self, elapsed)
        if timer ~= nil then
            timer = timer - elapsed
            if timer <= 0 then
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
        arg8 = select(8, ...)
        if player == nil then
            player = GetUnitName("player")
        end
        if arg2 == player then
            timer = 15
            timerFrame:Show()
        end
    end
end

local original_SendChatMessage = SendChatMessage

function SendChatMessage(msg, ...)
    if ProtectFunction then
        arg3 = select(3, ...)
        if timer ~= nil and arg3 == arg8 then
            print("Slow Mode Active")
            return
        end
    end
    original_SendChatMessage(msg, ...)
end

SLASH_TRACKINGSLOWMODE1 = "/TrackingSlowMode"
SLASH_TRACKINGSLOWMODE2 = "/stsm"
SlashCmdList["TRACKINGSLOWMODE"] = function(args)
    if args == "protect on" then
        ProtectFunction = true
        print("ProtectMode enabled")
    elseif args == "protect off" then
        ProtectFunction = false
        print("ProtectMode disabled")
    else
        print("Invalid command. Usage: /stsm /TrackingSlowMode protect [on|off]")
    end
end