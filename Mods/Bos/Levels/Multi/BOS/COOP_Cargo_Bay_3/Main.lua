function InitLevel()	

	CheckInitLevel_cargo_bay_3()

Precache_Dials()
_idDoor_78=GetDoorID("Door_78")
	OpenDoor(_idDoor_78)
StartMusic("Sounds//Music//Bos - War theme.wav",true)
-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs acqtifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
				_idPasdeListe=GetInvalidEntityID()
				SetVarValue(_idMerc[i],"CharacterOrderList",_idPasdeListe)
		end

--		if(IsEntityInBox(GetLocalCharacterID("Player"),"Sector_Event_Check_Player"))and(_nLife_Exo_UAN_1~=0)then
		--Freeze(_idMerc[0],true)
		--end

-------------------------------------------------------------
-- :::: CHAMPIONS :::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

-- Champion_Grishka_Boryenka ->	Char_Champion_2_1


		-- Récupère l'ID du Champion actif pour la zone 0
		_idChampion_0 = GetChampionFromArea(0)
		_bAlive_idChampion_0=IsAlive(_idChampion_0)

		AssignChampionToPlayer("Champion_Nolan_Cargo_Bay_2")
----------------------------------------------------------------
-- ::::::::::::::::::::::::: --
---------------------------------------------------------------

		_nBotsMorts=0
		_nBotsActifs=GetTotalActiveCharacterCount()
		_idTimer_bomb=GetTimerID("Timer_bomb")

		_nLife_Exo_UAN = GetVarValue(GetExoskeletonID("Exoskeleton_UAN"),"Health")
			PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN.."\n")
		_nLife_Exo_UAN_1 = GetVarValue(GetExoskeletonID("Exoskeleton_UAN_1"),"Health")

		
		_idExoOut=GetExoskeletonID("Exoskeleton_UAN")
		_idExoIN=GetExoskeletonID("Exoskeleton_UAN_1")
	--	_bENGINEER_FROZEN=false
	--	_bI_See_You=true
ActiveTrackingMercs()

InitScriptVariable()

	
-------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires ::::::: --
-------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	_bCtrlIngenieurIsDead = true
end
---------------------------------------------------
function UpdateLevel()
		if (_bCtrlIngenieurIsDead == true) then
			GlobalIngenieurIsDead()
		end
			DesactiveTrackingMercs()

			_nLife_Exo_UAN = GetVarValue(GetExoskeletonID("Exoskeleton_UAN"),"Health")
			PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN.."\n")
			_nLife_Exo_UAN_TUNNEL=GetVarValue(GetExoskeletonID("Exoskeleton_11"),"Health")
			_nLife_Exo_UAN_1 = GetVarValue(GetExoskeletonID("Exoskeleton_UAN_1"),"Health")
			PrintDebug("_nLife_Exo : ".._nLife_Exo_UAN_1.."\n")
			_idHPBodyPlayer=GetVarValue(_idPlayer,"BodyHitPoints")

	if (IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer)) and (AliveMembersCount(GetGroupID("Group_Hangar"))==0))then
		_bIS_IN = true
		_byet_Use_Player_exo=true
				if(_idMerc[1] ~= nil)then
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_use_exo_transport"))
				SetVarValue(_idMerc[1],"ExoskeletonOrderList",_idPasdeListe)
				SetVarValue(_idMerc[1],"ExoskeletonAI",GetExoskeleton_AIID("Exoskeleton_AI_8"))
				SetFollowMercenaryMaxDistPeaceExo(15)
					SetFollowMercenaryMinDistPeaceExo(5)
					SetFollowMercenaryMaxDistCombatExo(15)
					SetFollowMercenaryMinDistCombatExo(5)
				end
	end

	if(_idMerc[1] ~= nil)then
		if (not IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer)))and(IsAValidID(GetCharacterCurrentExoskeleton(_idMerc[1])))then
	-- _bIS_IN = false
			if(_idMerc[1] ~= nil)then
			SetVarValue(_idMerc[1],"ExoskeletonOrderList",GetAI_Order_ListID("AI_Order_List_exit_exo"))
			SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
			end
		end
	end



		BOS()
	--	Vie()
		End()
---------------------------INTRO---------------------

--PRE_ENDofDEMO()

-----------------MODIFS__________
NEW_function_1()
NEW_function_2()
Sortie_Renforts_Chambre_A()
	Unlocked()
	Go_Hack()
	Mort_1st_Exo()
--------------------
		Cam_intro()
		MaVie()
		NotCome_Inge()
		Come_Inge()
DCA_EXPOLO()
		--DoorCabane()
		--Come_EXO()
--------------------------------Tunnel-----------
		Tunnel()
		Objectif_Principal_1()
		Objectif_Principal_2()
		Objective_1_01()
		Objective_1_02()
		Objective_1_03()
	
		Objective_2_01()	
		Objective_2_02()
	
		_nBotsMorts=GetTotalDeadCharacterCount()
		_nBotsActifs=GetTotalActiveCharacterCount()
		Go_Exo()
		--Merc_Sort_Exo()
		--In_Exo()
		--Re_Exo()
--Disable_Merc()
--Loose()
--Combat_BOSS()
--Win()
--Boss()

---------------------------------Outside---------

		Garnison_1()
		Renforts_Tube()
		Garnison_3()
		Garnison_4()
--IngenieurA() 
--------------------------------Camp---------------
	--	Renforts_A()
--------------------------------Batiment-----------

--------------------------------Cargo	-------------

---------------------------------------------------

--------------------------------		---------------
		--Bateau()
--------------------------------		-------------
---DEBUG BOTactiv
   
PrintDebug("Bots Actifs  "..GetTotalActiveCharacterCount().."\n")
PrintDebug("Nb de morts : "..GetTotalDeadCharacterCount().."\n")


if _idChampion_0 == (GetCharacterID("Char_Champion_0_1"))then
		Champion_Shield_Desactivation_Reloading(_idChampion_0,"Plug_MShield_Champion_0_1")
end


end
-----------------------------------------------------
function InitScriptVariable()

	--les acteurs:

	--_bAlive_idChar_Merc_0=IsAlive(_idMerc[0])
	--_bAlive_idChar_Merc_1=IsAlive(_idMerc[1])




_nBotsActifs=GetTotalActiveCharacterCount()

_idPlayer=GetCharacterID("Player")
_idExoskeleton_Player=GetExoskeletonID("Exoskeleton_7")
_idExoskeleton_8=GetExoskeletonID("Exoskeleton_8")
_idTimer_bomb=GetTimerID("Timer_bomb")
_idTimer_obj_debut=GetTimerID("Timer_obj_debut")

_idDoor_78=GetDoorID("Door_78")

_idDoor_bos_1=GetDoorID("Door_bos_1")
_idDoor_bos_2=GetDoorID("Door_bos_2")
_idDoor_bos_3=GetDoorID("Door_bos_3")

_idChar_SYNDICATE_1=GetCharacterID("Char_SYNDICATE_1")
_idChar_SYNDICATE_2=GetCharacterID("Char_SYNDICATE_2")
_idChar_SYNDICATE_3=GetCharacterID("Char_SYNDICATE_3")

---------------------------------Camp-------------------

_idCharacter_test=GetCharacterID("Character_test")
_idDoor_A=GetDoorID("Door_A")
_idDestructible_Object_31=GetDestructible_ObjectID("Destructible_Object_31")
_idChar_UAN_Mirador_B_00_1=GetCharacterID("Char_UAN_Mirador_B_00_1")
_bAlive_idChar_UAN_Mirador_B_00_1=IsAlive(_idChar_UAN_Mirador_B_00_1)

_idChar_UAN_Mirador_B_00_2=GetCharacterID("Char_UAN_Mirador_B_00_2")
_bAlive_idChar_UAN_Mirador_B_00_2=IsAlive(_idChar_UAN_Mirador_B_00_2)

_idChar_UAN_Mirador_A_00_1=GetCharacterID("Char_UAN_Mirador_A_00_1")
_bAlive_idChar_UAN_Mirador_A_00_1=IsAlive(_idChar_UAN_Mirador_A_00_1)

_idChar_UAN_Mirador_A_00_2=GetCharacterID("Char_UAN_Mirador_A_00_2")
_bAlive_idChar_UAN_Mirador_A_00_2=IsAlive(_idChar_UAN_Mirador_A_00_2)

_idChar_UAN_Mirador_C_00_1=GetCharacterID("Char_UAN_Mirador_C_00_1")
_bAlive_idChar_UAN_Mirador_C_00_1=IsAlive(_idChar_UAN_Mirador_C_00_1)

_idChar_UAN_Mirador_C_00_2=GetCharacterID("Char_UAN_Mirador_C_00_2")
_bAlive_idChar_UAN_Mirador_C_00_2=IsAlive(_idChar_UAN_Mirador_C_00_2)

_idChar_UAN_Mirador_D_00_1=GetCharacterID("Char_UAN_Mirador_D_00_1")
_bAlive_idChar_UAN_Mirador_D_00_1=IsAlive(_idChar_UAN_Mirador_D_00_1)

_idChar_UAN_Mirador_D_00_2=GetCharacterID("Char_UAN_Mirador_D_00_2")
_bAlive_idChar_UAN_Mirador_D_00_2=IsAlive(_idChar_UAN_Mirador_D_00_2)


_idChar_UAN_Mirador_E_00_1=GetCharacterID("Char_UAN_Mirador_E_00_1")
_bAlive_idChar_UAN_Mirador_E_00_1=IsAlive(_idChar_UAN_Mirador_E_00_1)

_idChar_UAN_Entrance_00_1=GetCharacterID("Char_UAN_Entrance_00_1")
_bAlive_idChar_UAN_Entrance_00_1=IsAlive(_idChar_UAN_Entrance_00_1)

_idChar_UAN_Entrance_00_2=GetCharacterID("Char_UAN_Entrance_00_2")
_bAlive_idChar_UAN_Entrance_00_2=IsAlive(_idChar_UAN_Entrance_00_2)

_idChar_UAN_Entrance_00_3=GetCharacterID("Char_UAN_Entrance_00_3")
_bAlive_idChar_UAN_Entrance_00_3=IsAlive(_idChar_UAN_Entrance_00_3)

_idChar_UAN_Entrance_00_4=GetCharacterID("Char_UAN_Entrance_00_4")
_bAlive_idChar_UAN_Entrance_00_4=IsAlive(_idChar_UAN_Entrance_00_4)

_idChar_UAN_Entrance_00_5=GetCharacterID("Char_UAN_Entrance_00_5")
_bAlive_idChar_UAN_Entrance_00_5=IsAlive(_idChar_UAN_Entrance_00_5)

_idChar_UAN_Entrance_00_6=GetCharacterID("Char_UAN_Entrance_00_6")
_bAlive_idChar_UAN_Entrance_00_6=IsAlive(_idChar_UAN_Entrance_00_6)


_idChar_UAN_Entrance_00_7=GetCharacterID("Char_UAN_Entrance_00_7")
_bAlive_idChar_UAN_Entrance_00_7=IsAlive(_idChar_UAN_Entrance_00_7)

_idChar_UAN_Entrance_00_8=GetCharacterID("Char_UAN_Entrance_00_8")
_bAlive_idChar_UAN_Entrance_00_8=IsAlive(_idChar_UAN_Entrance_00_8)

_idChar_UAN_Entrance_00_9=GetCharacterID("Char_UAN_Entrance_00_9")
_bAlive_idChar_UAN_Entrance_00_9=IsAlive(_idChar_UAN_Entrance_00_9)

_idChar_UAN_Entrance_00_10=GetCharacterID("Char_UAN_Entrance_00_10")
_bAlive_idChar_UAN_Entrance_00_10=IsAlive(_idChar_UAN_Entrance_00_10)

_idChar_UAN_Entrance_00_11=GetCharacterID("Char_UAN_Entrance_00_11")
_bAlive_idChar_UAN_Entrance_00_11=IsAlive(_idChar_UAN_Entrance_00_11)

_idChar_UAN_Entrance_00_12=GetCharacterID("Char_UAN_Entrance_00_12")
_bAlive_idChar_UAN_Entrance_00_12=IsAlive(_idChar_UAN_Entrance_00_12)

_idChar_UAN_Entrance_00_13=GetCharacterID("Char_UAN_Entrance_00_13")
_bAlive_idChar_UAN_Entrance_00_13=IsAlive(_idChar_UAN_Entrance_00_13)

_idChar_UAN_Entrance_00_14=GetCharacterID("Char_UAN_Entrance_00_14")
_bAlive_idChar_UAN_Entrance_00_14=IsAlive(_idChar_UAN_Entrance_00_14)

_idChar_UAN_Entrance_00_14=GetCharacterID("Char_UAN_Entrance_00_14")
_bAlive_idChar_UAN_Entrance_00_14=IsAlive(_idChar_UAN_Entrance_00_14)

_idChar_UAN_Entrance_00_15=GetCharacterID("Char_UAN_Entrance_00_15")
_bAlive_idChar_UAN_Entrance_00_15=IsAlive(_idChar_UAN_Entrance_00_15)

_idChar_UAN_Entrance_00_16=GetCharacterID("Char_UAN_Entrance_00_16")
_bAlive_idChar_UAN_Entrance_00_16=IsAlive(_idChar_UAN_Entrance_00_16)

_idChar_UAN_Entrance_00_17=GetCharacterID("Char_UAN_Entrance_00_17")

_idChar_UAN_Entrance_00_18=GetCharacterID("Char_UAN_Entrance_00_18")

_idChar_UAN_Entrance_00_19=GetCharacterID("Char_UAN_Entrance_00_19")
_idChar_UAN_Entrance_00_20=GetCharacterID("Char_UAN_Entrance_00_20")
_idChar_UAN_Entrance_00_21=GetCharacterID("Char_UAN_Entrance_00_21")
_idChar_UAN_Entrance_00_22=GetCharacterID("Char_UAN_Entrance_00_22")
_idChar_UAN_Entrance_00_24=GetCharacterID("Char_UAN_Entrance_00_24")
_idChar_UAN_Entrance_00_25=GetCharacterID("Char_UAN_Entrance_00_25")



_idChar_UAN_C1_01_1=GetCharacterID("Char_UAN_C1_01_1")
_bAlive_idChar_UAN_C1_01_1=IsAlive(_idChar_UAN_C1_01_1)

_idChar_UAN_C1_01_2=GetCharacterID("Char_UAN_C1_01_2")
_bAlive_idChar_UAN_C1_01_2=IsAlive(_idChar_UAN_C1_01_2)

_idChar_UAN_C1_01_3=GetCharacterID("Char_UAN_C1_01_3")
_bAlive_idChar_UAN_C1_01_3=IsAlive(_idChar_UAN_C1_01_3)

_idChar_UAN_GdBat_00_1=GetCharacterID("Char_UAN_GdBat_00_1")
_bAlive_idChar_UAN_GdBat_00_1=IsAlive(_idChar_UAN_GdBat_00_1)

_idChar_UAN_GdBat_00_2=GetCharacterID("Char_UAN_GdBat_00_2")
_bAlive_idChar_UAN_GdBat_00_2=IsAlive(_idChar_UAN_GdBat_00_2)

_idChar_UAN_GdBat_00_3=GetCharacterID("Char_UAN_GdBat_00_3")
_bAlive_idChar_UAN_GdBat_00_3=IsAlive(_idChar_UAN_GdBat_00_3)

_idChar_UAN_GdBat_00_4=GetCharacterID("Char_UAN_GdBat_00_4")
_bAlive_idChar_UAN_GdBat_00_4=IsAlive(_idChar_UAN_GdBat_00_4)

_idChar_UAN_GdBat_00_5=GetCharacterID("Char_UAN_GdBat_00_5")
_bAlive_idChar_UAN_GdBat_00_5=IsAlive(_idChar_UAN_GdBat_00_5)

_idChar_UAN_GdBat_00_6=GetCharacterID("Char_UAN_GdBat_00_6")
_bAlive_idChar_UAN_GdBat_00_6=IsAlive(_idChar_UAN_GdBat_00_6)

_idChar_UAN_C1_02_1=GetCharacterID("Char_UAN_C1_02_1")
_bAlive_idChar_UAN_C1_02_1=IsAlive(_idChar_UAN_C1_02_1)

_idChar_UAN_C1_02_2=GetCharacterID("Char_UAN_C1_02_2")
_bAlive_idChar_UAN_C1_02_2=IsAlive(_idChar_UAN_C1_02_2)

_idChar_UAN_C1_02_3=GetCharacterID("Char_UAN_C1_02_3")
_bAlive_idChar_UAN_C1_02_3=IsAlive(_idChar_UAN_C1_02_3)
--------------------

_idChar_UAN_C2_01_1=GetCharacterID("Char_UAN_C2_01_1")
_bAlive_idChar_UAN_C2_01_1=IsAlive(_idChar_UAN_C2_01_1)

_idChar_UAN_C2_01_2=GetCharacterID("Char_UAN_C2_01_2")
_bAlive_idChar_UAN_C2_01_2=IsAlive(_idChar_UAN_C2_01_2)

_idChar_UAN_C2_01_3=GetCharacterID("Char_UAN_C2_01_3")
_bAlive_idChar_UAN_C2_01_3=IsAlive(_idChar_UAN_C2_01_3)

_idChar_UAN_Esplanade_00_1=GetCharacterID("Char_UAN_Esplanade_00_1")
_bAlive_idChar_UAN_Esplanade_00_1=IsAlive(_idChar_UAN_Esplanade_00_1)

_idChar_UAN_Esplanade_00_2=GetCharacterID("Char_UAN_Esplanade_00_2")
_bAlive_idChar_UAN_Esplanade_00_2=IsAlive(_idChar_UAN_Esplanade_00_2)

_idChar_UAN_Esplanade_00_3=GetCharacterID("Char_UAN_Esplanade_00_3")
_bAlive_idChar_UAN_Esplanade_00_3=IsAlive(_idChar_UAN_Esplanade_00_3)

_idChar_UAN_Esplanade_00_4=GetCharacterID("Char_UAN_Esplanade_00_4")
_bAlive_idChar_UAN_Esplanade_00_4=IsAlive(_idChar_UAN_Esplanade_00_4)

_idChar_UAN_Esplanade_01_1=GetCharacterID("Char_UAN_Esplanade_01_1")
_bAlive_idChar_UAN_Esplanade_01_1=IsAlive(_idChar_UAN_Esplanade_01_1)

_idChar_UAN_Esplanade_01_2=GetCharacterID("Char_UAN_Esplanade_01_2")
_bAlive_idChar_UAN_Esplanade_01_2=IsAlive(_idChar_UAN_Esplanade_01_2)

_idChar_UAN_C3_01_1=GetCharacterID("Char_UAN_C3_01_1")
_bAlive_idChar_UAN_C3_01_1=IsAlive(_idChar_UAN_C3_01_1)

_idChar_UAN_C3_01_2=GetCharacterID("Char_UAN_C3_01_2")
_bAlive_idChar_UAN_C3_01_2=IsAlive(_idChar_UAN_C3_01_2)

_idChar_UAN_C3_01_3=GetCharacterID("Char_UAN_C3_01_3")
_bAlive_idChar_UAN_C3_01_3=IsAlive(_idChar_UAN_C3_01_3)

_idChar_UAN_Gd_bat_room1_00_1=GetCharacterID("Char_UAN_Gd_bat_room1_00_1")
_bAlive_idChar_UAN_Gd_bat_room1_00_1=IsAlive(_idChar_UAN_Gd_bat_room1_00_1)

_idChar_UAN_Gd_bat_room1_00_2=GetCharacterID("Char_UAN_Gd_bat_room1_00_2")
_bAlive_idChar_UAN_Gd_bat_room1_00_2=IsAlive(_idChar_UAN_Gd_bat_room1_00_2)
---------------------
_idChar_UAN_Gd_bat_lvl1_renforts_01_1=GetCharacterID("Char_UAN_Gd_bat_lvl1_renforts_01_1")
_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_01_1=IsAlive(_idChar_UAN_Gd_bat_lvl1_renforts_01_1)

_idChar_UAN_Gd_bat_lvl1_renforts_01_2=GetCharacterID("Char_UAN_Gd_bat_lvl1_renforts_01_2")
_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_01_2=IsAlive(_idChar_UAN_Gd_bat_lvl1_renforts_01_2)

_idChar_UAN_Gd_bat_lvl1_renforts_01_3=GetCharacterID("Char_UAN_Gd_bat_lvl1_renforts_01_3")
_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_01_3=IsAlive(_idChar_UAN_Gd_bat_lvl1_renforts_01_3)
----------------------

_idChar_UAN_Gd_bat_lvl2_room1_01_1=GetCharacterID("Char_UAN_Gd_bat_lvl2_room1_01_1")
_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_1=IsAlive(_idChar_UAN_Gd_bat_lvl2_room1_01_1)

_idChar_UAN_Gd_bat_lvl2_room1_01_2=GetCharacterID("Char_UAN_Gd_bat_lvl2_room1_01_2")
_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_2=IsAlive(_idChar_UAN_Gd_bat_lvl2_room1_01_2)

_idChar_UAN_Gd_bat_lvl2_room1_01_5=GetCharacterID("Char_UAN_Gd_bat_lvl2_room1_01_5")
_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_5=IsAlive(_idChar_UAN_Gd_bat_lvl2_room1_01_5)
---------------------

_idChar_UAN_Gd_bat_lvl2_room2_02_1=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_1")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_1=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_1)

_idChar_UAN_Gd_bat_lvl2_room2_02_2=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_2")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_2=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_2)

_idChar_UAN_Gd_bat_lvl2_room2_02_3=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_3")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_3=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_3)

_idChar_UAN_Gd_bat_lvl2_room2_02_4=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_4")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_4=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_4)

_idChar_UAN_Gd_bat_lvl2_room2_02_6=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_6")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_6=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_6)

_idChar_UAN_Gd_bat_lvl2_room2_02_7=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_7")

_idChar_UAN_Gd_bat_lvl2_room2_02_5=GetCharacterID("Char_UAN_Gd_bat_lvl2_room2_02_5")
_bAlive_idChar_UAN_Gd_bat_lvl2_room2_02_5=IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_5)
----------------------
_idChar_UAN_Gd_bat_lvl2_room1_01_2=GetCharacterID("Char_UAN_Gd_bat_lvl2_room1_01_2")
_idChar_UAN_Gd_bat_lvl2_room1_01_4=GetCharacterID("Char_UAN_Gd_bat_lvl2_room1_01_4")
------------------------

_idChar_UAN_Renforts_bat2_01_1=GetCharacterID("Char_UAN_Renforts_bat2_01_1")
_bAlive_idChar_UAN_Renforts_bat2_01_1=IsAlive(_idChar_UAN_Renforts_bat2_01_1)

_idChar_UAN_Renforts_bat2_01_2=GetCharacterID("Char_UAN_Renforts_bat2_01_2")
_bAlive_idChar_UAN_Renforts_bat2_01_2=IsAlive(_idChar_UAN_Renforts_bat2_01_2)

_idChar_UAN_Renforts_bat2_01_5=GetCharacterID("Char_UAN_Renforts_bat2_01_5")
_bAlive_idChar_UAN_Renforts_bat2_01_5=IsAlive(_idChar_UAN_Renforts_bat2_01_5)

_idGroup_UAN_Renforts_bat2=GetGroupID("Group_UAN_Renforts_bat2")
_bAlive_idGroup_UAN_Renforts_bat2=IsAlive(_idGroup_UAN_Renforts_bat2)
--------------------------
_idChar_UAN_Garnison_00_1=GetCharacterID("Char_UAN_Garnison_00_1")
_idChar_UAN_Pass_1_00_1=GetCharacterID("Char_UAN_Pass_1_00_1")
_idChar_UAN_Pass_2_00_1=GetCharacterID("Char_UAN_Pass_2_00_1")
_idChar_UAN_Pass_2_00_2=GetCharacterID("Char_UAN_Pass_2_00_2")
_idChar_UAN_Pass_2_00_3=GetCharacterID("Char_UAN_Pass_2_00_3")
_idChar_UAN_Pass_2_00_4=GetCharacterID("Char_UAN_Pass_2_00_4")


_idChar_UAN_Garnison_04_1=GetCharacterID("Char_UAN_Garnison_04_1")
_idChar_UAN_Garnison_04_2=GetCharacterID("Char_UAN_Garnison_04_2")
-------------------------------------------------------------
_idGroup_UAN_Garnison_00=GetGroupID("Group_UAN_Garnison_00")
_bAlive_idGroup_UAN_Garnison_00=IsAlive(_idGroup_UAN_Garnison_00)
_bFroze_idGroup_UAN_Garnison_00=IsFrozen(_idGroup_UAN_Garnison_00)


_idGroup_UAN_Garnison_01=GetGroupID("Group_UAN_Garnison_01")
_bAlive_idGroup_UAN_Garnison_01=IsAlive(_idGroup_UAN_Garnison_01)
_bFroze_idGroup_UAN_Garnison_01=IsFrozen(_idGroup_UAN_Garnison_01)


_idGroup_UAN_Garnison_02=GetGroupID("Group_UAN_Garnison_02")
_bAlive_idGroup_UAN_Garnison_02=IsAlive(_idGroup_UAN_Garnison_02)
_bFroze_idGroup_UAN_Garnison_02=IsFrozen(_idGroup_UAN_Garnison_02)


_idGroup_UAN_Garnison_03=GetGroupID("Group_UAN_Garnison_03")
_bAlive_idGroup_UAN_Garnison_03=IsAlive(_idGroup_UAN_Garnison_03)
_bFroze_idGroup_UAN_Garnison_03=IsFrozen(_idGroup_UAN_Garnison_03)


_idGroup_UAN_Garnison_04=GetGroupID("Group_UAN_Garnison_04")
_bAlive_idGroup_UAN_Garnison_04=IsAlive(_idGroup_UAN_Garnison_04)
_bFroze_idGroup_UAN_Garnison_04=IsFrozen(_idGroup_UAN_Garnison_04)


_idGroup_UAN_Garnison_05=GetGroupID("Group_UAN_Garnison_05")
_bAlive_idGroup_UAN_Garnison_05=IsAlive(_idGroup_UAN_Garnison_05)
_bFroze_idGroup_UAN_Garnison_05=IsFrozen(_idGroup_UAN_Garnison_05)


_idGroup_UAN_Garnison_06=GetGroupID("Group_UAN_Garnison_06")
_bAlive_idGroup_UAN_Garnison_06=IsAlive(_idGroup_UAN_Garnison_06)
_bFroze_idGroup_UAN_Garnison_06=IsFrozen(_idGroup_UAN_Garnison_06)

_idChar_UAN_Pass_2_00_5=GetCharacterID("Char_UAN_Pass_2_00_5")
_idChar_UAN_Pass_2_00_6=GetCharacterID("Char_UAN_Pass_2_00_6")

_idGroup_TURTLE=GetGroupID("Group_TURTLE")
-------------------------------------------------------------

_idChar_UAN_Cargo_lvl1_01_1=GetCharacterID("Char_UAN_Cargo_lvl1_01_1")
_idChar_UAN_Cargo_lvl1_01_2=GetCharacterID("Char_UAN_Cargo_lvl1_01_2")
_idChar_UAN_Cargo_lvl1_01_3=GetCharacterID("Char_UAN_Cargo_lvl1_01_3")
_idChar_UAN_Cargo_lvl1_01_4=GetCharacterID("Char_UAN_Cargo_lvl1_01_4")
_idChar_UAN_Cargo_lvl1_01_5=GetCharacterID("Char_UAN_Cargo_lvl1_01_5")
_idChar_UAN_Cargo_lvl1_01_6=GetCharacterID("Char_UAN_Cargo_lvl1_01_6")

_idChar_UAN_Cargo_lvl2_01_1=GetCharacterID("Char_UAN_Cargo_lvl2_01_1")

_idChar_UAN_Cargo_lvl2_01_3=GetCharacterID("Char_UAN_Cargo_lvl2_01_3")
_idChar_UAN_Cargo_lvl2_01_4=GetCharacterID("Char_UAN_Cargo_lvl2_01_4")
_idChar_UAN_Cargo_lvl2_01_5=GetCharacterID("Char_UAN_Cargo_lvl2_01_5")

_idChar_UAN_Cargo_lvl3_01_1=GetCharacterID("Char_UAN_Cargo_lvl3_01_1")

_idChar_UAN_Cargo_lvl3_01_3=GetCharacterID("Char_UAN_Cargo_lvl3_01_3")
_idChar_UAN_Cargo_lvl3_01_4=GetCharacterID("Char_UAN_Cargo_lvl3_01_4")
_idChar_UAN_Cargo_lvl3_01_5=GetCharacterID("Char_UAN_Cargo_lvl3_01_5")
----------------------------------------------
_idChar_UAN_EXOMAN_00_1=GetCharacterID("Char_UAN_EXOMAN_00_1")

_idChar_UAN_RESERVE_00_1=GetCharacterID("Char_UAN_RESERVE_00_1")
_idChar_UAN_RESERVE_00_2=GetCharacterID("Char_UAN_RESERVE_00_2")
_idChar_UAN_RESERVE_00_3=GetCharacterID("Char_UAN_RESERVE_00_3")
_idChar_UAN_RESERVE_00_4=GetCharacterID("Char_UAN_RESERVE_00_4")
_idChar_UAN_RESERVE_00_5=GetCharacterID("Char_UAN_RESERVE_00_5")






--___________________________________________________--
_bCam_intro=0
_bMaVie=0
_bMission_OK=0
_bGo_Exo=0
_bOnEnter_Sector_Event_EXO=0
_bOnEnter_Sector_Event_exit_exo=0
_bIn_Exo=0
--_bDialC=0
_bTunnel=0
_bOnEnter_Sector_Event_TUNNEL_1=0
_bOnExit_Sector_Event_TUNNEL_1=0
_bOnEnter_Sector_Event_TUNNEL_2=0
_bOnEnter_Sector_Event_TUNNEL_3=0
_bOnEnter_Sector_Event_TUNNEL_4=0
_bOnStay_Sector_Event_Hangar=0
----------------------OUTSIDE-------------------
_bOnStay_Sector_Event_Alert=0
_bGarnison_1=0
_bCome_EXO=0
_bDialA=0
_bGarnison_3=0
_bGarnison_4=0
_bOnEnter_Sector_Event_Entree_EXT_2=0
_bOnExit_Sector_Event_Entree_EXT_2=0
_bOnEnter_Sector_Event_Entree_EXT_1=0
_bOnExit_Sector_Event_Entree_EXT_1=0
_bIngenieurA=0
_bOnEnter_Sector_Event_exit_exo=0
_bOnEnter_Sector_Event_check_inge=0
_bOnStay_Sector_Event_DEBUT=0
---------------------INSIDE----------------------
_bRenforts_A=0
--_bDoorCabane=0
_bOnExit_Sector_Event_Alert=0
_bOnEnter_Sector_Event_Allee_Camion=0
_bOnExit_Sector_Event_Allee_Camion=0
_bOnEnter_Sector_Event_Entrance_1=0
_bOnEnter_Sector_Event_Entrance_2=0
_bOnEnter_Sector_Event_Entrance_3=0
_bOnEnter_Sector_Event_C3=0
_bOnEnter_Sector_Event_STAGE_1=0
_bOnEnter_Sector_Event_Stair=0
_bOnEnter_Sector_Event_STAGE_4=0
_bOnStay_Sector_Event_STAGE_4=0
_bOnEnter_Sector_Event_Load_C2=0
_bOnEnter_Sector_Event_BARAQUE=0
--_bOnExit_Sector_Event_C3=0
_bBateau=0
_bOnExit_Sector_Event_BUILDING=0
---------------CARGO-----------------
_bOnEnter_Sector_Event_Cargo_Shift=0
_bOnEnter_Sector_Event_Cargo_lvl3=0
_bOnEnter_Sector_Event_Pass2=0
_bOnEnter_Sector_Event_Cargo_lvl1_1=0
_bOnEnter_Sector_Event_Cargo_lvl1_2=0
_bOnEnter_Sector_Event_Cargo_lvl1_3=0
_bOnEnter_Sector_Event_Cargo_lvl1_4=0
_bOnEnter_Sector_Event_Cargo_lvl2_1=0
_bOnEnter_Sector_Event_Cargo_lvl2_2=0
_bOnEnter_Sector_Event_Cargo_lvl2_3=0
_bOnEnter_Sector_Event_Cargo_lvl4=0
_bOnEnter_Sector_Event_bombing_zone=0
_bOnEnter_Sector_Event_SafePlace=0
_bOnEnter_Sector_Event_Ascenseur=0
_bOnEnter_Sector_Event_STAGE_6=0
_bLaunchBOSS=0
_bWin=0
_bOnEnter_Sector_Event_endoflevel=0
----------------BUILDING---------------------------------
_bOnEnter_Sector_Event_Gd_bat_lvl1_room2=0
_bOnEnter_Sector_Event_Gd_bat_lvl1_room1=0
_bOnEnter_Sector_Event_Gd_bat_lvl1_stairs=0
_bOnEnter_Sector_Event_gd_bat_lvl1_couloir=0
_bOnEnter_Sector_Event_Gd_bat_lvl2_couloir=0
_bOnExit_Sector_Event_Gd_bat_lvl2_couloir=0
_bOnEnter_Sector_Event_Gd_bat_lvl2_room2=0
_bLevel_2_room2=0
_bOnEnter_Sector_Event_Renforts_bat=0
_bOnEnter_Sector_Event_Renforts_bat2=0
_bOnExit_Sector_Event_BUILDING=0
_bOnEnter_Sector_Event_Container_1=0
_bOnStay_Sector_Event_PLACE=0
_bOnEnter_Sector_Event_ICEBERG=0
_bOnEnter_Sector_Event_Right=0
------------------------------------
_bObjectif_Principal_1=0
_bObjectif_Principal_2=0

_bObjective_1_01=0
_bObjective_1_02=0
_bObjective_1_03=0

_bObjective_2_01=0
_bObjective_2_02=0
_bVie=0
_bCome_Inge=0
_bNotCome_Inge=0

_bMort_1st_Exo=0
_bNEW_function_2=0
_bEnd=0
_bOnEnter_Sector_Event_BOS=0
_bDisable_Merc=0
_bLoose=0
_bBOS=0
_bCombat_BOSS=0
_bRenforts_Tube=0

_bSortie_Renforts_Chambre_A=0
_bOnEnter_Sector_Event_CHAMBRE_B=0
_bOnEnter_Sector_Event_CHAMBRE_A=0
_bOnExit_Sector_Event_Entrance_3=0
_bNEW_function_1=0
_bOnEnter_Sector_Event_BARAQUE1=0
_bDCA_EXPOLO=0
_bStop_radio=true
_bPRE_ENDofDEMO=0
------------------------------------------------
_bOnExit_Sector_Event_ICEBERG=0
_bOnStay_Sector_Event_KILL_KILL=0
_bGo_Hack=0
_bOnEnter_Sector_Event_hack_1=0
_bOnEnter_Sector_Event_hack_2=0
_bOnExit_Sector_Event_hack_1=0
_bOnExit_Sector_Event_hack_2=0
_bUnlocked=0
_bObj_Hack_ok=0
--_bOnEnter_Sector_Event_Test_Player_Tunnel=0
_bPlayerIsInCargo = 1
---------------------------------------------------

_idGroup_UAN_C1_02=GetGroupID("Group_UAN_C1_02")
-----------------
_idGroup_UAN_C2_01=GetGroupID("Group_UAN_C2_01")
----------------
_idGroup_UAN_Esplanade_01=GetGroupID("Group_UAN_Esplanade_01")
-----------------
_idGroup_UAN_C3_01=GetGroupID("Group_UAN_C3_01")
-----------------
_idGroup_UAN_Gd_bat_lvl2_room1_01=GetGroupID("Group_UAN_Gd_bat_lvl2_room1_01")
--------------------------------------------------
_idChar_UAN_Esplanade_00_2=GetCharacterID("Char_UAN_Esplanade_00_2")
--------------------------------------------------
_idGroup_UAN_Gd_bat_lvl1_renforts_01=GetGroupID("Group_UAN_Gd_bat_lvl1_renforts_01")
---------------------------------------------------
-----------------------------------------------------
_idObjective_Principal_1=GetObjectiveID("Obj_A")
_idObjective_1_01=GetObjectiveID("Obj_A_1")
_idObjective_1_02=GetObjectiveID("Obj_A_2")
_idObjective_1_03=GetObjectiveID("Obj_A_3")

_idObjective_Principal_2=GetObjectiveID("Obj_B")
_idObjective_2_01=GetObjectiveID("Obj_B_1")
_idObjective_2_02=GetObjectiveID("Obj_B_2")
--------------------------------------------------------
end

function Precache_Dials()
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_09")
PrecacheSentence("DIA_SPE_NIV_H_UAN_A_01")
PrecacheSentence("DIA_SPE_NIV_H_UAN_B_01")
PrecacheSentence("DIA_SPE_NIV_H_UAN_F_01")
PrecacheSentence("DIA_GEN_MERCE_STOP_VOICE_A_2")
PrecacheSentence("DIA_GEN_MERCE_STOP_VOICE_A_3")
PrecacheSentence("DIA_SPE_NIV_K_GENERAL_RADIO_08")

PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_26")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_28")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_24")
PrecacheSentence("DIA_SPE_NIV_H_INGENIEUR_27")
end