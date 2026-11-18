------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	--CheckInitLevel_cargo_bay_2()

		InitScriptVariable()
		InitLevel_Plain()
		InitLevel_ExoHouse()
		OpenDoor(GetDoorID("Door_Ponton_2"))
		_nBotActive=GetTotalActiveCharacterCount()
		_nBotAlive=GetTotalAliveCharacterCount()

-------------------------------------------------------------
-- :::::::: CHAMPIONS :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Aucun Champion dans ce Load

-------------------------------------------------------------
-- :::::::: MERCENAIRES :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs : _idMerc[0] et _idMerc[1]
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
		end

		-- Active l'affichage des Mercs sur la map
		ActiveTrackingMercs()

		if (_idMerc[0]~=nil) then
				_idChar_Ingenieur=_idMerc[0]
	--			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Ingenieur3"))
		end

		if (_idMerc[1]~=nil) then		
				_idChar_Merc=_idMerc[1]
		end

	SetVarValue(GetPickUpID("PickUp-3"),"OwnerID",_idMerc[0])
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()

	TankTargetEntity(GetTankID("Tank_1"),_idPlayer)
	TankTargetEntity(GetTankID("Tank_2"),_idPlayer)
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: OnMissionBegins :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnMissionBegins()

end

	
------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()
		UpdateLevel_Plain()
		UpdateLevel_ExoHouse()
		_nBotActive=GetTotalActiveCharacterCount()
		_nBotAlive=GetTotalAliveCharacterCount()
		PrintDebug("Bots actifs: ".._nBotActive)
		PrintDebug("Bots vivants: ".._nBotAlive)

-----------------------------------------------------------------
-- :::::::: Mission Failed ::::::::::::::::::::::::::::::::::: --
-----------------------------------------------------------------

	GlobalPlayerIsDead()

	GlobalIngenieurIsDead()
	DesactiveTrackingMercs()

end

function InitScriptVariable()

		_idChar_UAN_Plain_14_1 = GetCharacterID("Char_UAN_Plain_14_1")
		_idChar_UAN_Plain_14_2 = GetCharacterID("Char_UAN_Plain_14_2")
		_idChar_UAN_Plain_14_3 = GetCharacterID("Char_UAN_Plain_14_3")

-- Déclaration des "CharacterID"
		_idPlayer=GetLocalCharacterID()

------- UAN

		_idChar_UAN_ExoHouse_1=GetCharacterID("Char_UAN_ExoHouse_1")
		_idChar_UAN_ExoHouse_2=GetCharacterID("Char_UAN_ExoHouse_2")
		_idChar_UAN_ExoHouse_3=GetCharacterID("Char_UAN_ExoHouse_3")
		_idChar_UAN_ExoHouse_4=GetCharacterID("Char_UAN_ExoHouse_4")
	

		_idChar_UAN_ExoHouse_06_2=GetCharacterID("Char_UAN_ExoHouse_06_2")
		_idChar_UAN_ExoHouse_06_1=GetCharacterID("Char_UAN_ExoHouse_06_1")
		_idChar_UAN_ExoHouse_07_2=GetCharacterID("Char_UAN_ExoHouse_07_2")
		_idChar_UAN_ExoHouse_15_1=GetCharacterID("Char_UAN_ExoHouse_15_1")
		_idChar_UAN_ExoHouse_15_2=GetCharacterID("Char_UAN_ExoHouse_15_2")
		_idChar_UAN_ExoHouse_15_3=GetCharacterID("Char_UAN_ExoHouse_15_3")
		_idChar_UAN_ExoHouse_17_1=GetCharacterID("Char_UAN_ExoHouse_17_1")
		_idChar_UAN_ExoHouse_17_2=GetCharacterID("Char_UAN_ExoHouse_17_2")
		_idChar_UAN_ExoHouse_20_1=GetCharacterID("Char_UAN_ExoHouse_20_1")
		_idChar_UAN_ExoHouse_20_2=GetCharacterID("Char_UAN_ExoHouse_20_2")
		_idChar_UAN_ExoHouse_22_1=GetCharacterID("Char_UAN_ExoHouse_22_1")
		_idChar_UAN_ExoHouse_24_1=GetCharacterID("Char_UAN_ExoHouse_24_1")
		_idChar_UAN_ExoHouse_22_2=GetCharacterID("Char_UAN_ExoHouse_22_2")
		_idExo_UAN_ExoHouse_2=GetCharacterID("Char_UAN_ExoHouse_Exo_1")

-- Déclaration des "Character_AIID"
		_idChar_AI_Global_UAN=GetCharacter_AIID("Char_AI_Global_UAN")


-- Déclaration des "GroupID"

				-- Plain
	--	_idGrp_UAN_Plain_01=GetGroupID("Grp_UAN_Plain_01")
		_idGrp_UAN_Plain_02=GetGroupID("Grp_UAN_Plain_02")

		_idGrp_UAN_Plain_09=GetGroupID("Grp_UAN_Plain_09")

		_idGrp_UAN_Plain_11=GetGroupID("Grp_UAN_Plain_11")
		_idGrp_UAN_Plain_12=GetGroupID("Grp_UAN_Plain_12")
		_idGrp_UAN_Plain_13=GetGroupID("Grp_UAN_Plain_13")


				-- ExoHouse
		_idGrp_UAN_ExoHouse_01=GetGroupID("Grp_UAN_Exohouse_01")
		_idGrp_UAN_ExoHouse_02=GetGroupID("Grp_UAN_Exohouse_02")
		_idGrp_UAN_ExoHouse_03=GetGroupID("Grp_UAN_Exohouse_03")
		_idGrp_UAN_ExoHouse_04=GetGroupID("Grp_UAN_Exohouse_04")
		_idGrp_UAN_ExoHouse_05=GetGroupID("Grp_UAN_Exohouse_05")
		_idGrp_UAN_ExoHouse_06=GetGroupID("Grp_UAN_Exohouse_06")
		_idGrp_UAN_ExoHouse_07=GetGroupID("Grp_UAN_Exohouse_07")
		_idGrp_UAN_ExoHouse_08=GetGroupID("Grp_UAN_Exohouse_08")
--		_idGrp_UAN_ExoHouse_09=GetGroupID("Grp_UAN_Exohouse_09")
		_idGrp_UAN_ExoHouse_10=GetGroupID("Grp_UAN_Exohouse_10")
		_idGrp_UAN_ExoHouse_11=GetGroupID("Grp_UAN_Exohouse_11")
		_idGrp_UAN_ExoHouse_12=GetGroupID("Grp_UAN_Exohouse_12")
		_idGrp_UAN_ExoHouse_13=GetGroupID("Grp_UAN_Exohouse_13")
		_idGrp_UAN_ExoHouse_14=GetGroupID("Grp_UAN_Exohouse_14")
		_idGrp_UAN_ExoHouse_15=GetGroupID("Grp_UAN_Exohouse_15")
--		_idGrp_UAN_ExoHouse_16=GetGroupID("Grp_UAN_Exohouse_16")
		_idGrp_UAN_ExoHouse_17=GetGroupID("Grp_UAN_Exohouse_17")
		_idGrp_UAN_ExoHouse_18=GetGroupID("Grp_UAN_Exohouse_18")
		_idGrp_UAN_ExoHouse_19=GetGroupID("Grp_UAN_Exohouse_19")
		_idGrp_UAN_ExoHouse_20=GetGroupID("Grp_UAN_Exohouse_20")
		_idGrp_UAN_ExoHouse_21=GetGroupID("Grp_UAN_Exohouse_21")
		_idGrp_UAN_ExoHouse_22=GetGroupID("Grp_UAN_Exohouse_22")
--		_idGrp_UAN_ExoHouse_23=GetGroupID("Grp_UAN_Exohouse_23")
		_idGrp_UAN_ExoHouse_24=GetGroupID("Grp_UAN_Exohouse_24")


-- Déclaration des "ArsenalID"
------- UAN
		_idArs_Global_UAN_1=GetArsenalID("Ars_Global_UAN_1")
		_idArs_Global_UAN_2=GetArsenalID("Ars_Global_UAN_2")

------- WRF
		_idArs_Typ_Ingenieur=GetArsenalID("Ars_Typ_Ingenieur")


-- Déclaration des "Order_ListID"

------- WRF
		_idAI_O_List_Ingenieur=GetAI_Order_ListID("AI_O_List_Ingenieur")
		_idAI_O_List_Ingenieur1=GetAI_Order_ListID("AI_O_List_Ingenieur1")
		_idAI_O_List_Ingenieur2=GetAI_Order_ListID("AI_O_List_Ingenieur2")


------- UAN
		_idAI_O_List_Grp_UAN_Plain_02=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_02")
		_idAI_O_List_Grp_UAN_Plain_03=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_03")
		_idAI_O_List_Grp_UAN_Plain_04=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_04")
		_idAI_O_List_Grp_UAN_Plain_05=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_05")
		_idAI_O_List_Grp_UAN_Plain_06=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_06")
		_idAI_O_List_Grp_UAN_Plain_07=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_07")
		_idAI_O_List_Grp_UAN_Plain_08=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_08")

-- Déclaration des "AI_Order_Use_PathwayID"

-- Déclaration des "AI_Order_Goto_Waypoint"
------- WRF


-- Déclaration des "AI_Order_Use_ExoskeletonID"

		_idAI_O_Use_Exo_UAN_ExoHouse_1=GetAI_Order_Use_ExoskeletonID("AI_O_Use_Exo_UAN_ExoHouse_1")

-- Déclaration des "AI_Order_Exit_ExoskeletonID"
		_idAI_O_Exit_Exo_Ingenieur=GetAI_Order_Exit_ExoskeletonID("AI_O_Exit_Exo_Ingénieur")
		_idAI_O_Exit_Exo_merc=GetAI_Order_Exit_ExoskeletonID("AI_O_Exit_Exo_merc")

-- Déclaration des "WaypointID"
		_idWaypoint_ExoHouse_T1=GetWaypointID("Waypoint_ExoHouse_T1")
		_idWaypoint_ExoHouse_T2=GetWaypointID("Waypoint_ExoHouse_T2")
		_idWaypoint_ExoHouse_T3=GetWaypointID("Waypoint_ExoHouse_T3")

-- Déclaration des "TimerID"
		_idTimer_ExoHouse_02=GetTimerID("Timer_ExoHouse_02")

-- Déclaration des "ParticleFX_ClientID"
		_idFX_Combustion_ExoHouse_1=GetParticleFX_ClientID("FX_Combustion_ExoHouse_1")
		_idFX_Combustion_ExoHouse_2=GetParticleFX_ClientID("FX_Combustion_ExoHouse_2")
		_idFX_Combustion_ExoHouse_3=GetParticleFX_ClientID("FX_Combustion_ExoHouse_3")
		_idFX_Combustion_ExoHouse_4=GetParticleFX_ClientID("FX_Combustion_ExoHouse_4")
		_idFX_Combustion_ExoHouse_5=GetParticleFX_ClientID("FX_Combustion_ExoHouse_5")
		_idFX_Combustion_ExoHouse_6=GetParticleFX_ClientID("FX_Combustion_ExoHouse_6")
		_idFX_Combustion_ExoHouse_7=GetParticleFX_ClientID("FX_Combustion_ExoHouse_7")
		_idFX_Combustion_ExoHouse_8=GetParticleFX_ClientID("FX_Combustion_ExoHouse_8")
		_idFX_Combustion_ExoHouse_9=GetParticleFX_ClientID("FX_Combustion_ExoHouse_9")
		_idFX_Combustion_ExoHouse_10=GetParticleFX_ClientID("FX_Combustion_ExoHouse_10")
		_idFX_Combustion_ExoHouse_11=GetParticleFX_ClientID("FX_Combustion_ExoHouse_11")

-- Déclaration de positions de "ParticleFX_ClientID"
		_vPos_FX_Combustion_ExoHouse_1=GetVarValue(_idFX_Combustion_ExoHouse_1,"Position")
		_vPos_FX_Combustion_ExoHouse_2=GetVarValue(_idFX_Combustion_ExoHouse_2,"Position")
		_vPos_FX_Combustion_ExoHouse_3=GetVarValue(_idFX_Combustion_ExoHouse_3,"Position")
		_vPos_FX_Combustion_ExoHouse_4=GetVarValue(_idFX_Combustion_ExoHouse_4,"Position")

end