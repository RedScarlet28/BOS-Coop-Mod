function ConfigMerc()

---------------
-- INGENEERS --
---------------

--[[ Bad ]]--
	SetIngeneerBad(GetCharacterID("Char_Merc_0"),"Gun_A3","Light_Mercenary_03")

--[[ Medium ]]--
	SetIngeneerMedium(GetCharacterID("Char_Merc_1"),"Gun_A3","Heavy_Mercenary_01")

--[[ Good ]]--
	SetIngeneerGood(GetCharacterID("Char_Merc_2"),"Gun_A3","Heavy_Mercenary_01")

---------------
-- PROTECTOR --
---------------

--[[ Bad ]]--
	SetProtectorBad(GetCharacterID("Char_Merc_3"),"Gun_A2","Shield_Light_Mercenary","Heavy_Mercenary_01")

--[[ Medium ]]--
	SetProtectorMedium(GetCharacterID("Char_Merc_4"),"Pump_A","Shield_Light_Mercenary","Heavy_Mercenary_02")

--[[ Good ]]--
	--SetProtectorGood(GetCharacterID("Char_Merc_3"),"Pump_A","Shield_Light_Mercenary","Heavy_Mercenary_02")

--------------
-- TROOPERS --
--------------

--[[ Bad ]]--
	SetTrooperBad(GetCharacterID("Char_Merc_5"),"Assault_A2","Light_Mercenary_03")
--[[ Medium ]]--
	SetTrooperMedium(GetCharacterID("Char_Merc_6"),"Assault_A3","Heavy_Mercenary_02")
--[[ Good ]]--
	SetTrooperGood(GetCharacterID("Char_Merc_7"),"Assault_A2","Heavy_Mercenary_01")

--------------
-- SNIPERS --
--------------

--[[ Bad ]]--
	--SetSniperBad(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")
--[[ Medium ]]--
	SetSniperMedium(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")
--[[ Good ]]--
	--SetSniperGood(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")

end