-- Monster Tasks by Limos
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local xmsg = {}
 
function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid)  end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid)  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()  npcHandler:onThink()  end
 
local storage = 62003
 
local monsters = {
   ["Trolls"] 			= {storage = 5010, mstorage = 19000, amount = 25, 	exp = 5000, 	items = {{id = 2152, count = 10}}}, -- 20 xp
   ["Orcs"] 			= {storage = 5011, mstorage = 19001, amount = 25, 	exp = 6250, 	items = {{id = 2152, count = 15}}}, -- 25 xp
   ["Rotworms"] 		= {storage = 5012, mstorage = 19002, amount = 50, 	exp = 10000, 	items = {{id = 2152, count = 25}}}, -- 40 xp
   ["Minotaurs"] 		= {storage = 5013, mstorage = 19003, amount = 50, 	exp = 25000, 	items = {{id = 2152, count = 25}}}, -- 50 xp
   ["Amazons"] 			= {storage = 5014, mstorage = 19004, amount = 75, 	exp = 45000, 	items = {{id = 2152, count = 35}}}, -- 60 xp
   ["Ghouls"] 			= {storage = 5015, mstorage = 19005, amount = 75, 	exp = 63750, 	items = {{id = 2152, count = 40}}}, -- 85 xp
   ["Cyclops"] 			= {storage = 5016, mstorage = 19006, amount = 100, 	exp = 150000, 	items = {{id = 2152, count = 50}}}, -- 150 xp
   ["Vampires"]         = {storage = 5017, mstorage = 19007, amount = 100,  exp = 152500,   items = {{id = 2152, count = 50}}}, -- 305 xp
   ["Necromancers"] 	= {storage = 5018, mstorage = 19008, amount = 100, 	exp = 290000, 	items = {{id = 2152, count = 50}}}, -- 580 xp
   ["Dragons"] 			= {storage = 5019, mstorage = 19009, amount = 100, 	exp = 0, 	    items = {{id = 2152, count = 100}}}, -- 700 xp
   ["Giant Spiders"] 	= {storage = 5020, mstorage = 19010, amount = 150, 	exp = 0, 	    items = {{id = 2152, count = 150}}}, -- 900 xp
   ["Dragon Lords"] 	= {storage = 5021, mstorage = 19011, amount = 200, 	exp = 0, 	    items = {{id = 2160, count = 4}}}, -- 2100 xp
   ["Frost Dragons"] 	= {storage = 5022, mstorage = 19012, amount = 200, 	exp = 0,        items = {{id = 2160, count = 4}}}, -- 2100 xp
   ["Hydras"] 			= {storage = 5023, mstorage = 19013, amount = 250, 	exp = 0, 	    items = {{id = 2160, count = 5}}}, -- 2100 xp
   ["Demons"] 			= {storage = 5024, mstorage = 19014, amount = 250, 	exp = 0, 	    items = {{id = 2160, count = 10}}} -- 6000 xp
}
 
 
local function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, ItemType(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = " and "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
     end
     return text
end
 
local function Cptl(f, r)
     return f:upper()..r:lower()
end
 
function creatureSayCallback(cid, type, msg)
 
    local player, cmsg = Player(cid), msg:gsub("(%a)([%w_']*)", Cptl)
    if not npcHandler:isFocused(cid) then
        if msg == "hi" or msg == "hello" then
            npcHandler:addFocus(cid)
            if player:getStorageValue(storage) == -1 then
                local text, n = "",  0
                for k, x in pairs(monsters) do
                    if player:getStorageValue(x.mstorage) < x.amount then
                        n = n + 1
                        text = text .. ", "
                        text = text .. ""..x.amount.." {"..k.."}"
                    end
                end
                if n > 1 then
                    npcHandler:say("I have several {tasks} for you! Just tell me which {monsters} you want to kill!", cid)
                    npcHandler.topic[cid] = 1
                    xmsg[cid] = msg
                elseif n == 1 then
                    npcHandler:say("I have one last task for you"..text..".", cid)
                    npcHandler.topic[cid] = 1
                else
                    npcHandler:say("You already did all tasks, I have nothing for you to do anymore, good job though.", cid)
                end
            elseif player:getStorageValue(storage) == 1 then
                for k, x in pairs(monsters) do
                    if player:getStorageValue(x.storage) == 1 then
                        npcHandler:say("Did you kill "..x.amount.." "..k.."? If you didn't and you dont't want to, you can ask me to {stop}. Also, I can {list} other {tasks} for you.", cid)
                        npcHandler.topic[cid] = 2
                        xmsg[cid] = k
                    end
                end
            end
        else
            return false
        end
    elseif msgcontains(msg, "monsters") or msgcontains(msg, "monster") and npcHandler.topic[cid] == 1 then
       	npcHandler:say("I have {tasks} to kill {trolls}, {orcs}, {rotworms}, {minotaurs}, {amazons}, {ghouls}, {cyclops}, {necromancers}, {dragons}, {giant spiders}, {dragon lords}, {hydras} and {demons}.", cid)

    elseif monsters[cmsg] and npcHandler.topic[cid] == 1 then
        if player:getStorageValue(monsters[cmsg].storage) == -1 then
            npcHandler:say("Good luck, come back when you killed "..monsters[cmsg].amount.." "..cmsg..".", cid)
            player:setStorageValue(storage, 1)
            player:setStorageValue(monsters[cmsg].storage, 1)
        else
            npcHandler:say("You already did the "..cmsg.." mission.", cid)
        end
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 2 then
        local x = monsters[xmsg[cid]]
        if player:getStorageValue(x.mstorage) >= x.amount then
            npcHandler:say("Good job, here is your reward, "..getItemsFromTable(x.items)..".", cid)
            for g = 1, #x.items do
                player:addItem(x.items[g].id, x.items[g].count)
            end
            player:addExperience(x.exp)
            player:setStorageValue(x.storage, 2)
            player:setStorageValue(storage, -1)
            --npcHandler.topic[cid] = 3
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say("You didn't kill them all, you still need to kill "..x.amount -(player:getStorageValue(x.mstorage) + 1).." "..xmsg[cid]..".", cid)
        end
    elseif msgcontains(msg, "task") and npcHandler.topic[cid] == 3 then
        local text, n = "",  0
        for k, x in pairs(monsters) do
            if player:getStorageValue(x.mstorage) < x.amount then
                n = n + 1
                text = text .. (n == 1 and "" or ", ")
                text = text .. "{"..k.."}"
            end
        end
        if text ~= "" then
            local text = ""
	        for k, x in pairs(monsters) do
	            if player:getStorageValue(x.mstorage) < x.amount then
	                text = text .. k .." ["..(player:getStorageValue(x.mstorage) + 1).."/"..x.amount.."]:\n  "..getItemsFromTable(x.items).."\n  "..x.exp.." experience \n\n"
	            else
	                text = text .. k .." ["..x.amount.."/"..x.amount.."]: DONE\n\n"
	            end
	        end
	        player:showTextDialog(1949, "" .. text)
		 	npcHandler:say("I have {tasks} to kill {trolls}, {orcs}, {rotworms}, {minotaurs}, {amazons}, {ghouls}, {cyclops}, {necromancers}, {dragons}, {giant spiders}, {dragon lords}, {hydras} and {demons}.", cid)
        else
            npcHandler:say("You already did all tasks.", cid)
        end
    elseif msgcontains(msg, "no") and npcHandler.topic[cid] == 1 then
        npcHandler:say("Ok then.", cid)
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, "stop") then
        local text, n = "",  0
        for k, x in pairs(monsters) do
            if player:getStorageValue(x.mstorage) < x.amount then
                n = n + 1
                text = text .. (n == 1 and "" or ", ")
                text = text .. "{"..k.."}"
                if player:getStorageValue(x.storage) == 1 then
                     player:setStorageValue(x.storage, -1)
                end
            end
        end
        if player:getStorageValue(storage) == 1 then
            npcHandler:say("Alright, let me know if you want to continue an other task, you can still choose "..text..".", cid)
        else
            npcHandler:say("You didn't start any new task yet, if you want to start one, you can choose "..text..".", cid)
        end
        player:setStorageValue(storage, -1)
        npcHandler.topic[cid] = 1
    elseif msgcontains(msg, "tasks") or msgcontains(msg, "task") or msgcontains(msg, "list") then
        local text = ""
        for k, x in pairs(monsters) do
            if player:getStorageValue(x.mstorage) < x.amount then
                text = text ..k .." ["..(player:getStorageValue(x.mstorage) + 1).."/"..x.amount.."]:\n  "..getItemsFromTable(x.items).."\n  "..x.exp.." experience \n\n"
            else
                text = text .. k .." ["..x.amount.."/"..x.amount.."]: DONE\n\n"
            end
        end
        player:showTextDialog(1949, "" .. text)
	 	npcHandler:say("I have {tasks} to kill {trolls}, {orcs}, {rotworms}, {minotaurs}, {amazons}, {ghouls}, {cyclops}, {necromancers}, {dragons}, {giant spiders}, {dragon lords}, {hydras} and {demons}.", cid)

    elseif msgcontains(msg, "bye") then
        npcHandler:say("Bye.", cid)
        npcHandler:releaseFocus(cid)
    else
        npcHandler:say("What?", cid)
    end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
 