local function isChatWrongFaction(msg)
  if msg and msg == ERR_CHAT_WRONG_FACTION then
    return true
  end
  
  return false
end

local frame = CreateFrame("Frame", "MuteChatWrongFactionFrame")

-- Fires immediately before PLAYER_ENTERING_WORLD on login and UI reload
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, e)
  local event = e or event
  
  if event == "PLAYER_LOGIN" then
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", isChatWrongFaction)
    DEFAULT_CHAT_FRAME:AddMessage("|cff209ff9MuteChatWrongFaction|r: Loaded.")
  end
  
  frame:UnregisterEvent("PLAYER_LOGIN")
end)
