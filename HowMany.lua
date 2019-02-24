HowMany = {}

HowMany.name = "HowMany"

function HowMany:Initialize()
  EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_LOOT_RECEIVED,HowMany.OnLootReceived)
  d("HowMany Initialized")
end

function HowMany.OnLootReceived(eventCode, lootedBy, itemLink, quantity, itemSound, lootType, isStolen)
  inventoryCount, bankCount, craftBagCount = GetItemLinkStacks(itemLink)
  iCount = ""
  bCount = ""
  cCount = ""
  if inventoryCount > 0 then iCount = zo_strformat("Inventory:<<1>> ",inventoryCount) end
  if bankCount > 0 then bCount = zo_strformat("Bank:<<1>> ",bankCount) end
  if craftBagCount > 0 then cCount = zo_strformat("CraftingBag:<<1>> ",craftBagCount) end
  s = zo_strformat("Looted: <<1>>x <<2>> <<3>><<4>><<5>>", quantity, itemLink, iCount, bCount, cCount)
  CHAT_SYSTEM:AddMessage(s)
end

function HowMany.OnAddOnLoaded(event, addonName)
  d(addonName)
  if addonName == HowMany.name then
    HowMany:Initialize()
  end  
end

EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_ADD_ON_LOADED,HowMany.OnAddOnLoaded)
