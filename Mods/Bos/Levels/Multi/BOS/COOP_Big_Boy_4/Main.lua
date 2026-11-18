function InitLevel ()
	InitScriptVariable()

	AssignChampionToPlayer( "Champion_Nolan_Big_Boy_0" )

	Debug_GetSelectedMercenaries()
	Debug_GetSelectedChampions()



-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
		_idChampion_1 = GetChampionFromArea(1)

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
		-- Récupère les ID des Mercs actifs : _idMerc[0] et _idMerc[1]
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
		end

	OpenDoor(GetDoorID("Door_05"))

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()

end


function UpdateLevel ()
	UpdateLevel_Grotte ()
	GlobalIngenieurIsDead() 
	GlobalPlayerIsDead()
	UpdateLevel_Suite ()


	if _idChampion_0 == (GetCharacterID("Char_Champion_0_1"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_1")
	end
	if _idChampion_1 == (GetCharacterID("Char_Champion_1_1"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_1,"Plug_MShield_Champion_1_1")
	end

--debug print
--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()

end

function InitScriptVariable()

	_idPlayer															= GetCharacterID("Player")
	_bOnEnter_Sector_Event_Grotte_C_01		= 0
	_bInge_Go_Cave_Door										= 0
	_bCave_Door_Is_Open										= 0
	_bDefreeze_BOS												= 0
	_bDefreeze_Group_Suite_UAN_02 				= 0
	_bOnEnter_Sector_Event_Suite_A_01			= 0		
	_bOnEnter_Sector_Event_Suite_A_02			= 0
	_bOnEnter_Sector_Event_Suite_A_03			= 0
	_bOnEnter_Sector_Event_Suite_A_05			= 0
	_bOnEnter_Sector_Event_Suite_A_04_A		= 0
	_bOnEnter_Sector_Event_Suite_A_04_B		= 0
	_bOnEnter_Sector_Event_Suite_B_00			= 0
	_bInge_Bomb_Big_Boy 									= 0
	_bOnEnter_Sector_Event_Suite_B_01			= 0
	_bOnEnter_Sector_Event_Grotte_E_00		= 0
	_bBigBoyExplo 												= 0
	_bBigBoyExplo_Test										= 0
	_bOnEnter_Sector_Event_Suite_B_02			= 0
  _bBOS_2_DONE													= 0
end



function OnEnter_Sector_Event_0 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			EndOfLevel()
	end
end