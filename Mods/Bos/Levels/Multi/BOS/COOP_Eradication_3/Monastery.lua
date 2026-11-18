------------------------------------------------------------
------------------------------------------------------------

-- ::: InitLevel :::::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function InitLevelMonastery()
	_bCtrlSE_Enter_Monastery = false
	_bCtrlSE_Cine_Chapel = false
	_bActiveDefriseMiniBoSMonasteryEnter = false
	_bCtrlActiveChar_Monastery_Resist_Trooper_13 = false
	_bCtrlActiveChar_Monastery_Resist_Trooper_11 = false
	_bCtrlActiveChar_Monastery_Resist_Trooper_12 = false
	_bCtrlActiveChar_Monastery_Resist_Trooper_10 = false
	_bCtrlActiveCouloir_Etage_Monastery = false
	_bSequenceChapelActive = false
	_bCtrlSE_Room_1Floor_1_2 = false
	_bCtrlSE_Room_2Floor_1_2 = false
	_bCtrlAliveGrp_Monastery_MiniBoS_2Floor3 = false
	_bCtrlAliveGrp_Monastery_MiniBoS_2Floor4 = false
	_bCtrlAliveGrp_Monastery_MiniBoS_2Floor5 = false
	_bPlayerPasseCouloir = false
	_bCtrlActiveObjReachRoof = false
	_bCtrlCine_Chapel = false
	_bCtrlSE_ActivCouloir = false
	_bCtrlAliveGrp_Monastery_MiniBoS_Enter = false
	_bCtrlAliveGrp_Monastery_MiniBoS_1Floor1 = false
	_bExpFTChar_Monastery_Resist_Trooper_9 = false
	_bExpFTChar_Monastery_Resist_Trooper_10 = false
	_bExpFTChar_Monastery_Resist_Trooper_11 = false
	_bExpFTChar_Monastery_Resist_Trooper_12 = false
	_bExpFTChar_Monastery_Resist_Trooper_13 = false
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: UpdateLevel :::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateLevelMonastery()
--	DefriseMiniBoSMonasteryEnter()
	AliveGrp_Monastery_MiniBoS_Enter()
	AliveGrp_Monastery_MiniBoS_1Floor1()
	TrackingCamTransition_Chapel_0a()
	TrackingCamTransition_Chapel_0b()
--	TrackingCamTransition_Chapel_5()
--	TrackingCamTransition_Chapel_5b()
	ActiveChar_Monastery_Resist_Trooper_13()
	ActiveChar_Monastery_Resist_Trooper_11()
	ActiveChar_Monastery_Resist_Trooper_12()
	ActiveChar_Monastery_Resist_Trooper_10()
	TrackingCamTransition_Chapel_10()
	TrackingCamTransition_Chapel_10b()
	TrackingCamTransition_Chapel_10c()
	TrackingCamTransition_Chapel_11()
	TrackingCamTransition_Chapel_11b()
	TrackingCamTransition_Chapel_11c()
	TrackingCamTransition_Chapel_12()
	TrackingCamTransition_Chapel_12b()
	TrackingCamTransition_Chapel_12c()
	ActiveCouloir_Etage_Monastery()
	Security_Chapel_Door1()
	Security_Chapel_Door2()
	ActiveGrp_Monastery_MiniBoS_2Floor4_5()
	ActiveObjReachRoof()
	Cine_Chapel()
	Add_Money_To_Reward("Char_Phase1_Resist_MiniBoS_1",150)
	Add_Money_To_Reward("Char_Phase1_Resist_MiniBoS_1",150)
	Add_Money_To_Reward("Char_Phase1_Resist_MiniBoS_1",150)
	Add_Money_To_Reward("Char_Phase1_Resist_MiniBoS_1",150)
	Add_Money_To_Reward("Char_Monastery_Resist_Trooper_9",250)
	Add_Money_To_Reward("Char_Monastery_Resist_Trooper_10",250)
	Add_Money_To_Reward("Char_Monastery_Resist_Trooper_11",250)
	Add_Money_To_Reward("Char_Monastery_Resist_Trooper_12",250)
	Add_Money_To_Reward("Char_Monastery_Resist_Trooper_13",250)
	SE_ActivCouloir()
end

------------------------------------------------------------
------------------------------------------------------------

-- ::: Monastery - Enter :::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Entrée Monastery ]]--

function TimerEnterDoor()
	CreationTimer(true, true, false, "EnterDoor",3)
end

function EnterDoor()
	-- Ouverture de la porte
	UnLockDoor(GetDoorID("Door_Monastery_Enter"))
	OpenDoor(GetDoorID("Door_Monastery_Enter"))
	_bActiveDefriseMiniBoSMonasteryEnter = true
	-- Order List Ingénieur qui reprend son Non Scripted Order Follow
	SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
	ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A","Obj_B","Obj_B1")
end


function OnEnter_SE_Enter_Monastery1(id)
	if (id == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",2.00)
	end
end

function OnEnter_SE_Enter_Monastery(id)
	if (id == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.08)
		if (_bCtrlSE_Enter_Monastery == false) then
		UnLockDoor(GetDoorID("Door_Monastery_Floor22"))
		UnLockDoor(GetDoorID("Door_Monastery_Floor23"))
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_Enter"), false)
		_bCtrlSE_Enter_Monastery = true
--		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_1"), false)
	--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_2"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_3"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_4"), false)
		CreationTimer(true, true, false, "EnableFireGrp_Monastery_MiniBoS_Enter",4)
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

function EnableFireGrp_Monastery_MiniBoS_Enter()
--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_1"), true)
	--EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_2"), true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_3"), true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_4"), true)
end

function AliveGrp_Monastery_MiniBoS_Enter()
	_nAliveGrp_Monastery_MiniBoS_Enter = AliveMembersCount(GetGroupID("Grp_Monastery_MiniBoS_Enter"))
	if ((_nAliveGrp_Monastery_MiniBoS_Enter == 0) and (_bCtrlAliveGrp_Monastery_MiniBoS_Enter == false)) then
		-- Order List Ingénieur qui va hacker la porte
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIOL_Inge_1Floor1_Monastery"))
		_bCtrlAliveGrp_Monastery_MiniBoS_Enter = true
	end
end

function TimerMonastery_MiniBoS_1Floor1()
	CreationTimer(true, true, false, "DefriseMonastery_MiniBoS_1Floor1",3)
end

function DefriseMonastery_MiniBoS_1Floor1()
	SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
	UnLockDoor(GetDoorID("Door_Monastery_Floor21"))
	OpenDoor(GetDoorID("Door_Monastery_Floor21"))
	FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_1Floor1"), false)
--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_5"), false)
--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_6"), false)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_7"), false)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_8"), false)
	CreationTimer(true, true, false, "EnableFireGrp_Monastery_MiniBoS_1Floor1",3)
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

function EnableFireGrp_Monastery_MiniBoS_1Floor1()
--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_5"), true)
--	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_6"), true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_7"), true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_8"), true)
end

function AliveGrp_Monastery_MiniBoS_1Floor1()
	_nAliveGrp_Monastery_MiniBoS_1Floor1 = AliveMembersCount(GetGroupID("Grp_Monastery_MiniBoS_1Floor1"))
	if ((_nAliveGrp_Monastery_MiniBoS_1Floor1 == 0) and (_bCtrlAliveGrp_Monastery_MiniBoS_1Floor1 == false)) then
		-- Order List Ingénieur qui va hacker la porte
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIOL_Inge_1Floor2_Monastery"))
		_bCtrlAliveGrp_Monastery_MiniBoS_1Floor1 = true
	end
end

function TimerMonastery_MiniBoS_1Floor2()
	CreationTimer(true, true, false, "DefriseMonastery_MiniBoS_1Floor2",3)
end

function DefriseMonastery_MiniBoS_1Floor2()
		SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
		UnLockDoor(GetDoorID("Door_Monastery_Floor3"))
		OpenDoor(GetDoorID("Door_Monastery_Floor3"))
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_1Floor2"), false)
		SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_9"), true)
		SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_10"), true)
		SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_11"), true)
		SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_12"), true)
		SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_13"), true)
end

function Cine_Chapel()
	if (IsDoorOpened(GetDoorID("Door_Monastery_Floor2")) and (_bCtrlCine_Chapel == false)) then
		CineIntroChapelLancement()

		_bCtrlSE_Cine_Chapel = true
		_bCtrlCine_Chapel = true
	end	
end

function OnEnter_SE_Cine_Chapel(id)
	if ((id == _idPlayer) and (_bCtrlSE_Cine_Chapel == false)) then
		CineIntroChapelLancement()

		_bCtrlSE_Cine_Chapel = true
		_bCtrlCine_Chapel = true
	end
end

--[[ Cinématique Intro Chapel ]]--

function CineIntroChapelLancement()
	_bSequenceChapelActive = true
	Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
	EnableCharacterCommand(_idPlayer,false)
	Teletransportation("Char_Repere_Merc0_Chapel",_idMerc[0])
	EnableCharacterCommand(_idMerc[0],false)
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIOL_Mercs_Chapel"))
	if (_idMerc[1] ~= nil) then
		Teletransportation("Char_Repere_Merc1_Chapel",_idMerc[1])
		EnableCharacterCommand(_idMerc[1],false)	
		SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AIOL_Mercs_Chapel"))
	end
	-- Hang Shaiming
	Freeze(GetCharacterID("Char_Hang_Shaiming_Chapel"), false)
	Freeze(GetCharacterID("Char_Hang_Guard_Chapel1"), false)
	Freeze(GetCharacterID("Char_Hang_Guard_Chapel2"), false)
--	MakeCharacterSpeak(GetCharacterID("Char_Hang_Shaiming_Chapel"),_idPlayer,"DIA_SPE_BOS_SHAIMING_COMBAT_BAD_6",true,100,2,2,"",0)
	CreationTimer(true, true, false, "SpeechShaiming0",3)
	--

	UnLockDoor(GetDoorID("Door_Chapel_9"))
	OpenDoor(GetDoorID("Door_Chapel_9"))
	UnLockDoor(GetDoorID("Door_Chapel_10"))
	OpenDoor(GetDoorID("Door_Chapel_10"))
	UnLockDoor(GetDoorID("Door_Chapel_11"))
	OpenDoor(GetDoorID("Door_Chapel_11"))
	UnLockDoor(GetDoorID("Door_Chapel_12"))
	OpenDoor(GetDoorID("Door_Chapel_12"))
	UnLockDoor(GetDoorID("Door_Chapel_13"))
	OpenDoor(GetDoorID("Door_Chapel_13"))

	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_0"))
	CloseDoor(GetDoorID("Door_Monastery_Floor3"))
	LockDoor(GetDoorID("Door_Monastery_Floor3"))
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

function SpeechShaiming0()
	MakeCharacterSpeak(GetCharacterID("Char_Hang_Shaiming_Chapel"),_idPlayer,"DIA_SPE_BOS_SHAIMING_COMBAT_BAD_6",true,100,2,4,"SpeechShaiming1",0)
--	RadioMessage("DIA_SPE_BOS_SHAIMING_COMBAT_BAD_6", true, 100, 4,"SpeechShaiming1")
end

function SpeechShaiming1()
	MakeCharacterSpeak(GetCharacterID("Char_Hang_Shaiming_Chapel"),_idPlayer,"DIA_SPE_BOS_SHAIMING_COMBAT_BAD_5",true,100,2,0,"SpeechShaiming2",0)
--	RadioMessage("DIA_SPE_BOS_SHAIMING_COMBAT_BAD_5", true, 100, 0,"SpeechShaiming2")
end

function SpeechShaiming2()
	SetVarValue(GetCharacterID("Char_Hang_Shaiming_Chapel"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Shaiming_Chapel2"))
end

function TrackingCamTransition_Chapel_0a()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_0a"),GetCharacterID("Char_Hang_Shaiming_Chapel"))
end

function TrackingCamTransition_Chapel_0b()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_0b"),GetCharacterID("Char_Hang_Shaiming_Chapel"))
end

function CineIntroChapelSuite0()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_1"))
	Freeze(GetCharacterID("Char_Hang_Shaiming_Chapel"), true)
	Freeze(GetCharacterID("Char_Hang_Guard_Chapel1"), true)
	Freeze(GetCharacterID("Char_Hang_Guard_Chapel2"), true)
	Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_1"), false)
end

function CineIntroChapelSuite1()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_2"))
end

function CineIntroChapelSuite2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_3"))
	CreationTimer(true, true, false, "GrenadeursFousCine1",2)
end

function CineIntroChapelSuite3()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_4"))
end

function GrenadeursFousCine1()
		UnLockDoor(GetDoorID("Door_Monastery_Floor"))
		OpenDoor(GetDoorID("Door_Monastery_Floor"))
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1"), false)
end

function CineIntroChapelSuite5()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_6"))
--	EnableCharacterCommand(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1"),false)
end

function CineIntroChapelSuite6()
--	UnLockDoor(GetDoorID("Door_Chapel_9"))
--	OpenDoor(GetDoorID("Door_Chapel_9"))

	CloseDoor(GetDoorID("Door_Chapel_10"))
	LockDoor(GetDoorID("Door_Chapel_10"))
	CloseDoor(GetDoorID("Door_Chapel_11"))
	LockDoor(GetDoorID("Door_Chapel_11"))
	CloseDoor(GetDoorID("Door_Chapel_12"))
	LockDoor(GetDoorID("Door_Chapel_12"))
	CloseDoor(GetDoorID("Door_Chapel_13"))
	LockDoor(GetDoorID("Door_Chapel_13"))

	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_7"))
end

function CineIntroChapelSuite7()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_8"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_9"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Trooper_9b"))
end

function CineIntroChapelFin()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idMerc[0],true)
--	EnableCharacterFire(_idPlayer,false)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)	
	end
		CreationTimer(true, true, false, "ObjNettoyerChapel",1.5)
--	EnableCharacterCommand(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1"),true)
		--[[ TIMER MiniBOS ]]--
		CreationTimer(true, true, false, "ActiveChar_Monastery_Resist_Trooper_9",3)
end

function ObjNettoyerChapel()
	NewSubObjective ("Obj_B1","Obj_B2")
end

--[[ Action Chapel ]]--

-- MiniBoS 9

function ActiveChar_Monastery_Resist_Trooper_9()

	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_9"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_9"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
--	EnableCharacterFire(_idPlayer,true)
	SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_GrenadeurFou_1"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_GrenadeurFou_2"))
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"Active",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"ShieldMaxHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"ShieldHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"UseWeakPoint",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"ImmuneToBlowDamage",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"ImmuneToEffects",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"FxOnImpact","Fx\\Magnetic_shield_Orange_Impact.ifx")
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"FxLoop","Fx\\Magnetic_shield_Orange_2.ifx")
	CreationTimer(true, true, false, "ReActiveShield9",1)
	_bExpFTChar_Monastery_Resist_Trooper_9 = true
end

function ReActiveShield9()
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_9"),"Active",true)
	SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_9"), false)
end

function ExpFTChar_Monastery_Resist_Trooper_9()
	if (_bExpFTChar_Monastery_Resist_Trooper_9 == true) then 
		return true
	end
		return false
end

-- MiniBoS 13

function ActiveChar_Monastery_Resist_Trooper_13()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_1")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_9"))
	and (_bCtrlActiveChar_Monastery_Resist_Trooper_13 == false)
	) then
		CreationTimer(true, true, false, "DeclencheChar_Monastery_Resist_Trooper_13",3)
		_bCtrlActiveChar_Monastery_Resist_Trooper_13 = true
	end
end

function DeclencheChar_Monastery_Resist_Trooper_13()
		UnLockDoor(GetDoorID("Door_Chapel_13"))
		OpenDoor(GetDoorID("Door_Chapel_13"))
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_1"), false)
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_2"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_1"),false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_2"),false)
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Trooper_13b"))
		ReleaseSingleRigidBodyInBox("SE_Char_Monastery_Resist_Trooper_13")
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_9"))
		ShowCinematicBlackStripes(true)
		-- Player
		EnableCharacterCommand(_idPlayer,false)
--		EnableCharacterFire(_idPlayer,false)
		if (IsEntityInBox(_idPlayer,"SE_Char_Monastery_Resist_Trooper_13")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door1")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door2")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		end
		-- Mercs
		EnableCharacterCommand(_idMerc[0],false)
		EnableCharacterFire(_idMerc[0],false)
		if (IsEntityInBox(_idMerc[0],"SE_Char_Monastery_Resist_Trooper_13")) then
			Teletransportation("Char_Repere_Merc0_Chapel",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			EnableCharacterFire(_idMerc[1],false)
			if (IsEntityInBox(_idMerc[1],"SE_Char_Monastery_Resist_Trooper_13")) then
				Teletransportation("Char_Repere_Merc1_Chapel",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
		end
--		if (IsEntityInBox(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"),"SE_Char_Monastery_Resist_Trooper_13")) then
--			ReleaseEntity(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"))
--		end
end

function EndCineChar_Monastery_Resist_Trooper_13()
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_13"),false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
	end
	ShowCinematicBlackStripes(false)
	--[[ TIMER MiniBOS ]]--
	CreationTimer(true, true, false, "FIGHTChar_Monastery_Resist_Trooper_13",3)
end

function FIGHTChar_Monastery_Resist_Trooper_13()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_13"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_13"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
--	EnableCharacterFire(_idPlayer,true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_1"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_2"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_13"),true)
	EnableCharacterFire(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[1],true)
	end
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"Active",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"ShieldMaxHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"ShieldHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"UseWeakPoint",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"ImmuneToBlowDamage",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"ImmuneToEffects",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"FxOnImpact","Fx\\Magnetic_shield_Orange_Impact.ifx")
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"FxLoop","Fx\\Magnetic_shield_Orange_2.ifx")
	CreationTimer(true, true, false, "ReActiveShield13",1)
	_bExpFTChar_Monastery_Resist_Trooper_13 = true
end

function ReActiveShield13()
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_13"),"Active",true)
	SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_13"), false)
end

function ExpFTChar_Monastery_Resist_Trooper_13()
	if (_bExpFTChar_Monastery_Resist_Trooper_13 == true) then 
		return true
	end
		return false
end

-- MiniBoS 11

function ActiveChar_Monastery_Resist_Trooper_11()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_1")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_2")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_13"))
	and (_bCtrlActiveChar_Monastery_Resist_Trooper_11 == false)
	) then
		CreationTimer(true, true, false, "DeclencheChar_Monastery_Resist_Trooper_11",3)
		_bCtrlActiveChar_Monastery_Resist_Trooper_11 = true
	end
end

function TrackingCamTransition_Chapel_10()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_12"),GetCharacterID("Char_Monastery_Resist_Trooper_11"))
end

function TrackingCamTransition_Chapel_10b()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_12b"),GetCharacterID("Char_Monastery_Resist_Trooper_11"))
end

function TrackingCamTransition_Chapel_10c()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_13"),GetCharacterID("Char_Monastery_Resist_Trooper_11"))
end

function CineCamTransition_Chapel_10b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_10b"))
end

function DeclencheChar_Monastery_Resist_Trooper_11()
	UnLockDoor(GetDoorID("Door_Chapel_11"))
	OpenDoor(GetDoorID("Door_Chapel_11"))
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_3"), false)
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_2"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_3"),false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_2"),false)
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_11"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Trooper_11b"))
		ReleaseSingleRigidBodyInBox("SE_Char_Monastery_Resist_Trooper_11")
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_10"))
		ShowCinematicBlackStripes(true)
		-- Player
		EnableCharacterCommand(_idPlayer,false)
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
--		EnableCharacterFire(_idPlayer,false)
		if (IsEntityInBox(_idPlayer,"SE_Char_Monastery_Resist_Trooper_11")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door1")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door2")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		end
		-- Mercs
		EnableCharacterCommand(_idMerc[0],false)
		EnableCharacterFire(_idMerc[0],false)
		if (IsEntityInBox(_idMerc[0],"SE_Char_Monastery_Resist_Trooper_11")) then
			Teletransportation("Char_Repere_Merc0_Chapel",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			EnableCharacterFire(_idMerc[1],false)
			if (IsEntityInBox(_idMerc[1],"SE_Char_Monastery_Resist_Trooper_11")) then
				Teletransportation("Char_Repere_Merc1_Chapel",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
		end
--		if (IsEntityInBox(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"),"SE_Char_Monastery_Resist_Trooper_13")) then
--			ReleaseEntity(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"))
--		end
end

function EndCineChar_Monastery_Resist_Trooper_11()
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_11"),false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
	end
	ShowCinematicBlackStripes(false)
	--[[ TIMER MiniBOS ]]--
	CreationTimer(true, true, false, "FIGHTChar_Monastery_Resist_Trooper_11",3)
end

function FIGHTChar_Monastery_Resist_Trooper_11()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_11"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_11"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
--	EnableCharacterFire(_idPlayer,true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_3"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_2"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_11"),true)
	EnableCharacterFire(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[1],true)
	end
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"Active",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"ShieldMaxHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"ShieldHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"UseWeakPoint",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"ImmuneToBlowDamage",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"ImmuneToEffects",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"FxOnImpact","Fx\\Magnetic_shield_Orange_Impact.ifx")
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"FxLoop","Fx\\Magnetic_shield_Orange_2.ifx")
	CreationTimer(true, true, false, "ReActiveShield11",1)
	_bExpFTChar_Monastery_Resist_Trooper_11 = true
end

function ReActiveShield11()
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_11"),"Active",true)
	SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_11"), false)
end

function ExpFTChar_Monastery_Resist_Trooper_11()
	if (_bExpFTChar_Monastery_Resist_Trooper_11 == true) then 
		return true
	end
		return false
end

-- MiniBoS 12

function ActiveChar_Monastery_Resist_Trooper_12()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_3")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_2")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_11"))
	and (_bCtrlActiveChar_Monastery_Resist_Trooper_12 == false)
	) then
		CreationTimer(true, true, false, "DeclencheChar_Monastery_Resist_Trooper_12",3)
		_bCtrlActiveChar_Monastery_Resist_Trooper_12 = true
	end
end

function TrackingCamTransition_Chapel_11()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_14"),GetCharacterID("Char_Monastery_Resist_Trooper_12"))
end

function TrackingCamTransition_Chapel_11b()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_14b"),GetCharacterID("Char_Monastery_Resist_Trooper_12"))
end

function TrackingCamTransition_Chapel_11c()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_15"),GetCharacterID("Char_Monastery_Resist_Trooper_12"))
end

function CineCamTransition_Chapel_11b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_11b"))
end

function DeclencheChar_Monastery_Resist_Trooper_12()
	UnLockDoor(GetDoorID("Door_Chapel_12"))
	OpenDoor(GetDoorID("Door_Chapel_12"))
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_2"), false)
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_4"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_2"),false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_4"),false)
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Trooper_12b"))
		ReleaseSingleRigidBodyInBox("SE_Char_Monastery_Resist_Trooper_12")
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_11"))
		ShowCinematicBlackStripes(true)
		-- Player
		EnableCharacterCommand(_idPlayer,false)
--		EnableCharacterFire(_idPlayer,false)
		if (IsEntityInBox(_idPlayer,"SE_Char_Monastery_Resist_Trooper_12")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door1")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door2")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		end
		-- Mercs
		EnableCharacterCommand(_idMerc[0],false)
		EnableCharacterFire(_idMerc[0],false)
		if (IsEntityInBox(_idMerc[0],"SE_Char_Monastery_Resist_Trooper_12")) then
			Teletransportation("Char_Repere_Merc0_Chapel",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			EnableCharacterFire(_idMerc[1],false)
			if (IsEntityInBox(_idMerc[1],"SE_Char_Monastery_Resist_Trooper_12")) then
				Teletransportation("Char_Repere_Merc1_Chapel",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
		end
--		if (IsEntityInBox(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"),"SE_Char_Monastery_Resist_Trooper_13")) then
--			ReleaseEntity(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"))
--		end
end

function EndCineChar_Monastery_Resist_Trooper_12()
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_12"),false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
	end
	ShowCinematicBlackStripes(false)
	--[[ TIMER MiniBOS ]]--
	CreationTimer(true, true, false, "FIGHTChar_Monastery_Resist_Trooper_12",3)
end

function FIGHTChar_Monastery_Resist_Trooper_12()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_12"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_12"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
--	EnableCharacterFire(_idPlayer,true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_2"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_4"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_12"),true)
	EnableCharacterFire(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[1],true)
	end
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"Active",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"ShieldMaxHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"ShieldHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"UseWeakPoint",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"ImmuneToBlowDamage",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"ImmuneToEffects",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"FxOnImpact","Fx\\Magnetic_shield_Orange_Impact.ifx")
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"FxLoop","Fx\\Magnetic_shield_Orange_2.ifx")
	CreationTimer(true, true, false, "ReActiveShield12",1)
	_bExpFTChar_Monastery_Resist_Trooper_12 = true
end

function ReActiveShield12()
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_12"),"Active",true)
	SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_12"), false)
end

function ExpFTChar_Monastery_Resist_Trooper_12()
	if (_bExpFTChar_Monastery_Resist_Trooper_12 == true) then 
		return true
	end
		return false
end

-- MiniBoS 10

function ActiveChar_Monastery_Resist_Trooper_10()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_2")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_4")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_12"))
	and (_bCtrlActiveChar_Monastery_Resist_Trooper_10 == false)
	) then
		CreationTimer(true, true, false, "DeclencheChar_Monastery_Resist_Trooper_10",3)
		_bCtrlActiveChar_Monastery_Resist_Trooper_10 = true
	end
end

function TrackingCamTransition_Chapel_12()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_16"),GetCharacterID("Char_Monastery_Resist_Trooper_10"))
end

function TrackingCamTransition_Chapel_12b()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_17"),GetCharacterID("Char_Monastery_Resist_Trooper_10"))
end

function TrackingCamTransition_Chapel_12c()
		CamPointTargetCharacter(GetCamPointID("CamPoint_Chapel_18"),GetCharacterID("Char_Monastery_Resist_Trooper_10"))
end

function CineCamTransition_Chapel_12b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_12b"))
end

function DeclencheChar_Monastery_Resist_Trooper_10()
	UnLockDoor(GetDoorID("Door_Chapel_10"))
	OpenDoor(GetDoorID("Door_Chapel_10"))
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3"), false)
		Freeze(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5"), false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3"),false)
		EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5"),false)
		SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_Char_Monastery_Resist_Trooper_10b"))
		ReleaseSingleRigidBodyInBox("SE_Char_Monastery_Resist_Trooper_12")
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Chapel_12"))
		ShowCinematicBlackStripes(true)
		-- Player
		EnableCharacterCommand(_idPlayer,false)
--		EnableCharacterFire(_idPlayer,false)
		if (IsEntityInBox(_idPlayer,"SE_Char_Monastery_Resist_Trooper_10")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door1")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		elseif (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door2")) then
			Teletransportation("Char_Repere_Player_Chapel",_idPlayer)
		end
		-- Mercs
		EnableCharacterCommand(_idMerc[0],false)
		EnableCharacterFire(_idMerc[0],false)
		if (IsEntityInBox(_idMerc[0],"SE_Char_Monastery_Resist_Trooper_10")) then
			Teletransportation("Char_Repere_Merc0_Chapel",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			EnableCharacterFire(_idMerc[1],false)
			if (IsEntityInBox(_idMerc[1],"SE_Char_Monastery_Resist_Trooper_10")) then
				Teletransportation("Char_Repere_Merc1_Chapel",_idMerc[1])
				EnableCharacterCommand(_idMerc[1],false)	
			end
		end
--		if (IsEntityInBox(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"),"SE_Char_Monastery_Resist_Trooper_13")) then
--			ReleaseEntity(GetSingle_Rigid_BodyID("Single_Rigid_Body-127"))
--		end
end

function EndCineChar_Monastery_Resist_Trooper_10()
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_10"),false)
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterCommand(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1],true)
	end
	ShowCinematicBlackStripes(false)
	--[[ TIMER MiniBOS ]]--
	CreationTimer(true, true, false, "FIGHTChar_Monastery_Resist_Trooper_10",3)
end

function FIGHTChar_Monastery_Resist_Trooper_10()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_10"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_10"),"CharacterAI",GetCharacter_AIID("Char_AI_Spe_UAN_MiniBoS"))
--	EnableCharacterFire(_idPlayer,true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5"),true)
	EnableCharacterFire(GetCharacterID("Char_Monastery_Resist_Trooper_10"),true)
	EnableCharacterFire(_idMerc[0],true)
	if (_idMerc[1] ~= nil) then
		EnableCharacterFire(_idMerc[1],true)
	end
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"Active",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"ShieldMaxHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"ShieldHealth",700)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"UseWeakPoint",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"ImmuneToBlowDamage",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"ImmuneToEffects",false)
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"FxOnImpact","Fx\\Magnetic_shield_Orange_Impact.ifx")
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"FxLoop","Fx\\Magnetic_shield_Orange_2.ifx")
	CreationTimer(true, true, false, "ReActiveShield10",1)
	_bExpFTChar_Monastery_Resist_Trooper_10 = true
end

function ReActiveShield10()
	SetVarValue(GetPlug_MagneticShieldID("PMS_Char_Monastery_Resist_Trooper_10"),"Active",true)
	SetGodMode(GetCharacterID("Char_Monastery_Resist_Trooper_10"), false)
end

function ExpFTChar_Monastery_Resist_Trooper_10()
	if (_bExpFTChar_Monastery_Resist_Trooper_10 == true) then 
		return true
	end
		return false
end

function Player_Chapel_Etage()
	if (IsEntityInBox(_idPlayer,"SE_Chapel_Player_Etage")) then
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Frag_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_1"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_2"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_3"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_4"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
		SetVarValue(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	end
end

function Security_Chapel_Door1()
	if ((IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door1")) and (_bSequenceChapelActive == true)) then
		CloseDoor(GetDoorID("Door_Monastery_Floor8"))
		LockDoor(GetDoorID("Door_Monastery_Floor8"))
	else
		UnLockDoor(GetDoorID("Door_Monastery_Floor8"))
	end
end

function Security_Chapel_Door2()
	if ((IsEntityInBox(_idPlayer,"SE_Chapel_Player_Door2")) and (_bSequenceChapelActive == true)) then
		CloseDoor(GetDoorID("Door_Monastery_Floor"))
		LockDoor(GetDoorID("Door_Monastery_Floor"))
	else
		UnLockDoor(GetDoorID("Door_Monastery_Floor"))
	end
end

-- Active Obj

function ActiveObjReachRoof()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_10"))
	and (_bCtrlActiveObjReachRoof == false)
	) then
		CreationTimer(true, true, false, "ObjReachRoof",3)
		_bCtrlActiveObjReachRoof = true
	end
end

function ObjReachRoof()
	NewSubObjective ("Obj_B2","Obj_B3")
	SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
end


--[[ Fond Monastery ]]--

-- Etage
function OnEnter_SE_Room_2Floor_1(id)
	if ((id == _idPlayer) and (_bSequenceChapelActive == false) and (_bCtrlSE_Room_2Floor_1_2 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor1"), false)
		CreationTimer(true, true, false, "AIOLGrp_Monastery_MiniBoS_2Floor1",8)
		_bCtrlSE_Room_2Floor_1_2 = true
	end
end

function OnEnter_SE_Room_2Floor_2(id)
	if ((id == _idPlayer) and (_bSequenceChapelActive == false) and (_bCtrlSE_Room_2Floor_1_2 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor1"), false)
		CreationTimer(true, true, false, "AIOLGrp_Monastery_MiniBoS_2Floor1",8)
		_bCtrlSE_Room_2Floor_1_2 = true
	end
end

function AIOLGrp_Monastery_MiniBoS_2Floor1()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_14"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_15"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

-- RDC
function OnEnter_SE_Room_1Floor_1(id)
	if ((id == _idPlayer) and (_bSequenceChapelActive == false) and (_bCtrlSE_Room_1Floor_1_2 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor2"), false)
		CreationTimer(true, true, false, "AIOLGrp_Monastery_MiniBoS_2Floor2",10)
		_bCtrlSE_Room_1Floor_1_2 = true
	end
end

function OnEnter_SE_Room_1Floor_2(id)
	if ((id == _idPlayer) and (_bSequenceChapelActive == false) and (_bCtrlSE_Room_1Floor_1_2 == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor2"), false)
		CreationTimer(true, true, false, "AIOLGrp_Monastery_MiniBoS_2Floor2",10)
		_bCtrlSE_Room_1Floor_1_2 = true
	end
end

function AIOLGrp_Monastery_MiniBoS_2Floor2()
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_16"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
	SetVarValue(GetCharacterID("Char_Monastery_Resist_Trooper_17"),"CharacterOrderList",GetAI_Order_ListID("AIOL_FA_Player"))
end

--[[ Couloir Etage Monastery ]]--

function ActiveCouloir_Etage_Monastery()
	if (
	not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Acid_3")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_GrenadeurFou_Halu_5")) 
	and not IsAlive(GetCharacterID("Char_Monastery_Resist_Trooper_10"))
	and (_bCtrlActiveCouloir_Etage_Monastery == false)
	) then
		CreationTimer(true, true, false, "DeclencheCouloir_Etage_Monastery",3)
		_bCtrlActiveCouloir_Etage_Monastery = true
	end
end

function DeclencheCouloir_Etage_Monastery()
	_bSequenceChapelActive = false
	_bActiveCouloir = true
	UnLockDoor(GetDoorID("Door_Monastery_Floor"))
	UnLockDoor(GetDoorID("Door_Monastery_Floor5"))
	UnLockDoor(GetDoorID("Door_Monastery_Floor7"))
	UnLockDoor(GetDoorID("Door_Monastery_Floor8"))
end

function SE_ActivCouloir()
	if (IsEntityInBox(_idPlayer,"SE_ActivCouloir") and (_bCtrlSE_ActivCouloir == false) and (_bActiveCouloir == true)) then
		-- Order List Ingénieur qui va hacker la porte
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AIOL_Inge_ActivCouloir_Monastery"))
		NewSubObjective ("Obj_B3","Obj_B4")
		_bCtrlSE_ActivCouloir = true
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
				StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic(
	end
end

function TimerMonastery_ActivCouloir()
	CreationTimer(true, true, false, "DefriseMonastery_ActivCouloir",3)
end

function DefriseMonastery_ActivCouloir()
		UnLockDoor(GetDoorID("Door_Monastery_Floor1"))
		OpenDoor(GetDoorID("Door_Monastery_Floor1"))
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_Snipers"), false)
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor3"), false)

		SetVarValue(GetObjectiveID("Obj_W1"),"Active",false)
		NewSubObjective ("Obj_B4","Obj_B5")
		_bIngeMustNotDie = false
end

function ActiveGrp_Monastery_MiniBoS_2Floor4_5()
	_nAliveGrp_Monastery_MiniBoS_2Floor3 = AliveMembersCount(GetGroupID("Grp_Monastery_MiniBoS_2Floor3"))
	if ((_nAliveGrp_Monastery_MiniBoS_2Floor3 == 0) and (_bCtrlAliveGrp_Monastery_MiniBoS_2Floor3 == false) and (_bPlayerPasseCouloir == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor4"), false)
		_bCtrlAliveGrp_Monastery_MiniBoS_2Floor3 = true
	end
	_nAliveGrp_Monastery_MiniBoS_2Floor4 = AliveMembersCount(GetGroupID("Grp_Monastery_MiniBoS_2Floor4"))
	if ((_nAliveGrp_Monastery_MiniBoS_2Floor4 == 0) and (_bCtrlAliveGrp_Monastery_MiniBoS_2Floor4 == false) and (_bPlayerPasseCouloir == false)) then
		FreezeAll(GetGroupID("Grp_Monastery_MiniBoS_2Floor5"), false)
		_bCtrlAliveGrp_Monastery_MiniBoS_2Floor4 = true
	end
end

function OnEnter_SE_EndCouloir(id)
	if (id == _idPlayer) then
		_bPlayerPasseCouloir = true
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
