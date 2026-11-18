function UpdateLevel_Grotte ()
	Spawn_Grotte ()
	Open_Cave_Door_02 ()
	Champion_Arrive_01 ()
end


function OnEnter_Sector_Event_Grotte_E_00(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Grotte_E_00 == 0) then
			FreezeAll(GetGroupID("Group_Grotte_UAN_01"), false)
			StopMusic()
			StartMusic("Sounds//Music//Bos - War theme.wav",false)
			_bOnEnter_Sector_Event_Grotte_E_00 = 1
		end
	end
end

function Spawn_Grotte ()
--_bSpawnNumber = 

--	if not IsEntityInBox(_idPlayer,"Sector_Event_Grotte_A_00")
		if(AliveMembersCount(GetGroupID("Group_Grotte_UAN_01")) <= 3 )then
			if not IsEntityInBox(_idPlayer,"Sector_Event_Grotte_A_00")then
				FreezeAll(GetGroupID("Group_Grotte_UAN_02"), false)
			else
				FreezeAll(GetGroupID("Group_Grotte_UAN_03"), false)
			end	
		end
		if(( AliveMembersCount(GetGroupID("Group_Grotte_UAN_02"))
			+ AliveMembersCount(GetGroupID("Group_Grotte_UAN_03"))) <= 3) then
				if not IsEntityInBox(_idPlayer,"Sector_Event_Grotte_A_00")then
					FreezeAll(GetGroupID("Group_Grotte_UAN_05"), false)
				else
					FreezeAll(GetGroupID("Group_Grotte_UAN_04"), false)
				end
		end
--	end
end


function Champion_Arrive_01 ()
	if(((AliveMembersCount(GetGroupID("Group_Grotte_UAN_01")))
	+ (AliveMembersCount(GetGroupID("Group_Grotte_UAN_02")))
	+ (AliveMembersCount(GetGroupID("Group_Grotte_UAN_03")))
	+ (AliveMembersCount(GetGroupID("Group_Grotte_UAN_04")))
	+ (AliveMembersCount(GetGroupID("Group_Grotte_UAN_05"))))
	<= 0 )then
		if not IsEntityInBox(_idPlayer,"Sector_Event_Grotte_D_00") then
			if 	(_bDefreeze_BOS	== 0)then
			SetVarValue(GetTimerID("Timer_Champion_Arrive"),"Active",true)
			_bDefreeze_BOS	= 1
			end
		end
	end
end


function Champion_Arrive_02 ()
	Freeze(_idChampion_0, false)
	UnLockDoor(GetDoorID("Door_01"))
	OpenDoor(GetDoorID("Door_01"))
	
	LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
	EnableCharacterCommand(_idPlayer, false)
	EnableCharacterFire(_idChampion_0, false)
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], false)
	end
end






-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------




-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_01 ()	
		LockDoor(GetDoorID("Door_01"))
		CloseDoor(GetDoorID("Door_01"))
		g_bBoSEnCours = true
		StopMusic()
		LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat","Champion_0_OnTimeOut","Champion_0_OnTimeOut","Champion_0_OnTimeOut")
end


function Champion_0_Setup ()
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Repere_Merc_1",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Repere_Merc_2",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1],true)
	end
end

function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	EnableCharacterCommand(_idChampion_0, true)
EnableCharacterFire(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_0_OnTimeOut()
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0], false)
		EnableCharacterCommand(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], false)
		EnableCharacterCommand(_idMerc[1], true)
	end
	SetVarValue(GetTimerID("Timer_Grotte_A_00"),"Active",true)
	Freeze(_idChampion_0, true)
	_bBoS_Done = 1
	g_bBoSEnCours = false
	StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)
end



-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------


-- L'ingé va près de la porte
function 	Open_Cave_Door_01 ()
	if (_bInge_Go_Cave_Door == 0) then
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Grotte_B_00"))
		MakeCharacterSpeak(_idMerc[0],_idPlayer, "DIA_SPE_NIV_E_INGENIEUR_07",true,110,2, 0, "",21)
		_bInge_Go_Cave_Door = 1
	end
end

function 	Open_Cave_Door_02 ()
	if (_bInge_Go_Cave_Door == 1)
	and (_bCave_Door_Is_Open ==0) then
		if IsEntityInBox(_idPlayer,"Sector_Event_Grotte_C_00")
		and IsEntityInBox(_idMerc[0],"Sector_Event_Grotte_C_00")then
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Waypoint_Grotte_C"))	
			MakeCharacterSpeak(_idMerc[0],_idPlayer, "DIA_SPE_NIV_E_INGENIEUR_05",true,110,2, 0, "",21)
			_bCave_Door_Is_Open = 1
		end
	end
end


-- Declenchement de l'explosion
function OnEnter_Sector_Event_Grotte_C_01 (_idCharInBox)
	if (_idCharInBox == _idMerc[0]) then
		if (_bOnEnter_Sector_Event_Grotte_C_01 == 0) then
			if (_bOnEnter_Sector_Event_Grotte_C_01 == 0)then 
			--	SetVarValue(GetTimerID("Timer_Explosion_Cave_Door"),"Active",true)
			_bOnEnter_Sector_Event_Grotte_C_01 = 1
			end
		end
	end
end

-- Explosion
function Cave_Door_Explosion ()
--	UnLockDoor(GetDoorID("Door_01"))
--	UnLockDoor(GetDoorID("Door_02"))	
--	idexplosion = CreateExplosion ()
--	SetVarValue(idexplosion,"Position",Vector3D(-597,-266,-60))
--	SetVarValue(idexplosion,"Type","Explosion_Rocket_A")
--	FreezeAll(GetGroupID("Group_Suite_UAN_01"), false)
end




-- Declenchement de l'explosion
function OnEnter_Sector_Event_Field_H_01 (_idCharInBox)
	if (_idCharInBox == _idMerc[0]) then
		if (_bC4_First_Door_Placed == 1) then
			if (_bOnSector_Event_Field_H_01 == 0)then 
		--	SetVarValue(GetTimerID("Timer_Start_C4"),"Active",true)
			_bOnSector_Event_Field_H_01 = 1
			end
		end
	end
end




function Ouverture_Code_A_Sound ()
	CreationTimer(true,true,false,"Ouverture_Code_B_Sound",1.0)
end

function Ouverture_Code_B_Sound ()
	SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",true)
	CreationTimer(true,true,false,"Ouverture_Door",4.0)
end

function Ouverture_Door ()
	SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",false)
	SetVarValue(GetDoorID("Door_01"),"Locked",false)
	OpenDoor(GetDoorID("Door_01"))
	StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)
	FreezeAll(GetGroupID("Group_Suite_UAN_01"), false)
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_EMPTY"))
end


