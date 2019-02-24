HowMany = {}

HowMany.name = "HowMany"

function HowMany:Initialize()
  EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_LOOT_RECEIVED,HowMany.OnLootReceived)
  d("HowMany Initialized")
end

function HowMany.OnLootReceived(eventCode, lootedBy, itemLink, quantity, itemSound, lootType, isStolen)
--  d("OnLootReceived")
  inventoryCount, bankCount, craftBagCount = GetItemLinkStacks(itemLink)
  s = zo_strformat("Looted: <<1>>x <<2>> (<<3>>) (I:<<4>> -- B:<<5>> -- C:<<6>>)", quantity, itemLink, GetItemLinkQuality(itemLink), inventoryCount, bankCount, craftBagCount)
  CHAT_SYSTEM:AddMessage(s)
--  d(s)
--  d("Looted: " .. quantity .. "x " .. GetItemLinkName(itemLink) .. "(Quality:" .. GetItemLinkQuality(itemLink) .. ")" ..  "(I:"..inventoryCount.."|B:"..bankCount.."|C:"..craftBagCount..")")
end

function HowMany.OnAddOnLoaded(event, addonName)
  d(addonName)
  if addonName == HowMany.name then
    HowMany:Initialize()
  end  
end

EVENT_MANAGER:RegisterForEvent(HowMany.name,EVENT_ADD_ON_LOADED,HowMany.OnAddOnLoaded)
