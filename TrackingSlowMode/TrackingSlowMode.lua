local frame = CreateFrame("Frame")
local timer = nil
local player = nil

function TrackingSlowMode_OnLoad(self)
    self:RegisterEvent("CHAT_MSG_CHANNEL")
    frame:SetScript("OnUpdate", function(self, elapsed)
        if timer then
            timer = timer - elapsed
            if timer <= 0 then
                print("Timer has ended ^_^")
                timer = nil
            end
        end
    end)
end

function TrackingSlowMode_OnEvent(self, event, ...)
    if event == "CHAT_MSG_CHANNEL" then      
        if player == nil then
            player = GetUnitName("player")
        end
        if arg2 == player then
            timer = 15
        end
    end
end