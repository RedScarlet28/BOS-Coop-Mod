function UpdateLevel_Suite ()

	Defreeze_Group_Suite_UAN_02 ()
	BigBoyExplo_Test()

end



function Defreeze_Group_Suite_UAN_02 ()
	if (_bDefreeze_Group_Suite_UAN_02 == 0) then
		if (AliveMembersCount(GetGroupID("Group_Suite_UAN_01"))<= 3 )
		or (IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_00")== true )then
			FreezeAll(GetGroupID("Group_Suite_UAN_02"), false)	
			_bDefreeze_Group_Suite_UAN_02 = 1
		end
	end
end

function OnEnter_Sector_Event_Suite_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_A_01 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_03"), false)
			_bOnEnter_Sector_Event_Suite_A_01 = 1
		end
	end
end

function OnEnter_Sector_Event_Suite_A_02 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_A_02 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_04"), false)
			StartMusic("Sounds//Music//Bos - War theme.wav",true)
			_bOnEnter_Sector_Event_Suite_A_02 = 1
		end
	end
end


function OnEnter_Sector_Event_Suite_A_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_A_03 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_05"), false)
			_bOnEnter_Sector_Event_Suite_A_03 = 1
		end
	end
end

function OnEnter_Sector_Event_Suite_A_05 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_A_05 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_06"), false)

		

			_bOnEnter_Sector_Event_Suite_A_05 = 1
		end
	end
end

function OnEnter_Sector_Event_Suite_A_04 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_A_04_A == 0) then
			Defreeze_BOS2_02 ()
			CloseDoor(GetDoorID("Door_05"))
			_bOnEnter_Sector_Event_Suite_A_04_A = 1
		end
		if (_bOnEnter_Sector_Event_Suite_A_04_B == 0) 
		and (_bBOS_2_DONE == 1) then
			SetVarValue(GetTimerID("Timer_Suite_A_00"),"Active",true)	
			_bOnEnter_Sector_Event_Suite_A_04_B = 1
		end
	end
end


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------


function Defreeze_BOS2_02 ()	
	FreezeAllCharactersButBetters()
	Teletransportation("Char_Champion_1_Repere_Player",_idPlayer)
	Freeze(GetCharacterID("Char_Champion_CINE"), false)
	EnableCharacterCommand(_idChampion_1, false)
	EnableCharacterCommand(_idPlayer, false)
	CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_C"))
	ShowCinematicBlackStripes(true)
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Repere_Merc_5",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Repere_Merc_6",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1], true)
	end
end


function Champion_2_CINE_SUITE ()
	Freeze(GetCharacterID("Char_Champion_CINE"), true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_D"))
end

function Champion_2_CINE_SUITE_2 ()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_B"))
	Freeze(_idChampion_1, false)
	CreationTimer(true,true,false,"Champion_2_CINE_SUITE_2_Anim",3.0)	
	CharacterPlaySpecialAction(_idChampion_1, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
end

function Champion_2_CINE_SUITE_2_Anim ()
	CharacterStopSpecialAction(_idChampion_1)
	CharacterPlaySpecialAction(_idChampion_1, "STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT",false,false)
end

-- defreeze BOS
-- WARNING BOS --


function Defreeze_BOS2_01 ()	
	ShowCinematicBlackStripes(false)
	CharacterStopSpecialAction(_idPlayer)
	StopMusic()
	LaunchBOS(1,"Champion_1_Setup","Champion_1_WarmUp","Champion_1_Combat","Champion_1_OnTimeOut","Champion_1_OnTimeOut","Champion_1_OnTimeOut")
	g_bBoSEnCours = true
end


function Champion_1_Setup ()

end


function Champion_1_WarmUp()
	EnableCharacterCommand(_idChampion_1, false)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_1_Combat()
	EnableCharacterCommand(_idChampion_1, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_1_OnTimeOut()
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0], false)
		EnableCharacterCommand(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], false)
		EnableCharacterCommand(_idMerc[1], true)
	end
	Freeze(_idChampion_1,true)
	SetVarValue(GetDoorID("Door_04"),"Locked",false)
	OpenDoor(GetDoorID("Door_04"))
	_bBOS_2_DONE	= 1
	g_bBoSEnCours = false
end


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------



function Inge_Bomb_Big_Boy ()
	---- OBJECTIF Update
	NewSubObjective ( "Obj_A_1", "Obj_A_2")

	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Waypoint_Suite_B"))	
	MakeCharacterSpeak(_idMerc[0],_idPlayer, "DIA_SPE_NIV_E_INGENIEUR_12",true,110,2, 0, "",21)

	SetVarValue(GetDoorID("Door_04"),"Locked",false)--debug
	OpenDoor(GetDoorID("Door_04"))--debug

	_bInge_Bomb_Big_Boy = 1
end



function Plant_Explo_A ()
	CreationTimer(true,true,false,"Plant_Explo_B",2.5)
end

function Plant_Explo_B ()
	--SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"),"Active",true)
	PlantExplosive(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"))
	CreationTimer(true,true,false,"Plant_Explo_C",0.5)
	CreationTimer(true,true,false,"BigBoyExplo",30.0)
	CreationTimer(true,true,false,"BigBoyExploAlarma",8.0)
end

function Plant_Explo_C ()
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Waypoint_Suite_B3"))	
end



function OnEnter_Sector_Event_Suite_B_00 (_idCharInBox)
	if (_idCharInBox == _idMerc[0]) then
		if (_bOnEnter_Sector_Event_Suite_B_00 == 0) then
			if (_bInge_Bomb_Big_Boy == 1) then
						
			ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
			--SetVarValue ( GetObjectiveID ("Obj_B_a"),"Active", true )
			--SetVarValue ( GetObjectiveID ("Obj_B_b"),"Active", true )				

				MakeCharacterSpeak(_idMerc[0],_idPlayer, "DIA_SPE_NIV_E_INGENIEUR_13",true,110,2, 0, "",21)
				SetVarValue(GetTimerID("Timer_Suite_A_01"),"Active",true)
				_bOnEnter_Sector_Event_Suite_B_00 = 1
			end
		end
	end
end

function Inge_Flee ()
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite_C_00"))	
	FreezeAll(GetGroupID("Group_Suite_UAN_07"), false)
end

function BigBoyExploAlarma()
	SetVarValue(GetSound_ClientID("Sound_Client_Alarma"),"Playing",true)
	SetVarValue(GetDoorID("Door_04"),"Speed",2)
	CloseDoor(GetDoorID("Door_04"))
end

function BigBoyExplo_Test()
	if (_bBigBoyExplo == 1)
	and IsEntityInBox(_idPlayer,"Sector_Event_Suite_C_00") then
		if (_bBigBoyExplo_Test == 0) then
			Death()
			_bBigBoyExplo_Test = 1
		end
	end
end


function BigBoyExplo()
	CameraShake(5.2,3,3,3)
	SetVarValue(GetSound_ClientID("Sound_Client_EXPLO"),"Playing",true)
	_idExplosion_A = CreateExplosion()
	_vPosition_Explosion_A = GetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1020"),"Position")
	SetVarValue(_idExplosion_A,"Type","Explosion_Rocket_Tank") 
	SetVarValue(_idExplosion_A,"Position",_vPosition_Explosion_A)
	
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1020"),"FxState","Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1021"),"FxState","Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1022"),"FxState","Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1023"),"FxState","Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1024"),"FxState","Fx Started")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1025"),"FxState","Fx Started")
	CreationTimer(true,true,false,"BigBoyExplo_2",1.0)	
	_bBigBoyExplo = 1
end

function BigBoyExplo_2 ()
	SetVarValue(GetSound_ClientID("Sound_Client_EXPLO_2"),"Playing",true)
	_idExplosion_B = CreateExplosion()
	_vPosition_Explosion_B = GetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1021"),"Position")
	SetVarValue(_idExplosion_B,"Type","Explosion_Rocket_Tank") 
	SetVarValue(_idExplosion_B,"Position",_vPosition_Explosion_B)
	CreationTimer(true,true,false,"BigBoyExplo_3",1.5)
end

function BigBoyExplo_3 ()
	SetVarValue(GetSound_ClientID("Sound_Client_EXPLO_3"),"Playing",true)
	_idExplosion_C = CreateExplosion()
	_vPosition_Explosion_C = GetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1022"),"Position")
	SetVarValue(_idExplosion_C,"Type","Explosion_Rocket_Tank") 
	SetVarValue(_idExplosion_C,"Position",_vPosition_Explosion_C)
	CreationTimer(true,true,false,"BigBoyExplo_4",0.5)
end

function BigBoyExplo_4 ()
	SetVarValue(GetSound_ClientID("Sound_Client_EXPLO_4"),"Playing",true)
	_idExplosion_D = CreateExplosion()
	_vPosition_Explosion_D = GetVarValue(GetParticleFX_ClientID("ParticleFX_Client-1023"),"Position")
	SetVarValue(_idExplosion_D,"Type","Explosion_Rocket_Tank") 
	SetVarValue(_idExplosion_D,"Position",_vPosition_Explosion_D)
end


function Death()
	nLife_Player  = GetVarValue(_idPlayer,"Health")
	nLife_Player = 	(nLife_Player / 10)
	SetVarValue(_idPlayer,"Health",nLife_Player)
	_idExplosion = CreateExplosion()
	_vPosition_Player = GetVarValue(_idPlayer,"Position")
	SetVarValue(_idExplosion,"Type","Explosion_Rocket_Tank") 
	SetVarValue(_idExplosion,"Position",_vPosition_Player) 
end

function OnEnter_Sector_Event_Suite_B_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite_B_01 == 0) then
			CreationTimer(true,true,false,"EndOfBigBoy",7.5)
			SetVarValue(GetSound_ClientID("Sound_Client_Helico"),"Playing",true) 
			_bOnEnter_Sector_Event_Suite_B_01 = 1
		end
	end
end


function EndOfBigBoy()
		MissionSucceed ()
end