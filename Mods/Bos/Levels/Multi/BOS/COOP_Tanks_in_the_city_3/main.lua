function InitLevel()
	CheckInitLevel_tanks_in_the_city_3()

	InitScriptVariable()

	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
	TankTargetEntity(GetTankID("Tank_01"),_idPlayer)

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
		_idChampion_1 = GetChampionFromArea(1)

		AssignChampionToPlayer( "Champion_Nolan_Tanks_in_the_city_1" )

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


end



function UpdateLevel()

	UpdateLevel_Musee()
	UpdateLevel_End()
	UpdateLevel_Lane()
	ActiveBots()


	
	if ((GetExoskeletonHealth(GetExoskeletonID("Exo_04")) <= 0) 
	or (GetExoskeletonWeakpointHealth(GetExoskeletonID("Exo_04")) <= 0))
	and (_nHealth_Tank	 > 0)
	and (_bHUD_Mission_Failed_04 == 0) then
		MissionFailed ("HUD_MISSION_FAILED_REASON_04")
		_bHUD_Mission_Failed_04 = 1
	end


	Change_Bot_behavior("Char_UAN_End_A_01",50,30,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_End_A_02",60,40,"AI_O_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_End_A_03",60,40,"AI_O_List_Force_Attack_Player")

	if _idChampion_1 == (GetCharacterID("Char_Champion_1_2"))then
		Champion_Stop_Turning_Reloading(_idChampion_1,"AI_O_List_HOTEL_CHAMPION")
	end

	if _idChampion_1 == (GetCharacterID("Char_Champion_1_3"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_1,"Plug_MShield_Champion_1_3")
	end

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()


end




--[[ On initialise toutes les variables globales à un niveau
	(toutes les variables nommées _NomDeVariable) 
	dans cette fonction appelée dans InitLevel() --]]

function InitScriptVariable()
	_idPlayer 																	= GetLocalCharacterID(Player)
	_idExo_01																		= GetExoskeletonID("Exo_01")
	_idExo_02																		= GetExoskeletonID("Exo_02")
	_idExo_03																		= GetExoskeletonID("Exo_03")
	_idTank																			= GetTankID("Tank_01")
	_bHUD_Mission_Failed_04											= 0
	_bOnEnter_Sector_Event_Musee_A_00						= 0
	_bOnEnter_Sector_Event_Musee_B_00						= 0
	_bDefreeze_Group_UAN_Sewer_A								= 0
	_bOnEnter_Sector_Event_Hotel_A_00						= 0
	_bDefreeze_Group_UAN_Sewer_A								= 0
	_bBoS_Done_01																= 0
	_bDefreeze_Defreeze_BOS_01									= 0
	_bOnEnter_Sector_Event_Hotel_A_03						= 0
	_bOnEnter_Sector_Event_End_A_00							= 0
	_bOnEnter_Sector_Event_End_A_01							= 0
	_bDefreeze_Group_UAN_End_C									= 0
	_bDefreeze_Group_UAN_End_D									= 0
	_bObj_A_1																		= 0
	_nSpawnHide																	=	0 --0
	_bExitFromStart 														= 0
	_bDefreeze_Defreeze_BOS_00									= 0
	_bBoS_Done_00																= 0
	_bTestSortiePlayer = false
	_bPresencePlayer1 = false
	_bCtrlTesteVieChar_UAN_Lane_00_1 = false
	_bCtrlTestVieGrp_UAN_Lane_02 = false
	_bCtrlTestVieGrp_UAN_Lane_03 = false
	_bCtrlTestVieGrp_UAN_Lane_04 = false
	_bPlayerEntrepot = false
	_nCtrlNumb = 0
	_nCtrlTestBOS_LaneCanSeePlayer_b = false
	_bCtrlCachette1 = false
	_bCtrlCachette2 = false
	_bCtrlCachette3 = false
	_bCtrlArmor = false
	_bCtrlMortBOS_Lane_a = false
	_bCtrlMortBOS_Lane_b = false
end

