function InitLevel ()
	CheckInitLevel_big_boy_1()
	
	InitScriptVariable()

	AssignChampionToPlayer( "Champion_Nolan_Big_Boy_0" )

	ConfigMerc()
	
end


function OnMissionBegins()

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


--Tracking

		if (_idMerc[0] ~= nil) then
			MiniMapTrack(_idMerc[0], 4, true)
		end


		if (_idMerc[1] ~= nil) then
			MiniMapTrack(_idMerc[1], 4, true)
		end

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()



	Cine_A() ---------------------- ATTENTION-------------------
end



function UpdateLevel ()
	TIPSREPAIR()
	UpdateLevel_Camp ()
	UpdateLevel_Field ()
	Spot ()
--	MissionFailed_BIGBOY()

	Change_Bot_behavior ("Char_Camp_UAN_01_01",80,50,"AI_O_List_Force_Attack_Player")

	if _idChampion_0 == (GetCharacterID("Char_Champion_0_2"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_2")
	end

--debug print
--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	PrintDebug("bots actif = " .. _nBotActifs )
	_nArmor_Merc02 = GetVarValue(GetCharacterID("Char_Merc_1"),"BodyHitPoints")
	PrintDebug("_nArmor_Merc02 = " .. _nArmor_Merc02 )



-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()

end


function InitScriptVariable()

	_idPlayer														= GetCharacterID("Player")
	_idMusic														= GetSound_ClientID("Sound_Music")
	_nBombardement 											= 0
	_bDefreeze_Group_Camp_UAN_01 				= 0
	_bOnEnter_Sector_Event_Camp_A_01		= 0	
	_bOnEnter_Sector_Event_Field_A_00		= 0
	_rRotX_Spot													= -2.95
	_bOnEnter_Sector_Event_Field_B_00		= 0
	_bOnEnter_Sector_Event_Field_C_00		= 0
	_bOnEnter_Sector_Event_Field_D_00		= 0
	_bOnEnter_Sector_Event_Field_E_00		= 0
	_bOnEnter_Sector_Event_Camp_A_02		= 0
	_bOnEnter_Sector_Event_Field_F_00		= 0
	_bDefreeze_Defreeze_BOS							= 0
	_bOnEnter_Sector_Event_Field_B_01		= 0
	_bBoS_Done 													= 0 ---------debug 0		
	_bC4_First_Door_Placed							= 0
	_bOnSector_Event_Field_H_01					= 0
	_bMissionFailed 										= 0
	_bChar_Engineer_Go_See_Door					= 0
	_bOnEnter_Sector_Event_Field_J_00		= 0
	_bPlayerIsNearExplo									= 0
end


function MissionFailed_BIGBOY()
	if _bMissionFailed == 0 then
		if not IsAlive (_idPlayer) then
			MissionFailed ("HUD_MISSION_FAILED_REASON_01")
			_bMissionFailed = 1
		end

		if not IsAlive (_idMerc[0]) then 
			MissionFailed ("HUD_MISSION_FAILED_REASON_02")
			_bMissionFailed = 1		
		end
	end
end

