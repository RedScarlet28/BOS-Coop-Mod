------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelMonastery()
	_bCtrlAliveGrp_Monastery_Syndic_Trooper_1 = false
	_bCtrlSE_Monastery_Trigger_4 = false
	_bCtrlSE_Monastery_Trigger_5 = false
	_bCtrlSE_Monastery_Trigger_1 = false
	_bCtrlSE_Monastery_Trigger_12 = false
	_bCtrlSE_Monastery_Trigger_11 = false
	_bCtrlSE_Monastery_Trigger_10 = false
	_bCtrlSE_Monastery_Trigger_9 = false
	_bCtrlSE_Monastery_Trigger_8 = false
	_bCtrlSE_Monastery_Trigger_7 = false
	_bCtrlSE_Monastery_Trigger_6 = false
	_bCtrlDebloqueCouloir = false
	_bCtrlAliveGrp_Monastery_Syndic_Trooper_7 = false
	_bCtrlAliveGrp_Monastery_Syndic_Trooper_6 = false
	_bPlayerRoof = false
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevelMonastery()
	TrackingCamPoint_Monastery_1_1()
	TrackingCamPoint_Monastery_1_2()
	TrackingCamPoint_Monastery_2_1()
	TrackingCamPoint_Monastery_2_2()
	AliveGrp_Monastery_Syndic_Trooper_1()
	PlayerInSE_Monastery_Trigger_5()
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_10",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_12",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_13",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_14",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_15",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_Monastery_Syndic_Trooper_16",90,60,"AIOL_FA_Player")
	DebloqueCouloir()
	AliveGrp_Monastery_Syndic_Trooper_7()
	AliveGrp_Monastery_Syndic_Trooper_6()
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery Fight1 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Monastery_Trigger_1(id)
	if (id == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",2.0)
		if (_bCtrlSE_Monastery_Trigger_1 == false) then
	--	MissionSucceed ()
		FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_1"),false)
		FreezeAll(GetGroupID("Grp_Monastery_Friend_Trooper_1"),false)
		Freeze(GetCharacterID("Char_Phase1_Friend_Trooper_1"),true)
		Freeze(GetCharacterID("Char_Phase1_Friend_Trooper_2"),true)
		Teletransportation("Char_Repere_Player_Monastery1",_idPlayer)
		EnableCharacterCommand(_idPlayer,false)
		if (_idMerc[0] ~= nil) then
			Teletransportation("Char_Repere_Merc_Monastery1",_idMerc[0])
			EnableCharacterCommand(_idMerc[0],false)
		end
		if (_idMerc[1] ~= nil) then
			Teletransportation("Char_Repere_Merc_Monastery2",_idMerc[1])
			EnableCharacterCommand(_idMerc[1],false)	
		end
		ShowCinematicBlackStripes(true)
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Monastery_1"))
		SetGodMode(GetCharacterID("Char_Monastery_Friend_Trooper_1"),true)
		SetGodMode(GetCharacterID("Char_Monastery_Friend_Trooper_2"),true)
		_bCtrlSE_Monastery_Trigger_1 = true
				StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic(
		end
	end
end

--[[ Ciné Début ]]--

function CamTransition_Monastery_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Monastery_2"))
	UnLockDoor(GetDoorID("Door_Monastery_Floor22"))
	OpenDoor(GetDoorID("Door_Monastery_Floor22"))
	CreationTimer(true, true, false, "AnimsSyndicTroopers",2)
	CreationTimer(true, true, false, "ChangeFAPChar_Monastery_Syndic_Trooper_5",2.5)
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_4b"))
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_5b"))
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_1b"))
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_2b"))
end

function TrackingCamPoint_Monastery_1_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Monastery_1_1"),GetCharacterID("Char_Repere_Door7"))
end

function TrackingCamPoint_Monastery_1_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Monastery_1_2"),GetCharacterID("Char_Repere_Door7"))
end

function TrackingCamPoint_Monastery_2_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Monastery_2_1"),GetCharacterID("Char_Repere_Door7"))
end

function TrackingCamPoint_Monastery_2_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Monastery_2_2"),GetCharacterID("Char_Repere_Door7"))
end

function AnimsSyndicTroopers()
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Monastery_Syndic_Trooper_3"),"Animation","STAND COMPLETE BOS FINGER_SHOW W_ALL_2HAND_LIGHT")
--	CharacterStopSpecialAction(GetCharacterID("Char_Monastery_Syndic_Trooper_2"))
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_2b"))
--	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_3b"))
	SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield3"),"Active",true)
end

function ChangeFAPChar_Monastery_Syndic_Trooper_5()
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_5c"))
end

--[[ Ciné Fin ]]--

function CineMonastery1Fin()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
		if (_idMerc[1] ~= nil) then
	EnableCharacterCommand(_idMerc[0],true)
		end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)	
	end
end

--[[ Fight ]]--

function OnEnter_SE_Monastery_Trigger_2(id)
	if (id == _idPlayer) then
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_1c"))
		SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_2c"))
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.05)
	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery Fight2 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function AliveGrp_Monastery_Syndic_Trooper_1()
	_nAliveGrp_Monastery_Syndic_Trooper_1 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_1"))
	if ((_nAliveGrp_Monastery_Syndic_Trooper_1 == 0) and (IsEntityInBox(_idPlayer,"SE_Monastery_Trigger_3")) and (_bCtrlAliveGrp_Monastery_Syndic_Trooper_1 == false)) then
		
		-- DIA_SPE_NIV_O_RESIS_A_03
		-- Glad to see you again Nolan !
		MakeCharacterSpeak(GetCharacterID("Char_Monastery_Friend_Trooper_2"),_idPlayer,"DIA_SPE_NIV_O_RESIS_A_03",true,100,2,2,"MonasteryFight2",98)
		SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_2e"))
		_bCtrlAliveGrp_Monastery_Syndic_Trooper_1 = true
	end
end

function MonasteryFight2()
	FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_2"),false)
	idExplosion = CreateExplosion()
	SetVarValue(idExplosion,"Position",	Vector3D(1588.676514,-1271.878174,311.222015))
	SetVarValue(idExplosion,"Type","Explosion_Rocket_Bombardement")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")
	ReleaseEntity(GetDoorID("Door_Monastery_Floor4"))
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_1d"))
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_2d"))
	SetGodMode(GetCharacterID("Char_Monastery_Friend_Trooper_1"),false)
	SetGodMode(GetCharacterID("Char_Monastery_Friend_Trooper_2"),false)
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery Fight3 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Monastery_Trigger_4(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_4 == false))then
		FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_3"),false)
		FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_4"),false)
		CreationTimer(true, true, false, "BreakPathGrp_Monastery_Syndic_Trooper_3",15)
		_bCtrlSE_Monastery_Trigger_4 = true
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic(
	end
end

function BreakPathGrp_Monastery_Syndic_Trooper_3()
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

function PlayerInSE_Monastery_Trigger_5()
	if ((IsEntityInBox(_idPlayer,"SE_Monastery_Trigger_5")) and (_bCtrlSE_Monastery_Trigger_5 == false)) then
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_14"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_15"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_16"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		_bCtrlSE_Monastery_Trigger_5 = true
	elseif ((not IsEntityInBox(_idPlayer,"SE_Monastery_Trigger_5")) and (_bCtrlSE_Monastery_Trigger_5 == true)) then
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_14"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_14"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_15"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_15"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_16"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Syndic_Trooper_16"))
		_bCtrlSE_Monastery_Trigger_5 = false
	end
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery Fond ::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Bas ]]--

function OnEnter_SE_Monastery_Trigger_6(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_6 == false))then
		FreezeAll(GetGroupID("Grp_Monastery_Friend_Trooper_3"),false)
		_bCtrlSE_Monastery_Trigger_6 = true
	end
end

function OnEnter_SE_Monastery_Trigger_6b(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_6 == false))then
		FreezeAll(GetGroupID("Grp_Monastery_Friend_Trooper_3"),false)
		_bCtrlSE_Monastery_Trigger_6 = true
	end
end

function OnEnter_SE_Monastery_Trigger_10(id)
	_nAliveGrp_Monastery_Syndic_Trooper_2 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_2"))
	_nAliveGrp_Monastery_Syndic_Trooper_3 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_3"))
	_nAliveGrp_Monastery_Syndic_Trooper_4 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_4"))
	_nTotalAliveGrp_Monastery_Syndic_Trooper_2_3_4 = (_nAliveGrp_Monastery_Syndic_Trooper_2+_nAliveGrp_Monastery_Syndic_Trooper_3+_nAliveGrp_Monastery_Syndic_Trooper_4)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_10 == false))then
		if (_nTotalAliveGrp_Monastery_Syndic_Trooper_2_3_4 == 0) then
			CreationTimer(true, true, false, "SalutChar_Monastery_Friend_Trooper_5",1)
			CreationTimer(true, true, false, "SalutChar_Monastery_Friend_Trooper_6",2)
		else
			SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Follow"))
			SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Follow"))
			SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Follow"))
		end
		_bCtrlSE_Monastery_Trigger_10 = true
	end
end

function SalutChar_Monastery_Friend_Trooper_5()
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_5b"))
end

function SalutChar_Monastery_Friend_Trooper_6()
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_6b"))
end

--[[ Haut ]]--

function OnEnter_SE_Monastery_Trigger_7(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_7 == false))then
		FreezeAll(GetGroupID("Grp_Monastery_Friend_Trooper_3"),false)
		_bCtrlSE_Monastery_Trigger_7 = true
	end
end

function OnEnter_SE_Monastery_Trigger_7b(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_7 == false))then
		FreezeAll(GetGroupID("Grp_Monastery_Friend_Trooper_2"),false)
		_bCtrlSE_Monastery_Trigger_7 = true
	end
end

function OnEnter_SE_Monastery_Trigger_11(id)
	_nAliveGrp_Monastery_Syndic_Trooper_2 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_2"))
	_nAliveGrp_Monastery_Syndic_Trooper_3 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_3"))
	_nAliveGrp_Monastery_Syndic_Trooper_4 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_4"))
	_nTotalAliveGrp_Monastery_Syndic_Trooper_2_3_4 = (_nAliveGrp_Monastery_Syndic_Trooper_2+_nAliveGrp_Monastery_Syndic_Trooper_3+_nAliveGrp_Monastery_Syndic_Trooper_4)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_11 == false))then
		if (_nTotalAliveGrp_Monastery_Syndic_Trooper_2_3_4 == 0) then
			CreationTimer(true, true, false, "SalutChar_Monastery_Friend_Trooper_3",1)
			CreationTimer(true, true, false, "SalutChar_Monastery_Friend_Trooper_4",2)
		end
		_bCtrlSE_Monastery_Trigger_11 = true
	end
end

function SalutChar_Monastery_Friend_Trooper_3()
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_3b"))
end

function SalutChar_Monastery_Friend_Trooper_4()
	SetVarValue(GetCharacterID("Char_Monastery_Friend_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Friend_Trooper_4b"))
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery Couloir :::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Ouverture Porte ]]--

function OnEnter_SE_Monastery_Trigger_8(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_8 == false))then
		if ((_nTotalAliveGrp_Monastery_Syndic_Trooper_2_3_4 == 0) and (_bCtrlSE_Monastery_Trigger_10 == true) and (_bCtrlSE_Monastery_Trigger_11 == true)) then
			UnLockDoor(GetDoorID("Door_Monastery_Floor1"))
			OpenDoor(GetDoorID("Door_Monastery_Floor1"))
	
			Freeze(GetCharacterID("Char_Monastery_Syndic_Trooper_11"),false)
		--	FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_5"),false)
			_bCtrlSE_Monastery_Trigger_8 = true
		end
	end
end

--[[ Spawn Couloir ]]--

function OnEnter_SE_Monastery_Trigger_9(id)
	if ((id == _idPlayer) and (_bCtrlSE_Monastery_Trigger_9 == false))then
			FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_5"),false)
			Freeze(GetCharacterID("Char_Monastery_Resist_Sniper_2"),false)
			Freeze(GetCharacterID("Char_Monastery_Resist_Sniper_3"),false)
			_bCtrlSE_Monastery_Trigger_9 = true
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
				StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic(
	end
end

--[[ Débloque Couloir ]]--

function DebloqueCouloir()
	if (IsDoorOpened(GetDoorID("Door_Monastery_Floor2")) and (_bCtrlDebloqueCouloir == false)) then
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_17"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_18"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Syndic_Trooper_19"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Sniper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Sniper_2b"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Sniper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Sniper_3b"))
		
		_bCtrlDebloqueCouloir = true
	end
end

function AliveGrp_Monastery_Syndic_Trooper_6()
	_nAliveGrp_Monastery_Syndic_Trooper_5 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_5"))
	if ((_nAliveGrp_Monastery_Syndic_Trooper_5 <= 2) and (_bPlayerRoof == false) and (_bCtrlAliveGrp_Monastery_Syndic_Trooper_6 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_6"),false)
		_bCtrlAliveGrp_Monastery_Syndic_Trooper_6 = true
	end
end

function AliveGrp_Monastery_Syndic_Trooper_7()
	_nAliveGrp_Monastery_Syndic_Trooper_6 = AliveMembersCount(GetGroupID("Grp_Monastery_Syndic_Trooper_6"))
	if ((_nAliveGrp_Monastery_Syndic_Trooper_6 <= 2) and (_bPlayerRoof == false) and (_bCtrlAliveGrp_Monastery_Syndic_Trooper_7 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_Syndic_Trooper_7"),false)
		_bCtrlAliveGrp_Monastery_Syndic_Trooper_7 = true
	end
end

function OnEnter_SE_Monastery_Trigger_12(id)
	if (id == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.08)
		if(_bCtrlSE_Monastery_Trigger_12 == false)then
			_bPlayerRoof = true
			_bCtrlSE_Monastery_Trigger_12 = true
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic(
		end
	end
end





