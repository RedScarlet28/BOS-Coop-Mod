------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevel()
	CheckInitLevel_cargo_bay_1()

		InitScriptVariable()
		InitLevelCamp1()
		InitLevel_Island()
		InitLevel_Plain()
		_nBotActive=GetTotalActiveCharacterCount()
		_nBotAlive=GetTotalAliveCharacterCount()

	G_bIsADemo = false

		ConfigMerc()
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: OnMissionBegins :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnMissionBegins()

-------------------------------------------------------------
-- :::::::: CHAMPIONS :::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)

		-- Récupère l'ID du Champion actif pour la zone 1
		_idChampion_1 = GetChampionFromArea(1)

		AssignChampionToPlayer("Champion_Nolan_Patrol")

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
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Ingenieur3"))
		end

		if (_idMerc[1]~=nil) then		
				_idChar_Merc=_idMerc[1]
		end

-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()

	TankTargetEntity(GetTankID("Tank_1"),_idPlayer)
	TankTargetEntity(GetTankID("Tank_2"),_idPlayer)

	IntroCargoBay()
end

	
------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevel()
			TIPSREPAIR()
	--	UpdateLevel_Hangar()
	--	UpdateLevel_Bunker()
		UpdateLevelCamp1()
		UpdateLevel_Island()
		UpdateLevel_Plain()
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

------- WRF
--		_idChar_Ingenieur=GetCharacterID("Char_Ingenieur")
--		_idChar_Merc_1=GetCharacterID("Char_Merc_1")
--		_idChar_Merc_2=GetCharacterID("Char_Merc_2")

------- UAN


		_idChar_UAN_Island_1=GetCharacterID("Char_UAN_Island_1")
		_idChar_UAN_Island_2=GetCharacterID("Char_UAN_Island_2")

-- Déclaration des "Character_AIID"
		_idChar_AI_Global_UAN=GetCharacter_AIID("Char_AI_Global_UAN")


-- Déclaration des "GroupID"

------- WRF	

------- UAN 


				-- Bunker

				-- Island
		_idGrp_UAN_Island_01=GetGroupID("Grp_UAN_Island_01")
		_idGrp_UAN_Island_02=GetGroupID("Grp_UAN_Island_02")
		_idGrp_UAN_Island_03=GetGroupID("Grp_UAN_Island_03")
		_idGrp_UAN_Island_04=GetGroupID("Grp_UAN_Island_04")
		_idGrp_UAN_Island_05=GetGroupID("Grp_UAN_Island_05")
		_idGrp_UAN_Island_06=GetGroupID("Grp_UAN_Island_06")
		_idGrp_UAN_Island_07=GetGroupID("Grp_UAN_Island_07")
--		_idGrp_UAN_Island_08=GetGroupID("Grp_UAN_Island_08")

				-- Plain
	--	_idGrp_UAN_Plain_01=GetGroupID("Grp_UAN_Plain_01")
		_idGrp_UAN_Plain_02=GetGroupID("Grp_UAN_Plain_02")
	--	_idGrp_UAN_Plain_03=GetGroupID("Grp_UAN_Plain_03")
	--	_idGrp_UAN_Plain_04=GetGroupID("Grp_UAN_Plain_04")
	--	_idGrp_UAN_Plain_05=GetGroupID("Grp_UAN_Plain_05")
	--	_idGrp_UAN_Plain_06=GetGroupID("Grp_UAN_Plain_06")
		_idGrp_UAN_Plain_07=GetGroupID("Grp_UAN_Plain_07")
	--	_idGrp_UAN_Plain_08=GetGroupID("Grp_UAN_Plain_08")
		_idGrp_UAN_Plain_10=GetGroupID("Grp_UAN_Plain_10")
		_idGrp_UAN_Plain_14=GetGroupID("Grp_UAN_Plain_14")
		--_idGrp_UAN_Plain_15=GetGroupID("Grp_UAN_Plain_15")

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
		_idAI_O_List_Char_Champion_1=GetAI_Order_ListID("AI_O_List_Char_Champion_1_1")

------- UAN
		_idAI_O_List_Grp_UAN_Plain_02=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_02")
		--_idAI_O_List_Grp_UAN_Plain_03=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_03")
		--_idAI_O_List_Grp_UAN_Plain_04=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_04")
		--_idAI_O_List_Grp_UAN_Plain_05=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_05")
		--_idAI_O_List_Grp_UAN_Plain_06=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_06")
		_idAI_O_List_Grp_UAN_Plain_07=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_07")
		--_idAI_O_List_Grp_UAN_Plain_08=GetAI_Order_ListID("AI_O_List_Grp_UAN_Plain_08")

-- Déclaration des "AI_Order_Use_PathwayID"

-- Déclaration des "AI_Order_Follow"
		_idAI_O_Follow_Player=GetAI_Order_FollowID("AI_O_Follow_Player")
		_idAI_O_Follow_Player1=GetAI_Order_FollowID("AI_O_Follow_Player1")

-- Déclaration des "AI_Order_Goto_Waypoint"
------- WRF
		_idAI_O_GW_Char_Ingenieur_Island_3=GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Ingenieur_1_Island_3")

-- Déclaration des "AI_Order_Exit_ExoskeletonID"
		_idAI_O_Exit_Exo_Ingenieur=GetAI_Order_Exit_ExoskeletonID("AI_O_Exit_Exo_Ingénieur")
		_idAI_O_Exit_Exo_merc=GetAI_Order_Exit_ExoskeletonID("AI_O_Exit_Exo_merc")

end