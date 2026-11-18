function ConfigMerc()

---------------
-- INGENEERS --
---------------

--[[ Bad ]]--
	--SetIngeneerBad(GetCharacterID("Char_Merc_0"),"Gun_A2","Mercenary_Engineer")

--[[ Medium ]]--
	--SetIngeneerMedium(GetCharacterID("Char_Merc_1"),"Gun_A2","Light_Mercenary_02")

--[[ Good ]]--
	--SetIngeneerGood(GetCharacterID("Char_Merc_2"),"Gun_A3","Heavy_Mercenary_01")

---------------
-- PROTECTOR --
---------------

--[[ Bad ]]--
	--SetProtectorBad(GetCharacterID("Char_Merc_0"),"Gun_A2","Shield_Light_Mercenary","Heavy_Mercenary_01")

--[[ Medium ]]--
	SetProtectorMedium(GetCharacterID("Char_Merc_1"),"Gun_A1","Shield_Light_Mercenary","Light_Mercenary_01")

--[[ Good ]]--
	--SetProtectorGood(GetCharacterID("Char_Merc_3"),"Pump_A","Shield_Light_Mercenary","Heavy_Mercenary_02")

--------------
-- TROOPERS --
--------------

--[[ Bad ]]--
	SetTrooperBad(GetCharacterID("Char_Merc_0"),"Assault_A1","Light_Mercenary_01")
--[[ Medium ]]--
	--SetTrooperMedium(GetCharacterID("Char_Merc_4"),"Assault_A1","Light_Mercenary_03")
--[[ Good ]]--
	SetTrooperGood(GetCharacterID("Char_Merc_2"),"Assault_A1","Light_Mercenary_02")

--------------
-- SNIPERS --
--------------

--[[ Bad ]]--
	--SetSniperBad(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")
--[[ Medium ]]--
	--SetSniperMedium(GetCharacterID("Char_Merc_5"),"Rifle_A1","Light_Mercenary_02")
--[[ Good ]]--
	SetSniperGood(GetCharacterID("Char_Merc_3"),"Rifle_A1","Light_Mercenary_02")

end