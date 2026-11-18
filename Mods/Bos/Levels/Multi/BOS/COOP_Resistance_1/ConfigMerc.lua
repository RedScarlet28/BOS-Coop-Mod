function ConfigMerc()

---------------
-- INGENEERS --
---------------

--[[ Bad ]]--
--	SetIngeneerBad(GetCharacterID("Char_Merc_1"),"Gun_A3","Resistant_Mercenary_01")

--[[ Medium ]]--
	SetIngeneerMedium(GetCharacterID("Char_Merc_1"),"Gun_B1","Resistant_Mercenary_02")

--[[ Good ]]--
	SetIngeneerGood(GetCharacterID("Char_Merc_2"),"Gun_B1","Resistant_Mercenary_02")

---------------
-- PROTECTOR --
---------------

--[[ Bad ]]--
	SetProtectorBad(GetCharacterID("Char_Merc_3"),"Pump_B","Shield_Resistance_Mercenary","Resistant_Mercenary_02")

--[[ Medium ]]--
	SetProtectorMedium(GetCharacterID("Char_Merc_4"),"Pump_B","Shield_Resistance_Mercenary","Resistant_Mercenary_03")

--[[ Good ]]--
	--SetProtectorGood(GetCharacterID("Char_Merc_3"),"Pump_A","Shield_Light_Mercenary","Heavy_Mercenary_02")

--------------
-- TROOPERS --
--------------

--[[ Bad ]]--
	SetTrooperBad(GetCharacterID("Char_Resist_Huber"),"Assault_B2","Hubert")
--[[ Medium ]]--
	SetTrooperMedium(GetCharacterID("Char_Merc_5"),"Assault_B1","Resistant_Mercenary_02")
--[[ Good ]]--
	SetTrooperGood(GetCharacterID("Char_Merc_6"),"Assault_B3","Resistant_Mercenary_03")

--------------
-- SNIPERS --
--------------

--[[ Bad ]]--
	--SetSniperBad(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")
--[[ Medium ]]--
	SetSniperMedium(GetCharacterID("Char_Merc_7"),"Sniper_Rifle_A1","Resistant_Mercenary_01")
--[[ Good ]]--
	SetSniperGood(GetCharacterID("Char_Merc_8"),"Sniper_Rifle_A2","Resistant_Mercenary_02")

end