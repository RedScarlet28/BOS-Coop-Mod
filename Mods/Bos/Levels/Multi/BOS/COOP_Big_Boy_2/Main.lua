function InitLevel ()
	CheckInitLevel_big_boy_2()
	
	InitScriptVariable()
	--Engineer_call_Support_04 ()

--	MercActiv()

-- debug freeze debut
--FreezeAll(GetGroupID("Group_Start_UAN_00"), true)

	Debug_GetSelectedMercenaries()
	Debug_GetSelectedChampions()

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)

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






--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()



--DEBUG



end




function UpdateLevel ()

	GlobalPlayerIsDead()
	GlobalIngenieurIsDead()

	UpdateLevel_Start ()
	UpdateLevel_QG ()
	UpdateLevel_Suite ()
	UpdateLevel_Suite_02 ()
	--	MercAlive()

--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )

	Change_Bot_behavior("Char_Suite2_UAN_02_01",80,50,"AI_O_List_Attack_Player")
	Change_Bot_behavior("Char_Suite2_UAN_02_02",80,50,"AI_O_List_Attack_Player")
	Change_Bot_behavior("Char_Suite2_UAN_02_03",80,50,"AI_O_List_Attack_Player")
	Change_Bot_behavior("Char_Start_UAN_14_03",80,50,"AI_O_List_Attack_Player")
	Change_Bot_behavior("Char_QG_UAN_04_02",80,50,"AI_O_List_Attack_Player")


	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3"))then
	
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_3")

	end

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()


end


function InitScriptVariable()

	_idPlayer														= GetCharacterID("Player")
	_idEngineer													= GetCharacterID("Char_Merc_0")
	_Pilote_exo													= GetCharacterID("Char_Suite_Pilote_exo")
	_idExo															= GetExoskeletonID("Exoskeleton_UAN_QG_01")
	_nBombardement 											= 0
	_rRotX_Spot													= -2.95
	_bDefreeze_Group_Start_UAN_02				= 0
	_bOnEnter_Sector_Event_Start_A_01		= 0
	_bDefreeze_Group_Start_UAN_04				= 0
	_bDefreeze_Group_Start_UAN_05				= 0
	_bOnEnter_Sector_Event_Start_B_03		= 0
	_bDefreeze_Group_Start_UAN_10				= 0
	_bOnEnter_Sector_Event_Start_C_01		= 0
	_bDefreeze_Group_Start_UAN_12				= 0
	_bOnEnter_Sector_Event_Start_C_03		= 0
	_bOnEnter_Sector_Event_Start_C_04		= 0
	_bDefreeze_Char_Start_UAN_15_01			= 0
	_bOnEnter_Sector_Event_Start_C_07		= 0
	_bC4_First_Door_Placed							= 0	
	_bOnEnter_Sector_Event_Start_D_01		= 0	
	_bExploxion_In_Corridor							= 0
	_bOnEnter_Sector_Event_QG_B_00			= 0
	_bDefreeze_Group_QG_UAN_03					= 0
	_bDefreeze_Group_QG_UAN_04					= 0
	_bDefreeze_Group_QG_UAN_05					= 0
	_bDefreeze_Group_QG_UAN_06 					= 0
	_bComputer_Hacked										= 0 --debug 0
	_bEngineer_Go_Hacking								= 0
	_bEngineer_Go_Near_System						= 0
	_bOnEnter_Sector_Event_QG_B_06			= 0
	_bOnEnter_Sector_Event_Suite_A_00		= 0
	_bDefreeze_Group_Suite_UAN_03				= 0
	_bDefreeze_Group_Suite_UAN_04				= 0
	_bDefreeze_Group_Suite_UAN_05				= 0	
	_bDefreeze_Group_Suite_UAN_07				= 0
	_bDefreeze_Char_Suite_UAN_06_01			= 0
	_bDefreeze_Exoskeleton_UAN_QG_01		= 0
	_bEngineer_See_Exo									= 0
	_bOnEnter_Sector_Event_Suite2_A_00	= 0
	_bOnEnter_Sector_Event_Suite2_A_01	= 0
	_bOnEnter_Sector_Event_Suite2_A_02	= 0
	_bDefreeze_Defreeze_BOS							= 0
	_bOnEnter_Sector_Event_Suite2_A_03	= 0
	_bOnEnter_Sector_Event_Suite2_A_04	= 0
	_bLast_Group_flee_02 								= 0
	_bLast_Group_flee_03 								= 0
	_bOnEnter_Sector_Event_QG_B_07			= 0	
	_bOnEnter_Sector_Event_Suite2_A_06	= 0

end



