function ConfigMerc()

---------------
-- INGENEERS --
---------------

--[[ Bad ]]--
	SetIngeneerBad(GetCharacterID("Char_Merc_0"),"Gun_A3","Heavy_Mercenary_01")

--[[ Medium ]]--
	SetIngeneerMedium(GetCharacterID("Char_Merc_1"),"Gun_B1","Heavy_Mercenary_02")

--[[ Good ]]--
	SetIngeneerGood(GetCharacterID("Char_Merc_2"),"Gun_B1","Heavy_Mercenary_03")

---------------
-- PROTECTOR --
---------------

--[[ Bad ]]--
--	SetProtectorBad(GetCharacterID("Char_Merc_4"),"Gun_A2","Shield_Light_Mercenary","Heavy_Mercenary_01")

--[[ Medium ]]--
	SetProtectorMedium(GetCharacterID("Char_Merc_3"),"Pump_B","Shield_Heavy_Mercenary","Heavy_Mercenary_03")

--[[ Good ]]--
	SetProtectorMedium(GetCharacterID("Char_Merc_4"),"Pump_B","Shield_Heavy_Mercenary","Exo_Mercenary_01")

--------------
-- TROOPERS --
--------------

--[[ Bad ]]--
	SetTrooperBad(GetCharacterID("Char_Merc_5"),"Assault_B1","Exo_Mercenary_01")
--[[ Medium ]]--
--	SetTrooperMedium(GetCharacterID("Char_Merc_7"),"Assault_A3","Heavy_Mercenary_02")
--[[ Good ]]--
	SetTrooperGood(GetCharacterID("Char_Merc_6"),"Assault_B1","Exo_Mercenary_03")

--------------
-- SNIPERS --
--------------

--[[ Bad ]]--
	--SetSniperBad(GetCharacterID("Char_Merc_8"),"Rifle_A3","Heavy_Mercenary_01")
--[[ Medium ]]--
	SetSniperGood(GetCharacterID("Char_Merc_7"),"Sniper_Rifle_A1","Heavy_Mercenary_02")
--[[ Good ]]--
	SetSniperGood(GetCharacterID("Char_Merc_8"),"Sniper_Rifle_A1","Heavy_Mercenary_03")

end