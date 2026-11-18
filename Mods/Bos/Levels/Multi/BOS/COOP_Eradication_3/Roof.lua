------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelRoof()
	_bCtrlSE_Roof_Hang_Cine1 = false
	_bTrackingCamPoint_Roof_2 = true
	_bTrackingCamPoint_Roof_3 = true
	_bCtrlFriseUltimeSniperCine = false
	_bCtrlSE_Roof_Hang_Fight1 = false
	_bCtrlRoofHangChangeCpt = false
	_bCtrlRoofHangPicoteurs1 = false
	_bCtrlRoofHangPicoteurs2 = false
	_bRoofPlayer = 0
	_nGrp_Roof_Defrise1 = 0
	_nGrp_Roof_Defrise2 = 0
	_nAliveChar_Roof_Resist_Trooper_4 = 1
	_bCtrlAliveChar_Roof_Resist_Trooper_4 = false
	_bCtrlRoofBaldingCineDeclenche = false
	_bCtrlRoofBaldingCineBegin = false
	_bCtrlDialogueBalding1 = false
	_bCtrlRoofAliveBalding = false
	_bCtrlBaldingFightEnCours = false
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevelRoof()
	TrackingCamPoint_Roof_1()
	TrackingCamPoint_Roof_2()
	TrackingCamPoint_Roof_3()
	FriseUltimeSniperCine()
	RoofHangChangeCpt()
	RoofHangPicoteurs()
	TrackingCamPoint_Roof_Balding_1()
	TrackingCamPoint_Roof_Balding_2()
	TrackingCamPoint_Roof_Balding_3()
	TrackingCamPoint_Roof_Balding_4()
	TrackingCamPoint_Roof_Balding_5()
	TrackingCamPoint_Roof_Balding_6()
	TrackingCamPoint_Roof_Balding_7()
	TrackingCamPoint_Roof_Balding_8()
	TrackingCamPoint_Roof_Balding_9()
	TrackingCamPoint_Roof_Balding_10()
	TrackingCamPoint_Roof_Balding_11()
	TrackingCamPoint_Roof_Balding_12()
	TrackingCamPoint_Roof_Balding_13()
	TrackingCamPoint_Roof_Balding_14()
	TrackingCamPoint_Roof_Balding_15()
	TrackingCamPoint_Roof_Balding_16()
	TrackingCamPoint_Roof_Balding_17()
	TrackingCamPoint_Roof_Balding_18()
	TrackingCamPoint_Roof_Balding_23()
	TrackingCamPoint_Roof_Balding_24()
	TrackingCamPoint_Roof_Balding_25()
	TrackingCamPoint_Roof_Balding_26()
	TrackingCamPoint_Roof_Balding_27()
	RoofBaldingCineDeclenche()
	RoofAliveBalding()
	if (_bCtrlBaldingFightEnCours == true) then
		Champion_Stop_Turning_Reloading(GetCharacterID("Char_Max_Balding_Roof"),"AIOL_Char_Hang_Guards_Roof")
	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof - Escalier :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_EscalierRoof(id)
	if (id == _idPlayer) then
--		Freeze(GetCharacterID("Char_Monastery_Resist_Trooper_28"), false)

		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.08)
 	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof - Hang Ciné ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Roof_Hang_Cine1(id)
	if (id == _idPlayer)then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",2.0)
 		if (_bCtrlSE_Roof_Hang_Cine1 == false) then
		if IsAlive(GetCharacterID("Char_Phase1_Resist_Sniper_1")) then
			Freeze(GetCharacterID("Char_Phase1_Resist_Sniper_1"), true)
		end
		FreezeAll(GetGroupID("Grp_Roof_Hang"), false)
		FreezeAll(GetGroupID("Grp_Roof_1"), false)
		Teletransportation("Char_Repere_Player_Roof",_idPlayer)
		EnableCharacterCommand(_idPlayer,false)
		if (_idMerc[0] ~= nil) then
			Teletransportation("Char_Repere_Merc0_Roof",_idMerc[0])
			EnableCharacterCommand(_idMerc[0],false)
		end
		if (_idMerc[1] ~= nil) then
			Teletransportation("Char_Repere_Merc1_Roof",_idMerc[1])
			EnableCharacterCommand(_idMerc[1],false)	
		end
		_bCtrlSE_Roof_Hang_Cine1 = true
		ShowCinematicBlackStripes(true)
		ReleaseSingleRigidBodyInBox("SE_SRB_RLZ_Roof_Shaiming")
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_A1"))
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
				StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic(
		end
	end
end

--[[ Ciné Séquence A ]]--

function CineCamTransition_Roof_A2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_A2"))
	CreationTimer(true, true, false, "UltimeSniperCine",2)
end

function ChangeAIOLChar_Roof_Resist_Trooper_1()
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Resist_Trooper_1_2"))
end

function UltimeSniperCine()
	_bTrackingCamPoint_Roof_2 = false
	_bTrackingCamPoint_Roof_3 = false
	Freeze(GetCharacterID("Char_Roof_Syndic_Sniper_1"), false)
	ChangeAIOLChar_Roof_Resist_Trooper_1()
end

function TrackingCamPoint_Roof_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_1"),GetCharacterID("Char_Roof_Resist_Trooper_1"))
end

function TrackingCamPoint_Roof_2()
	if (_bTrackingCamPoint_Roof_2 == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_2"),GetCharacterID("Char_Roof_Resist_Trooper_1"))
	end
end

function TrackingCamPoint_Roof_3()
	if (_bTrackingCamPoint_Roof_3 == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_3"),GetCharacterID("Char_Roof_Resist_Trooper_1"))
	end
end

function FriseUltimeSniperCine()
	if (not IsAlive(GetCharacterID("Char_Roof_Resist_Trooper_1")) and (_bCtrlFriseUltimeSniperCine == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Sniper_1"), true)
		SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Resist_Trooper_2_2"))
		_bCtrlFriseUltimeSniperCine = true
	end
end

function OnEnter_SE_Roof_Hang_Cine2()
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Resist_Trooper_5_2"))
end

--[[ Ciné Séquence B ]]--

function CineCamTransition_Roof_B1()
--	Freeze(GetCharacterID("Char_Roof_Syndic_Sniper_1"), true)
	Freeze(GetCharacterID("Char_Roof_Resist_Trooper_4"), false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_B1"))
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Resist_Trooper_4_1"))
end

function TrackingCamPoint_Roof_4()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_4"),GetCharacterID("Char_Hang_Shaiming_Roof"))
end


function TrackingCamPoint_Roof_5()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_5"),GetCharacterID("Char_Hang_Shaiming_Roof"))
end

--[[ Ciné Fin ]]--

function CineIntroRoofFin()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
		if (_idMerc[1] ~= nil) then
	EnableCharacterCommand(_idMerc[0],true)
		end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)	
	end
	RoofAlarm()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof - Hang Fight :::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function RoofAlarm()
	Freeze(GetCharacterID("Char_Monastery_Resist_Trooper_28"), false)
	CreationTimer(true, true, false, "RoofAction",3)
	NewSubObjective("Obj_B5","Obj_B6")
end

function RoofAction()
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Resist_Trooper_2_3"))
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Roof"))
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Roof"))
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Roof"))
	SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_6"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Roof"))
	SetVarValue(GetCharacterID("Char_Hang_Guard_Roof1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Hang_Guard_Roof2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Hang_Shaiming_Roof2"))
--	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"HelmetHitPoints",100)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Shaiming_Roof"),"Active",true)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Shaiming_Roof_Guard1"),"Active",true)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Shaiming_Roof_Guard2"),"Active",true)
	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Ho"))
end

function OnEnter_SE_Roof_Hang_Fight1(id)
	if (((id == _idPlayer) or (id == _idMerc[0]) or (id == _idMerc[1])) and (_bCtrlSE_Roof_Hang_Fight1 == false)) then
		SetVarValue(GetCharacterID("Char_Roof_Resist_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player_Roof"))
		_bCtrlSE_Roof_Hang_Fight1 = true
	end
end

function RoofHangChangeCpt()
	if (_bCtrlRoofHangChangeCpt == false) then
		_nHangShieldHealth = GetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Shaiming_Roof"),"ShieldHealth")
		if (_nHangShieldHealth <= 1400) then
			SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Hang_Shaiming_Roof3"))
			SetVarValue(GetPlug_PulseID("Plug_Pulse_Hang_Shaiming"),"Active",true)
			_bCtrlRoofHangChangeCpt = true
		end
	end
end

function RoofHangPicoteurs()
	if ((AliveMembersCount(GetGroupID("Grp_Roof_1")) == 0) and (_bCtrlRoofHangPicoteurs1 == false)) then
		if (_bRoofPlayer == 0) then
			FreezeAll(GetGroupID("Grp_Roof_2"), false)
			_nGrp_Roof_Defrise1 = 2
			_bCtrlRoofHangPicoteurs1 = true
		else
			FreezeAll(GetGroupID("Grp_Roof_4"), false)
			_nGrp_Roof_Defrise1 = 4
			_bCtrlRoofHangPicoteurs1 = true
		end
	end
	if ((AliveMembersCount(GetGroupID("Grp_Roof_2")) == 0) and (_bCtrlRoofHangPicoteurs2 == false)) then
		if (_bRoofPlayer == 0) then
			FreezeAll(GetGroupID("Grp_Roof_3"), false)
			_nGrp_Roof_Defrise2 = 3
			_bCtrlRoofHangPicoteurs2 = true
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
		else
			FreezeAll(GetGroupID("Grp_Roof_5"), false)
			_nGrp_Roof_Defrise2 = 5
			_bCtrlRoofHangPicoteurs2 = true
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

function OnEnter_SE_Roof_Hang_Fight_Player1(id)
	if (id == _idPlayer) then
		_bRoofPlayer = 0
	end
end

function OnEnter_SE_Roof_Hang_Fight_Player2(id)
	if (id == _idPlayer) then
		_bRoofPlayer = 1
	end
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof - Balding Ciné :::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function RoofBaldingCineDeclenche()
	if (_bCtrlRoofBaldingCineDeclenche == false) then
		if ((_nGrp_Roof_Defrise1 == 2) and (_nGrp_Roof_Defrise2 == 3)) then
			_nGrp_Roof_2 = AliveMembersCount(GetGroupID("Grp_Roof_2"))
			_nGrp_Roof_3 = AliveMembersCount(GetGroupID("Grp_Roof_3"))
			_nGrp_Roof_Hang = AliveMembersCount(GetGroupID("Grp_Roof_Hang"))
			_nGrp_Roof_1 = AliveMembersCount(GetGroupID("Grp_Roof_1"))

			_bAliveChar_Roof_Resist_Trooper_4 = IsAlive(GetCharacterID("Char_Roof_Resist_Trooper_4"))
			if ((_bAliveChar_Roof_Resist_Trooper_4 == false) and (_bCtrlAliveChar_Roof_Resist_Trooper_4 == false)) then
				_nAliveChar_Roof_Resist_Trooper_4 = 0
				_bCtrlAliveChar_Roof_Resist_Trooper_4 = true
			end

			_nRoofTotalActive = (_nGrp_Roof_2 + _nGrp_Roof_3 + _nGrp_Roof_Hang + _nGrp_Roof_1 + _nAliveChar_Roof_Resist_Trooper_4)

			CreationTimer(true, true, false, "RoofBaldingCineBegin",3)
			
		elseif ((_nGrp_Roof_Defrise1 == 2) and (_nGrp_Roof_Defrise2 == 5)) then
			_nGrp_Roof_2 = AliveMembersCount(GetGroupID("Grp_Roof_2"))
			_nGrp_Roof_5 = AliveMembersCount(GetGroupID("Grp_Roof_5"))
			_nGrp_Roof_Hang = AliveMembersCount(GetGroupID("Grp_Roof_Hang"))
			_nGrp_Roof_1 = AliveMembersCount(GetGroupID("Grp_Roof_1"))

			_bAliveChar_Roof_Resist_Trooper_4 = IsAlive(GetCharacterID("Char_Roof_Resist_Trooper_4"))
			if ((_bAliveChar_Roof_Resist_Trooper_4 == false) and (_bCtrlAliveChar_Roof_Resist_Trooper_4 == false)) then
				_nAliveChar_Roof_Resist_Trooper_4 = 0
				_bCtrlAliveChar_Roof_Resist_Trooper_4 = true
			end

			_nRoofTotalActive = (_nGrp_Roof_2 + _nGrp_Roof_5 + _nGrp_Roof_Hang + _nGrp_Roof_1 + _nAliveChar_Roof_Resist_Trooper_4)

			CreationTimer(true, true, false, "RoofBaldingCineBegin",3)

		elseif ((_nGrp_Roof_Defrise1 == 4) and (_nGrp_Roof_Defrise2 == 3)) then
			_nGrp_Roof_4 = AliveMembersCount(GetGroupID("Grp_Roof_4"))
			_nGrp_Roof_3 = AliveMembersCount(GetGroupID("Grp_Roof_3"))
			_nGrp_Roof_Hang = AliveMembersCount(GetGroupID("Grp_Roof_Hang"))
			_nGrp_Roof_1 = AliveMembersCount(GetGroupID("Grp_Roof_1"))

			_bAliveChar_Roof_Resist_Trooper_4 = IsAlive(GetCharacterID("Char_Roof_Resist_Trooper_4"))
			if ((_bAliveChar_Roof_Resist_Trooper_4 == false) and (_bCtrlAliveChar_Roof_Resist_Trooper_4 == false)) then
				_nAliveChar_Roof_Resist_Trooper_4 = 0
				_bCtrlAliveChar_Roof_Resist_Trooper_4 = true
			end

			_nRoofTotalActive = (_nGrp_Roof_2 + _nGrp_Roof_3 + _nGrp_Roof_Hang + _nGrp_Roof_1 + _nAliveChar_Roof_Resist_Trooper_4)

			CreationTimer(true, true, false, "RoofBaldingCineBegin",3)

		elseif ((_nGrp_Roof_Defrise1 == 4) and (_nGrp_Roof_Defrise2 == 5)) then
			_nGrp_Roof_4 = AliveMembersCount(GetGroupID("Grp_Roof_4"))
			_nGrp_Roof_5 = AliveMembersCount(GetGroupID("Grp_Roof_5"))
			_nGrp_Roof_Hang = AliveMembersCount(GetGroupID("Grp_Roof_Hang"))
			_nGrp_Roof_1 = AliveMembersCount(GetGroupID("Grp_Roof_1"))

			_bAliveChar_Roof_Resist_Trooper_4 = IsAlive(GetCharacterID("Char_Roof_Resist_Trooper_4"))
			if ((_bAliveChar_Roof_Resist_Trooper_4 == false) and (_bCtrlAliveChar_Roof_Resist_Trooper_4 == false)) then
				_nAliveChar_Roof_Resist_Trooper_4 = 0
				_bCtrlAliveChar_Roof_Resist_Trooper_4 = true
			end

			_nRoofTotalActive = (_nGrp_Roof_2 + _nGrp_Roof_3 + _nGrp_Roof_Hang + _nGrp_Roof_1 + _nAliveChar_Roof_Resist_Trooper_4)

			CreationTimer(true, true, false, "RoofBaldingCineBegin",3)

		end
--		_bCtrlRoofBaldingCineDeclenche = true
	end
end

--[[ Ciné Séquence A ]]--

function RoofBaldingCineBegin()
	if (_nRoofTotalActive == 0) then
		if (_bCtrlRoofBaldingCineBegin == false) then
			Teletransportation("Char_Repere_Player_Roof2",_idPlayer)
			EnableCharacterCommand(_idPlayer,false)
			if (_idMerc[0] ~= nil) then
				Teletransportation("Char_Repere_Merc0_Roof",_idMerc[0])
				EnableCharacterCommand(_idMerc[0],false)
			end
			if (_idMerc[1] ~= nil) then
				Teletransportation("Char_Repere_Merc1_Roof",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
			_bCtrlRoofBaldingCineBegin = true
			Freeze(GetCharacterID("Char_Max_Balding_Roof"), false)
			Freeze(GetCharacterID("Player_Cine_Roof"), false)
			SetGodMode(GetCharacterID("Player_Cine_Roof"), true)
			ShowCinematicBlackStripes(true)
			ReleaseSingleRigidBodyInBox("SE_SRB_RLZ_Roof_Balding")
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A1"))
			CreationTimer(true, true, false,"DialogueNolan1",2)
			SkinPlayer()
		end
	end
end

function CineCamTransition_Roof_Balding_A2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A2"))
end

function CineCamTransition_Roof_Balding_A3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A3"))
end

function CineCamTransition_Roof_Balding_A4()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A4"))
--	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
	CreationTimer(true, true, false,"AnimCoolNolan1",3)
end

function AnimCoolNolan1()
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
end

function CineCamTransition_Roof_Balding_A5()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A5"))
end

function CineCamTransition_Roof_Balding_A6()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A6"))
end

function CineCamTransition_Roof_Balding_A7()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A7"))
	DialogueBalding6()
end

function CineCamTransition_Roof_Balding_A8()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A8"))
	CreationTimer(true, true, false,"DialogueNolan3",1)
end

function CineCamTransition_Roof_Balding_A9()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A9"))
	CreationTimer(true, true, false,"DialogueBalding7",1)
end

function CineCamTransition_Roof_Balding_B1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A9"))
	CreationTimer(true, true, false,"DialogueBalding7",1)
end

function TrackingCamPoint_Roof_Balding_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_1"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_2"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_3()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_3"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_4()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_4"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_5()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_5"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_6()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_6"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_7()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_7"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_8()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_8"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_9()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_9"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_10()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_10"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_11()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_11"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_12()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_12"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_13()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_13"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_14()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_14"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_15()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_15"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_16()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_16"),GetCharacterID("Player_Cine_Roof"))
end

function TrackingCamPoint_Roof_Balding_17()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_17"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_18()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_18"),GetCharacterID("Char_Max_Balding_Roof"))
end

function SkinPlayer()
	_strArmorPlayer = GetVarValue(_idPlayer,"Armor")
	_nArmorBodyPlayer = GetArmorPartHP(_idPlayer,"Body")
	_nArmorLegsPlayer = GetArmorPartHP(_idPlayer,"Legs")
	_strBodyModelPlayer = GetVarValue(_idPlayer,"BodyModel")
	_strHeadModelPlayer = GetVarValue(_idPlayer,"HeadModel")
	_idArsenalPlayer = GetVarValue(_idPlayer,"Arsenal")
	SetVarValue(GetCharacterID("Player_Cine_Roof"),"Armor",_strArmorPlayer)
	SetVarValue(GetCharacterID("Player_Cine_Roof"),"BodyHitPoints",_nArmorBodyPlayer)
	SetVarValue(GetCharacterID("Player_Cine_Roof"),"LegsHitPoints",_nArmorLegsPlayer)
	SetVarValue(GetCharacterID("Player_Cine_Roof"),"Arsenal",_idArsenalPlayer)
	SetVarValue(GetCharacterID("Player_Cine_Roof"),"CurrentSlot","Heavy")
end


function DialogueNolan1()
	MakeCharacterSpeak(GetCharacterID("Player_Cine_Roof"),GetCharacterID("Char_Max_Balding_Roof"),"DIA_CINE2_A_NOLAN_01",true,100,2,2,"",0)
--	RadioMessage("DIA_CINE2_A_NOLAN_01", true, 100, 4,"")
end

function DialogueBalding1()
	if (_bCtrlDialogueBalding1 == false) then
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_01",true,100,2,2,"DialogueNolan2",0)
		CreationTimer(true, true, false,"CineCamTransition_Roof_Balding_A2",4)
		_bCtrlDialogueBalding1 = true
	end
end

function DialogueNolan2()
--	RadioMessage("DIA_CINE2_A_NOLAN_01", true, 100, 4,"")
--	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
	CreationTimer(true, true, false,"DialogueNolan2b",1)
end

function DialogueNolan2b()
	MakeCharacterSpeak(GetCharacterID("Player_Cine_Roof"),GetCharacterID("Char_Max_Balding_Roof"),"DIA_CINE2_A_NOLAN_02",true,100,2,1,"DialogueBalding2",0)
end

function DialogueBalding2()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_02",true,100,2,1,"DialogueBalding3",0)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
end

function DialogueBalding3()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_03",true,100,2,1,"DialogueBalding4",0)
end

function DialogueBalding4()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_04",true,100,2,1,"DialogueBalding5",0)
end

function DialogueBalding5()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_05",true,100,2,1,"",0)
end

function DialogueBalding6()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_06",true,100,2,1,"",0)
end

function DialogueNolan3()
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
	MakeCharacterSpeak(GetCharacterID("Player_Cine_Roof"),GetCharacterID("Char_Max_Balding_Roof"),"DIA_CINE2_B_NOLAN_02",true,100,2,1,"",0)
--	RadioMessage("DIA_CINE2_A_NOLAN_01", true, 100, 4,"")
end

function DialogueBalding7()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_07",true,100,2,1,"",0)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
end


--[[ Ciné Séquence B ]]--

function CineCamTransition_Roof_Balding_B1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_B1"))
	FreezeAll(GetGroupID("Grp_Roof_Max"), false)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Max_Balding_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
end

function CineCamTransition_Roof_Balding_B2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_B2"))
end

function CineCamTransition_Roof_Balding_B3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_B3"))
	CreationTimer(true, true, false,"DialogueBalding8",1)
end

function DialogueBalding8()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_08",true,100,2,1,"",0)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Max_Balding_Roof_1"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
end

function CineCamTransition_Roof_Balding_B4()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_B4"))
	DialogueBalding9()
end

function CineCamTransition_Roof_Balding_B5()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_B5"))
	CreationTimer(true, true, false,"DialogueBalding10",2)
end

function DialogueBalding9()
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_09",true,100,2,1,"",0)
end

function DialogueBalding10()
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_A_BALDING_10",true,100,2,1,"",0)
end

function TrackingCamPoint_Roof_Balding_23()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_23"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_24()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_24"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_25()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_25"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_26()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_26"),GetCharacterID("Char_Max_Balding_Roof"))
end

function TrackingCamPoint_Roof_Balding_27()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_27"),GetCharacterID("Char_Max_Balding_Roof"))
end

--[[ Ciné Fin ]]--

function CineRoofBaldingFin()
	ShowCinematicBlackStripes(false)
	Teletransportation("Char_Repere_Player_Roof1",_idPlayer)
	EnableCharacterCommand(_idPlayer,true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[0],true)
		EnableCharacterFire(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
		EnableCharacterFire(_idMerc[1], false)
	end
	Freeze(GetCharacterID("Player_Cine_Roof"), true)
	CharacterStopSpecialAction(GetCharacterID("Char_Max_Balding_Roof"))
	EnableCharacterFire(_idPlayer, false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Roof"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof1"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof2"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof3"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof4"), false)

	SetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Balding_Roof"),"Active",true)

	SetVarValue(GetCharacterID("Char_Max_Balding_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Hang_Guards_Roof"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Roof"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Balding"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof1"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Balding_Guards"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof2"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Balding_Guards"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof3"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Balding_Guards"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof4"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS_Balding_Guards"))

	CreationTimer(true, true, false,"GoFightBalding",5)
	ObjectiveDoneNewObjectiveNewSubObjective ("Obj_B","Obj_C","Obj_C1")

	_bCtrlBaldingFightEnCours = true
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof - Balding Fight ::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function GoFightBalding()
	EnableCharacterFire(_idPlayer, true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[1], true)
	end
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Roof"), true)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof1"), true)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof2"), true)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof3"), true)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof4"), true)
end

function RoofAliveBalding()
	if ((not IsAlive(GetCharacterID("Char_Max_Balding_Roof"))) and (AliveMembersCount(GetGroupID("Grp_Roof_Max")) == 0) and (_bCtrlRoofAliveBalding == false)) then
		CreationTimer(true, true, false,"CINE_End",1.5)
		_bCtrlRoofAliveBalding = true
	end
end

function CINE_End()
	StopMusic()
	SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Cine2"),"Playing",true)
	CreationTimer(true, true, false,"Cine_Sound",16.0)
	SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Cine"),"Playing",true)
	StartMusic("Sounds//Music//BoS - Little theme.wav",false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
	Freeze(_idPlayer,true)
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1],true)
	end
end

function Cine_Sound()
	RadioMessage("DIA_CINE2_B_NOLAN_02", true, 100, 0,"")	
end

function CINE_End_B()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_B"))
end

function End()
	EndOfLevel ()
end