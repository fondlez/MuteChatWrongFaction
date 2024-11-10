local function getClient()
  local display_version, build_number, build_date, ui_version = GetBuildInfo()
  ui_version = ui_version or 11200
  return ui_version, display_version, build_number, build_date
end

local ui_version = getClient()
local is_tbc = false
if ui_version >= 20000 and ui_version <= 20400 then
  is_tbc = true
end

local function filterChat(msg)
  if msg and msg == ERR_CHAT_WRONG_FACTION then
    return true
  end
  
  return false
end

local isChatWrongFaction
if is_tbc then
  isChatWrongFaction = function(msg)
    return filterChat(msg)
  end
else
  isChatWrongFaction = function(self, event, msg)
    return filterChat(msg)
  end
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
