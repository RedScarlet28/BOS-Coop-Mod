function InitLevel ()
	CheckInitLevel_tanks_in_the_city_2()

	InitScriptVariable()

	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav",true)

	OpenDoor(GetDoorID("Door_01"))

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)

-------------------------------------------------------------z
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




function UpdateLevel ()

	UpdateLevel_Court()
	UpdateLevel_End ()
	UpdateLevel_Sewer()

--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )

	Change_Bot_behavior("Char_Start_UAN_A_05",60,30,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Start_UAN_A_08",80,50,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Start_UAN_A_09",80,50,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Start_UAN_B_01",80,50,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Start_UAN_B_02",80,50,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Start_UAN_C_03",50,50,"AI_O_List_Force_Attack_Player_HIGH")

	Change_Bot_behavior("Char_Court_UAN_A_01",50,30,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_A_01",80,60,"AI_O_List_Goto_Waypoint_Court_A_01")
	Change_Bot_behavior("Char_Court_UAN_A_02",60,40,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_A_03",60,40,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_A_04",60,40,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_A_05",60,40,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_A_06",60,40,"AI_O_List_Force_Attack_Player_HIGH")
	
	Change_Bot_behavior("Char_Court_UAN_B_01",70,60,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_B_02",70,60,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_B_03",70,60,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_B_04",70,60,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Court_UAN_B_05",70,60,"AI_O_List_Force_Attack_Player_HIGH")	

	Change_Bot_behavior("Char_Sewer_UAN_A_01",90,90,"AI_O_List_Goto_Waypoint_Sewer_A_01")
	--Change_Bot_behavior("Char_Sewer_UAN_A_01",20,20,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Sewer_UAN_B_01",70,50,"AI_O_List_Force_Attack_Player_HIGH")
	Change_Bot_behavior("Char_Sewer_UAN_B_02",70,50,"AI_O_List_Force_Attack_Player_HIGH")

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2"))then
		Change_Bot_behavior("Char_Champion_0_2",90,90,"AI_O_List_Goto_Waypoint_Court_C_00")
	end
	if _idChampion_0 == (GetCharacterID("Char_Champion_0_3"))then
		Change_Bot_behavior("Char_Champion_0_3",95,95,"AI_O_List_Goto_Waypoint_Court_C_00")
	end

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()

end


function InitScriptVariable()
	_idPlayer																		= GetCharacterID("Player")
	_idEngineer																	= GetCharacterID("Char_Merc_0")
	_idExo																			= GetExoskeletonID("Exo_01")
	_bOnExit_Sector_Event_Start_A_00						= 0
	_bOnEnter_Sector_Event_Start_B_00						= 0
	_bOnEnter_Sector_Event_Start_C_00						= 0
	_bOnEnter_Sector_Event_Court_A_00						= 0
	_bDefreeze_Group_Court_UAN_B 								= 0
	_bDefreeze_Group_Court_UAN_C 								= 0
	_bOnEnter_OnEnter_Sector_Event_Court_D_00 	= 0
	_bDefreeze_Defreeze_BOS 										= 0 
	_bOnEnter_Sector_Event_Sewer_A_00						= 0
	_bOnEnter_Sector_Event_Sewer_A_01						= 0
	_bTankIsDestroyed														= 0			
	_bOnEnter_Sector_Event_Sewer_B_00						= 0
	_bOnEnter_Sector_Event_End_A_00							= 0
	_bExoChangeBeahavior												= 0
	_bIsGridDestroyed														= 0
	_bOnEnter_Sector_Event_End_B_00							= 0
	_bOnEnter_Sector_Event_End_C_00							= 0
end



