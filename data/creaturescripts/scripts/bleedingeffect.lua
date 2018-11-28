function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if math.random(1, 100) > 75 then
		local leftItem = attacker:getSlotItem(CONST_SLOT_LEFT)
		local rightItem = attacker:getSlotItem(CONST_SLOT_RIGHT)
		local two_handed_melee = {
		    2377, -- two handed sword
		    2378, -- battle axe
		    2381, -- halberd
		    2387, -- double axe
		    2390, -- magic longsword
		    2391, -- war hammer
		    2393, -- giant sword
		    2401, -- staff
		    2408, -- warlord sword
		    2413, -- broadsword
		    2414, -- dragon lance
		    2415, -- great axe
		    2425, -- obsidian lance
		    2426, -- naginata
		    2427, -- guardian halberd
		    2433, -- enchanted staff
		    2440, -- daramian waraxe
		    2443, -- ravager's axe
		    2444, -- hammer of wrath
		    2447, -- twin axe
		    2452, -- heavy mace
		    2453, -- arcane staff
		    2454, -- war axe
		    2455, -- crossbow
		    2456, -- bow
		    2550, -- scythe
		    3964, -- ripper lance
		    5803, -- arbalest
		    6528, -- the avenger
		    6553, -- ruthless axe
		    7379, -- brutetamer's staff
		    7382, -- demonrage sword
		    7386, -- mercenary sword
		    7391, -- thaian sword
		    7392, -- orcish maul
		    7402, -- dragon slayer
		    7403, -- berserker
		    7405, -- havoc blade
		    7406, -- blacksteel sword
		    7407, -- haunted blade
		    7413, -- titan axe
		    7414, -- abyss hammer
		    7423, -- skullcrusher
		    7424, -- lunar staff
		    7425, -- taurus mace
		    7426, -- amber staff
		    7427, -- chaos mace
		    7428, -- bonebreaker
		    7436, -- angelic axe
		    7449, -- crystal sword
		    7450, -- hammer of prophecy
		    7452, -- spiked squelcher
		    7453, -- executioner
		    7454, -- glorious axe
		    7747, -- fiery blacksteel sword
		    7748, -- fiery dragon slayer
		    7752, -- fiery headchopper
		    7753, -- fiery war axe
		    7757, -- fiery orcish maul
		    7758, -- fiery war hammer
		    7766, -- icy blacksteel sword
		    7767, -- icy dragon slayer
		    7771, -- icy headchopper
		    7772, -- icy war axe
		    7776, -- icy orcish maul
		    7777, -- icy war hammer
		    7857, -- earth blacksteel sword
		    7858, -- earth dragon slayer
		    7862, -- earth headchopper
		    7863, -- earth war axe
		    7867, -- earth orcish maul
		    7868, -- earth war hammer
		    7872, -- energy blacksteel sword
		    7873, -- energy dragon slayer
		    7877, -- energy headchopper
		    7878, -- energy war axe
		    7882, -- energy orcish maul
		    7883, -- energy war hammer
		    8926, -- demonwing axe
		    8929, -- the stomper
		    8932, -- the calamity
		    10301, -- scythe of the reaper
		    10303, -- farmer's avenger
		    11305, -- drakinata
		    11306, -- sai
		    11308, -- drachaku
		    11309, -- twin hooks
		    11323, -- Zaoan halberd
		    12613, -- twiceslicer
		    13838, -- heavy trident
		    13873, -- shimmer bow
		    15400, -- deepling staff
		    15454, -- guardian axe
		    20108, -- pair of iron fists
		    22401, -- crude umbral slayer
		    22402, -- umbral slayer
		    22403, -- umbral master slayer
		    22407, -- crude umbral chopper
		    22408, -- umbral chopper
		    22409, -- umbral master chopper
		    22413, -- crude umbral hammer
		    22414, -- umbral hammer
		    22415 -- umbral master hammer
		}
	 
		local function isItemTwoHanded(itemid)
			return isInArray(two_handed_melee, itemid)
		end

		if leftItem then
			if isItemTwoHanded(leftItem:getId()) then
				local damage = math.floor((attacker:getEffectiveSkillLevel(SKILL_STRENGHT) * 0.2) + 2)
				attacker:addDamageCondition(creature, CONDITION_BLEEDING, DAMAGELIST_CONSTANT_PERIOD, creature:isPlayer() and damage / 4 or damage, 1, 1)
			end
		elseif rightItem then
			if isItemTwoHanded(rightItem:getId()) then
				local damage = math.floor((attacker:getEffectiveSkillLevel(SKILL_STRENGHT) * 0.2) + 2)
				attacker:addDamageCondition(creature, CONDITION_BLEEDING, DAMAGELIST_CONSTANT_PERIOD, creature:isPlayer() and damage / 4 or damage, 1, 1)
			end
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end