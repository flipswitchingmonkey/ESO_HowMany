HowMany = {}
HowMany.name = "HowMany"

function HowMany:Initialize()
  -- SET UP SAVED VARIABLES FOR OFFLINE STORAGE
  self.savedVariables = ZO_SavedVars:New("HowManySavedVariables", 1, nil, {})
  if self.savedVariables.enabled == nil then self.savedVariables.enabled = true end

  -- REGISTER SLASH COMMANDS
  SLASH_COMMANDS["/howmany"] = HowMany.ManageEvent
    
  -- REGISTER EVENTS
  if HowMany.savedVariables.enabled == true then
    EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_LOOT_RECEIVED,HowMany.OnLootReceived)
    d("HowMany Initialized")
  end
end

function HowMany.ManageEvent(param)
  if param == "on" then 
    if HowMany.savedVariables.enabled == false then
      HowMany.savedVariables.enabled = true
      EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_LOOT_RECEIVED,HowMany.OnLootReceived)
      CHAT_SYSTEM:AddMessage("HowMany enabled")
    else
      CHAT_SYSTEM:AddMessage("HowMany is on")
    end
  elseif param == "off" then 
    if HowMany.savedVariables.enabled == true then
      HowMany.savedVariables.enabled = false
      EVENT_MANAGER:UnregisterForEvent(HowMany.name, EVENT_LOOT_RECEIVED)
      CHAT_SYSTEM:AddMessage("HowMany disabled")
    else
      CHAT_SYSTEM:AddMessage("HowMany is off")
    end
  else CHAT_SYSTEM:AddMessage("Valid commands are:\n/howmany on (to turn on HowMany)\n/howmany off (to turn it off)")
  end
end

function HowMany.OnLootReceived(eventCode, lootedBy, itemLink, quantity, itemSound, lootType, isStolen)
  inventoryCount, bankCount, craftBagCount = GetItemLinkStacks(itemLink)
  iCount = ""
  bCount = ""
  cCount = ""
  if inventoryCount > 0 then iCount = zo_strformat("Inventory: <<1>> ",inventoryCount) end
  if bankCount > 0 then bCount = zo_strformat("Bank: <<1>> ",bankCount) end
  if craftBagCount > 0 then cCount = zo_strformat("CraftingBag: <<1>> ",craftBagCount) end
  s = zo_strformat("Looted: <<1>>x <<2>> - <<3>><<4>><<5>>", quantity, itemLink, iCount, bCount, cCount)
  CHAT_SYSTEM:AddMessage(s)
end

function HowMany.OnAddOnLoaded(event, addonName)
  d(addonName)
  if addonName == HowMany.name then
    HowMany:Initialize()
  end  
end

EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_ADD_ON_LOADED,HowMany.OnAddOnLoaded)
