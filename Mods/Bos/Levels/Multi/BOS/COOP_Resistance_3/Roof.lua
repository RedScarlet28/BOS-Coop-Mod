------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelRoof()
	_bCtrlSE_Roof_Trigger_1 = false
	_bCtrlSE_Roof_Trigger_2 = false
	_bCtrlBaldingRulez = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_1 = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_2 = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_3 = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_4 = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_5 = false
	_bCtrlAliveChar_Roof_Syndic_Trooper_6 = false
	_bCtrlnAliveGrp_Roof_Syndic_Trooper_1_2 = false
	_bCtrlRoofBaldingCineDeclenche = false
	_bCtrlRoofBaldingCineBegin = false
	_bCtrlDialogueBalding1 = false
	_bCtrlRoofAliveBalding = false
	_bCtrlAliveChar_Hang_Shaiming_Roof1 = false

end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevelRoof()
	TrackingCamPoint_Roof_Shaiming_1_1()
	TrackingCamPoint_Roof_Shaiming_1_2()
	AliveChar_Roof_Syndic_Troopers()
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
	TrackingCamPoint_Roof_Balding_0_1()
	TrackingCamPoint_Roof_Balding_0_2()
--	RoofBaldingCineDeclenche()
	RoofAliveBalding()
	AliveChar_Hang_Shaiming_Roof1()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof Cine 1 :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Roof_Trigger_1(id)
	if (id == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",2.0)
		if (_bCtrlSE_Roof_Trigger_1 == false) then
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
		FreezeAll(GetGroupID("Grp_Roof_Syndic_Trooper_1"),false)
		FreezeAll(GetGroupID("Grp_Roof_Friend_Trooper_1"),false)
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Shaiming_1"))
		ShowCinematicBlackStripes(true)
		_bCtrlSE_Roof_Trigger_1 = true
		SetGodMode(GetCharacterID("Char_Hang_Shaiming_Roof"),true)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_1"),true)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_2"),true)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_3"),true)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_4"),true)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_5"),true)

		-- Debug
--		Freeze(GetCharacterID("Char_Phase1_Friend_Trooper_1"),true)

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

function TrackingCamPoint_Roof_Shaiming_1_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Shaiming_1_1"),GetCharacterID("Char_Hang_Shaiming_Roof"))
end

function TrackingCamPoint_Roof_Shaiming_1_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Shaiming_1_2"),GetCharacterID("Char_Hang_Shaiming_Roof"))
end

function Cine_CamTransition_Roof_Shaiming_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Shaiming_2"))
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Roof_Syndic_Trooper_1"),"Animation","STAND MEDHI ORDER_GO W_NONE")
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Syndic_Trooper_2b"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Syndic_Trooper_3b"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Syndic_Trooper_4b"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Roof_Syndic_Trooper_5b"))

	CreationTimer(true, true, false, "ActivePlugHang",2)
end

function ActivePlugHang()
	SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield6"),"Active",true)
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_1"),"CharacterOrderList",GetInvalidEntityID())
	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Hang_Roof_Path"))
	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_Friend_Trooper_Bad"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Hang"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Hang"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Hang"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Hang"))
	SetVarValue(GetCharacterID("Char_Roof_Syndic_Trooper_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Hang"))
end

function Cine_CamTransition_Roof_Shaiming_3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Shaiming_3"))

end

--[[ Ciné Fin ]]--

function CineRoof1Fin()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
		if (_idMerc[1] ~= nil) then
	EnableCharacterCommand(_idMerc[0],true)
		end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)	
	end
	NewSubObjective ("Obj_B1","Obj_B2")
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof Hang Fight :::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function OnEnter_SE_Roof_Trigger_2(id)
	if ((id == _idPlayer) and (_bCtrlSE_Roof_Trigger_2 == false)) then
		SetVarValue(GetCharacterID("Char_Hang_Shaiming_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_F_Player"))
		SetGodMode(GetCharacterID("Char_Hang_Shaiming_Roof"),false)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_1"),false)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_2"),false)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_3"),false)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_4"),false)
		SetGodMode(GetCharacterID("Char_Roof_Syndic_Trooper_5"),false)
		_bCtrlSE_Roof_Trigger_2 = true
	end
end

function AliveChar_Roof_Syndic_Troopers()
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_1"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_1 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_6"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_1 = true
	end
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_2"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_2 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_7"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_2 = true
	end
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_3"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_3 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_8"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_3 = true
	end
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_4"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_4 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_9"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_4 = true
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
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_5"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_5 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_10"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_5 = true
	end
	if ((not IsAlive(GetCharacterID("Char_Roof_Syndic_Trooper_6"))) and (_bCtrlAliveChar_Roof_Syndic_Trooper_6 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Trooper_11"), false)
		_bCtrlAliveChar_Roof_Syndic_Trooper_6 = true
	end
		_nAliveGrp_Roof_Syndic_Trooper_1 = AliveMembersCount(GetGroupID("Grp_Roof_Syndic_Trooper_1"))
		_nAliveGrp_Roof_Syndic_Trooper_2 = AliveMembersCount(GetGroupID("Grp_Roof_Syndic_Trooper_2"))

	if ((_nAliveGrp_Roof_Syndic_Trooper_1 == 0) and (_nAliveGrp_Roof_Syndic_Trooper_2 == 0) and (_bCtrlnAliveGrp_Roof_Syndic_Trooper_1_2 == false)) then
		BaldingRulez()
		_bCtrlnAliveGrp_Roof_Syndic_Trooper_1_2 = true
	end
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Roof Cine 2 :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Ciné Séquence A ]]--

function BaldingRulez()
	if (_bCtrlBaldingRulez == false) then

		_bCtrlBaldingRulez = true
		CreationTimer(true, true, false,"LanceCineBalding",3)
	end
end

function LanceCineBalding()
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
	Freeze(GetCharacterID("Char_Hang_Shaiming_Roof"), true)	
	Freeze(GetCharacterID("Char_Hang_Shaiming_Roof1"), false)
	Freeze(GetCharacterID("Player_Cine_Roof"), false)
	SetGodMode(GetCharacterID("Player_Cine_Roof"), true)
	ShowCinematicBlackStripes(true)
	ReleaseSingleRigidBodyInBox("SE_SRB_RLZ_Roof_Balding")
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A0"))
	CreationTimer(true, true, false,"DialogueShaiming",2)
	SkinPlayer()
end

function DialogueShaiming()
	MakeCharacterSpeak(GetCharacterID("Char_Hang_Shaiming_Roof1"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_SHAIMING_01",true,100,2,2,"",0)
	SetGodMode(GetCharacterID("Char_Roof_Syndic_Sniper_2"), true)
	CreationTimer(true, true, false,"Snipotron",2)
end


function Snipotron()
	Freeze(GetCharacterID("Char_Roof_Syndic_Sniper_2"), false)
end

function CineCamTransition_Roof_Balding_A1()
	Freeze(GetCharacterID("Char_Max_Balding_Roof"), false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Roof_Balding_A1"))
	CreationTimer(true, true, false,"DialogueNolan1",2)
end


function AliveChar_Hang_Shaiming_Roof1()
	if (not IsAlive(GetCharacterID("Char_Hang_Shaiming_Roof1")) and (_bCtrlAliveChar_Hang_Shaiming_Roof1 == false)) then
		Freeze(GetCharacterID("Char_Roof_Syndic_Sniper_2"), true)
		CreationTimer(true, true, false,"CineCamTransition_Roof_Balding_A1",1)
		_bCtrlAliveChar_Hang_Shaiming_Roof1 = true
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

function TrackingCamPoint_Roof_Balding_0_1()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_0_1"),GetCharacterID("Char_Hang_Shaiming_Roof1"))
end

function TrackingCamPoint_Roof_Balding_0_2()
	CamPointTargetCharacter(GetCamPointID("CamPoint_Roof_Balding_0_2"),GetCharacterID("Char_Hang_Shaiming_Roof1"))
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
	MakeCharacterSpeak(GetCharacterID("Player_Cine_Roof"),GetCharacterID("Char_Max_Balding_Roof"),"DIA_CINE2_B_NOLAN_01",true,100,2,2,"",0)
--	RadioMessage("DIA_CINE2_A_NOLAN_01", true, 100, 4,"")
end

function DialogueBalding1()
	if (_bCtrlDialogueBalding1 == false) then
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_01",true,100,2,2,"DialogueNolan2",0)
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
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_02",true,100,2,1,"DialogueBalding3",0)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL")
end

function DialogueBalding3()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_03",true,100,2,1,"DialogueBalding4",0)
end

function DialogueBalding4()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_04",true,100,2,1,"DialogueBalding5",0)
end

function DialogueBalding5()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_05",true,100,2,1,"",0)
end

function DialogueBalding6()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_06",true,100,2,1,"",0)
end

function DialogueNolan3()
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_NOLAN_Roof_1"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
	MakeCharacterSpeak(GetCharacterID("Player_Cine_Roof"),GetCharacterID("Char_Max_Balding_Roof"),"DIA_CINE2_B_NOLAN_02",true,100,2,1,"",0)
--	RadioMessage("DIA_CINE2_A_NOLAN_01", true, 100, 4,"")
end

function DialogueBalding7()
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_07",true,100,2,1,"",0)
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
	MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_08",true,100,2,1,"",0)
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
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_09",true,100,2,1,"",0)
end

function DialogueBalding10()
		MakeCharacterSpeak(GetCharacterID("Char_Max_Balding_Roof"),GetCharacterID("Player_Cine_Roof"),"DIA_CINE2_B_BALDING_10",true,100,2,1,"",0)
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
	Freeze(GetCharacterID("Player_Cine_Roof"), true)
	ShowCinematicBlackStripes(false)
	Teletransportation("Player_Cine_Roof",_idPlayer)
	EnableCharacterCommand(_idPlayer,true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[0],true)
		EnableCharacterFire(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
		EnableCharacterFire(_idMerc[1], false)
	end

	CharacterStopSpecialAction(GetCharacterID("Char_Max_Balding_Roof"))
	EnableCharacterFire(_idPlayer, false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Roof"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof1"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof2"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof3"), false)
	EnableCharacterFire(GetCharacterID("Char_Max_Balding_Guard_Roof4"), false)

	SetVarValue(GetCharacterID("Char_Max_Balding_Roof"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Roof"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof1"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof2"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof3"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
	SetVarValue(GetCharacterID("Char_Max_Balding_Guard_Roof4"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))

	CreationTimer(true, true, false,"GoFightBalding",5)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Hang_Balding_Roof"),"Active",true)
	ObjectiveDoneNewObjectiveNewSubObjective ("Obj_B","Obj_C","Obj_C1")
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
	_bCtrlBaldingFightEnCours = false
end

function RoofAliveBalding()
	if ((not IsAlive(GetCharacterID("Char_Max_Balding_Roof"))) and (AliveMembersCount(GetGroupID("Grp_Roof_Max")) == 0) and (_bCtrlRoofAliveBalding == false)) then
		CreationTimer(true, true, false,"CINE_End",1.5)
		_bCtrlRoofAliveBalding = true
	end
end


function CINE_End()
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