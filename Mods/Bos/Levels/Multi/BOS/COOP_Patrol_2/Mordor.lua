------------------------------------------------------------
------------------------------------------------------------

-- ::: Init & Update :::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ InitLevel Mordor --]]

function InitLevel_Mordor()
	_bCtrl_SE_Mordor_Cine_1 = true
	_bCtrl_SE_LZ_Mordor_2 = false
	_bExp_Mordor_Turtle_1 = false
	_bPlayerIsInSE_LZ_Mordor_2 = false
	_bCtrl_SE_LZ_Mordor_3 = false
	_bExp_Grp_UAN_Mordor_04 = false
	_bCtrl_SE_Trigger_Mordor_1 = false
	_bCtrl_SE_Trigger_Mordor_2 = false
	_bCtrl_SE_Trigger_Mordor_3 = false
	_bCtrl_SE_Trigger_Mordor_4 = false
	_bExp_Grp_UAN_Mordor_02 = false
	_bCtrl_SE_Trigger_Mordor_0 = false
	_bCtrl_SE_Trigger_Mordor_0 = false
	_bExp_Mordor_Turtle_2 = false
	_bCtrl_SE_Trigger_Mordor_5 = false
	_bExp_Grp_UAN_Mordor_06 = false
	_bCtrl_SE_Trigger_Mordor_6 = false
	_bCtrl_SE_Trigger_Mordor_7 = false
	_bCtrl_SE_Trigger_Mordor_8 = false
	_bExp_Grp_UAN_Mordor_08 = false
	_bCtrl_SE_Trigger_Mordor_9 = false
	_bExp_Grp_UAN_Mordor_09 = false
	_bCtrl_SE_Trigger_Mordor_10 = false
	_bCtrl_SE_Trigger_Mordor_11 = false
	_bCtrl_SE_Trigger_Mordor_12 = false
	_bExp_Grp_UAN_Mordor_11 = false
	_bExp_Grp_UAN_Mordor_12 = false
	_bCtrl_SE_Trigger_Mordor_13 = false
	_bCtrl_SE_Trigger_Mordor_14 = false
	_bCtrl_SE_Trigger_Mordor_16 = false
	_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_1 = false
	_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_2 = false
	_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_3 = false
	_nBombPlayer = 1
	nBombardement = 50
	_bOkPluieFolle = true
	_bCtrl_SE_Trigger_Mordor_15 = false
	_bDeblokDoodson = false
	_bCtrl_SE_Trigger_Mordor_17 = false
	if (_idMerc[0] ~= nil) then 
		SetVarValue(GetAI_Order_Forbid_TargetID("AIO_FT_Merc0"),"Target", _idMerc[0])
	end
	if (_idMerc[1] ~= nil) then 
		SetVarValue(GetAI_Order_Forbid_TargetID("AIO_FT_Merc1"),"Target", _idMerc[1])
	end
end

--[[ UpdateLevel Mordor --]]

function UpdateLevel_Mordor()
	DebloquageTurtle_1()

	Change_Bot_behavior("Char_UAN_Mordor_03_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_03_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_04_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_04_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_09_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_09_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_09_Trooper_3",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_10_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_10_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_12_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_12_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_13_Trooper_1",99,99,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_13_Trooper_2",99,99,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_14_Trooper_1",90,60,"AIOL_UAN_Trooper_FA")
	Change_Bot_behavior("Char_UAN_Mordor_14_Trooper_2",90,60,"AIOL_UAN_Trooper_FA")
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Phase 1 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
--------------------------------------------s----------------

-------------------------------------------------------------
-- :::::::: ETAPE 1 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Cinématique Intro Mordor --]]

function OnEnter_SE_Mordor_Cine_1(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Mordor_Cine_1 == false)) then

		-- Lance la cinématique d'intro Mordor
		LaunchCameraTransition(GetCamTransitionID("CamTransition-67"))
		ShowCinematicBlackStripes(true)
		-- Disable les cmd du Player 
		EnableCharacterCommand(_idPlayer,false)

				StartMusic("Sounds//Music//Bos - War theme.wav", false)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()

		-- Active Explosions
		SetVarValue(GetTimerID("Timer_Explosion"),"Active",true)
		-- Désactive l'event box
		_bCtrl_SE_Mordor_Cine_1 = true

		-- Défrise les persos de la première étape de Mordor
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_1"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_00_Trooper_Titilleur_1"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_00_Trooper_Titilleur_2"), false)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_01"), false)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_02"), false)
	end
end

--[[ Expiration Ordre Troopers 1 --]]

function OnEnter_SE_Trigger_Mordor_0(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_0 == false)) then

		_bExp_Grp_UAN_Mordor_02 = true

		_bCtrl_SE_Trigger_Mordor_0 = true
	end
end

function Exp_Grp_UAN_Mordor_02()
	if (_bExp_Grp_UAN_Mordor_02 == true) then
		return true
	else
		return false
	end
end

function Exp_Char_UAN_Mordor_00_Trooper_Titilleur_1()
	if (_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_1 == true) then
		return true
	else
		return false
	end
end


function Exp_Char_UAN_Mordor_00_Trooper_Titilleur_2()
	if (_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_2 == true) then
		return true
	else
		return false
	end
end


function Exp_Char_UAN_Mordor_00_Trooper_Titilleur_3()
	if (_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_3 == true) then
		return true
	else
		return false
	end
end

--[[ Mordor 2 Etape 1 --]]

function OnEnter_SE_Trigger_Mordor_16(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_16 == false)) then

	_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_3 = true

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_16 = true

	end
end

-------------------------------------------------------------
-- :::::::: ETAPE 2 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor Etape 2 --]]

function OnEnter_SE_LZ_Mordor_2(id)
	if ((id == _idPlayer) and (_bCtrl_SE_LZ_Mordor_2 == false)) then

		-- Désactive l'event box
		_bCtrl_SE_LZ_Mordor_2 = true

		-- Défrise les persos de la 2ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_03"), false)

		-- Signale la présence du joueur ds la boite
		_bPlayerIsInSE_LZ_Mordor_2 = true
	end
end

--[[ Débloque Tortue 1 --]]

function DebloquageTurtle_1()

	_nAliveGrp_UAN_Mordor_01 = AliveMembersCount(GetGroupID("Grp_UAN_Mordor_03"))

	if ((_nAliveGrp_UAN_Mordor_01 <= 0) or (_bPlayerIsInSE_LZ_Mordor_2 == true)) then
		_bExp_Mordor_Turtle_1 = true
	end
end

--[[ Expiration Ordre Tortue 1 --]]

function Exp_Mordor_Turtle_1()
	if (_bExp_Mordor_Turtle_1 == true) then
		return true
	else
		return false
	end
end

function OnEnter_SE_Trigger_Mordor_5(id)
	if ((id == GetCharacterID("Char_UAN_Mordor_01_Protector_1")) and (id == GetCharacterID("Char_UAN_Mordor_01_Destroyer_1")) and (_bCtrl_SE_Trigger_Mordor_5 == false)) then

		_bExp_Mordor_Turtle_2 = true

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_5 = true

	end
end

function Exp_Mordor_Turtle_2()
	if (_bExp_Mordor_Turtle_2 == true) then
		return true
	else
		return false
	end
end
-------------------------------------------------------------
-- :::::::: ETAPE 3 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor Etape 3 --]]

function OnEnter_SE_LZ_Mordor_3(id)
	if ((id == _idPlayer) and (_bCtrl_SE_LZ_Mordor_3 == false)) then

		-- Désactive l'event box
		_bCtrl_SE_LZ_Mordor_3 = true

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_04"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_2"), false)


			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()
	end
end

--[[ Mordor Etape 3 --]]

function OnEnter_SE_Trigger_Mordor_1(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_1 == false)) then

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_1 = true

		-- Débloque les membres du Grp_UAN_Mordor_04
		_bExp_Grp_UAN_Mordor_04 = true

	end
end

--[[ Expiration Ordre Tortue 1 --]]

function Exp_Grp_UAN_Mordor_04()
	if (_bExp_Grp_UAN_Mordor_04 == true) then
		return true
	else
		return false
	end
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Phase 2 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

-------------------------------------------------------------
-- :::::::: ETAPE 1 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor 2 Etape 1 --]]

function OnEnter_SE_Trigger_Mordor_2(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_2 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_05"), false)

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_2 = true

	end
end

-------------------------------------------------------------
-- :::::::: ETAPE 2 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor 2 Etape 2 --]]

function OnEnter_SE_Trigger_Mordor_3(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_3 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_06"), false)

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_3 = true

	end
end

function OnEnter_SE_Trigger_Mordor_6(id)
	if ((id == GetCharacterID("Char_UAN_Mordor_06_Protector_1")) and (_bCtrl_SE_Trigger_Mordor_6 == false)) then

		_bExp_Grp_UAN_Mordor_06 = true

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_6 = true

	end
end

--[[ Expiration Ordre Tortue --]]

function Exp_Grp_UAN_Mordor_06()
	if (_bExp_Grp_UAN_Mordor_06 == true) then
		return true
	else
		return false
	end
end

-------------------------------------------------------------
-- :::::::: ETAPE 3 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor 2 Etape 3 --]]

function OnEnter_SE_Trigger_Mordor_4(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_4 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_07"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_00_Trooper_Titilleur_2"), true)
		Freeze(GetCharacterID("Char_UAN_Mordor_00_Trooper_Titilleur_3"), true)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_2"), true)
		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_4 = true

	end
end

-------------------------------------------------------------
-- :::::::: ETAPE 4 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

--[[ Mordor 2 Etape 4 --]]

function OnEnter_SE_Trigger_Mordor_7(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_7 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_08"), false)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_13"), false)

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_7 = true

	end
end

--[[ Expiration Ordre Tortue --]]

function Exp_Grp_UAN_Mordor_08()
	if (_bExp_Grp_UAN_Mordor_08 == true) then
		return true
	else
		return false
	end
end

function OnEnter_SE_Trigger_Mordor_8(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_8 == false)) then

		FreezeAll(GetGroupID("Grp_UAN_Mordor_15"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_00_Trooper_Titilleur_3"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_3"), false)

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_8 = true

	end
end

function OnEnter_SE_Trigger_Mordor_15(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_15 == false)) then

		FreezeAll(GetGroupID("Grp_UAN_Mordor_16"), false)
		_bExp_Char_UAN_Mordor_00_Trooper_Titilleur_2 = true
		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_15 = true

	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Phase 3 :::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

-------------------------------------------------------------
-- :::::::: ETAPE 1 :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_SE_Trigger_Mordor_9(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_9 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_09"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_4"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_5"), false)
		Freeze(GetCharacterID("Char_UAN_Mordor_Sniper_6"), false)
		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_9 = true

	end
end



function OnEnter_SE_Trigger_Mordor_10(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_10 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_10"), false)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_11"), false)


		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_10 = true

	end
end

function OnEnter_SE_Trigger_Mordor_11(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_11 == false)) then

		_bExp_Grp_UAN_Mordor_11 = true

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_11 = true

	end
end

--[[ Expiration Ordre Tortue --]]

function Exp_Grp_UAN_Mordor_11()
	if (_bExp_Grp_UAN_Mordor_11 == true) then
		return true
	else
		return false
	end
end

function OnEnter_SE_Trigger_Mordor_12(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_12 == false)) then

		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_UAN_Mordor_12"), false)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_14"), false)
		CreationTimer(true, true, false, "OpenMordorDoor",6)
		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_12 = true

	end
end

function OnEnter_SE_Trigger_Mordor_13(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_13 == false)) then

		_bExp_Grp_UAN_Mordor_12 = true

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_13 = true

	end
end

--[[ Expiration Ordre Tortue --]]

function Exp_Grp_UAN_Mordor_12()
	if (_bExp_Grp_UAN_Mordor_12 == true) then
		return true
	else
		return false
	end
end

function OpenMordorDoor()
		-- Défrise les persos de la 3ème étape de Mordor
		FreezeAll(GetGroupID("Grp_WRF_Mordor_1"), false)
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_1"), false)
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_2"), false)
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_3"), false)
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_4"), false)
		SetGodMode(GetCharacterID("Char_WRF_Mordor_Doodson"), true)
		SetGodMode(GetCharacterID("Char_WRF_Mordor_DoodGuy_1"), true)
		SetGodMode(GetCharacterID("Char_WRF_Mordor_DoodGuy_2"), true)
		SetGodMode(GetCharacterID("Char_WRF_Mordor_DoodGuy_3"), true)
		SetGodMode(GetCharacterID("Char_WRF_Mordor_DoodGuy_4"), true)
		UnLockDoor(GetDoorID("Door_Doodson"))
		OpenDoor(GetDoorID("Door_Doodson"))
		CreationTimer(true, true, false, "ActiveChar_WRF_Mordor_DoodGuy_1",2)
end

function ActiveChar_WRF_Mordor_DoodGuy_1()
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_1"), true)
		CreationTimer(true, true, false, "ActiveChar_WRF_Mordor_DoodGuy_2",1)
end

function ActiveChar_WRF_Mordor_DoodGuy_2()
		EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_DoodGuy_2"), true)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: End :::::::::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Trigger_Mordor_14(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_14 == false)) then

		--EnableCharacterCommand(GetCharacterID("Char_WRF_Mordor_Doodson"), true)

		Teletransportation("Repere_Player",_idPlayer)
		EnableCharacterCommand(_idPlayer,false)
		CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)

		if (_idMerc[0] ~= nil) then 
			Teletransportation("Repere_Merc_1",_idMerc[0])
			CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL",true,false)
			EnableCharacterCommand(_idMerc[0],false)
		end

		if (_idMerc[1] ~= nil) then 
			Teletransportation("Repere_Merc_2",_idMerc[1])
			EnableCharacterCommand(_idMerc[1],false)
			CharacterPlaySpecialAction(_idMerc[1],"STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL",true,false)
		end

		_idDood2 = GetCharacterID("Char_WRF_Mordor_DoodGuy_2")
		Teletransportation("Repere_Cine_Mordor_1",_idDood2)

		_idDood1 = GetCharacterID("Char_WRF_Mordor_DoodGuy_1")
		Teletransportation("Repere_Cine_Mordor_2",_idDood1)

		SetVarValue(GetCharacterID("Char_WRF_Mordor_DoodGuy_3"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_WRF_Doodson"))
		SetVarValue(GetCharacterID("Char_WRF_Mordor_DoodGuy_4"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_WRF_Doodson"))

		LaunchCameraTransition(GetCamTransitionID("CamTransition_Mordor_End"))
		ShowCinematicBlackStripes(true)

		MakeCharacterSpeak(GetCharacterID("Char_WRF_Mordor_Doodson"),_idPlayer,"DIA_SPE_NIV_D_GENERAL_B_01",true,130,1,2,"MissionOk",0)

		-- Désactive l'event box
		_bCtrl_SE_Trigger_Mordor_14 = true

		FreezeAll(GetGroupID("Grp_UAN_Mordor_14"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_13"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_12"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_11"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_10"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_09"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_08"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_07"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_06"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_05"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_04"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_03"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_02"), true)
		FreezeAll(GetGroupID("Grp_UAN_Mordor_01"), true)


	end
end

function OnEnter_SE_Trigger_Mordor_17(id)
	if ((id == _idPlayer) and (_bCtrl_SE_Trigger_Mordor_17 == false)) then

		_bDeblokDoodson = true

		_bCtrl_SE_Trigger_Mordor_17 = true
	end
end
function DeblokDoodson()
	if (_bDeblokDoodson == true) then
		return true
	else
		return false
	end
end

function CamFinale()
	
	CloseDoor(GetDoorID("Door_Doodson"))
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Mordor_End1"))
	
end

function MissionOk()
	MissionSucceed()
	ShowCinematicBlackStripes(false)
end

