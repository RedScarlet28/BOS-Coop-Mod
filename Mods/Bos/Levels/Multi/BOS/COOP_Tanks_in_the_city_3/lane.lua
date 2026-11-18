function UpdateLevel_Lane()
	Calcul_Defreeze_Lane ()
	Defreeze_BOS_00 ()
end


function OnExit_Sector_Event_Lane_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		_bExitFromStart = 1
	end
end


function Calcul_Defreeze_Lane ()
--[[
	_nBotGlobalActifs = GetTotalActiveCharacterCount()

	if (_nSpawnHide < 2)then
		_nBotWRFActifs = 3
	else
		_nBotWRFActifs = 6
	end

	if (_idMerc[0] == nil) 
	or not IsAlive (_idMerc[0]) then
		_nBotWRFActifs = 	_nBotWRFActifs - 1
	end
	if (_idMerc[1] == nil) 
	or not IsAlive (_idMerc[1]) then
		_nBotWRFActifs = 	_nBotWRFActifs - 1
	end



	_nBotUANActifs = (_nBotGlobalActifs - _nBotWRFActifs)
]]--
	Defreeze_Lane ()	
end


function Defreeze_Lane ()
	if (_bExitFromStart== 1)then

		if (_nSpawnHide == 0)then
			if IsEntityInBox(_idPlayer,"Sector_Event_Lane_Secto_1")then	
				FreezeAll(GetGroupID("Group_UAN_Lane_A_1"),false)
			else
				FreezeAll(GetGroupID("Group_UAN_Lane_A_2"),false)
			end
			_nSpawnHide = 1
			return
		end

		if (_nSpawnHide == 1)then
			if (AliveMembersCount(GetGroupID("Group_UAN_Lane_A_1")) <= 1)
			or (AliveMembersCount(GetGroupID("Group_UAN_Lane_A_2")) <= 1) then
				if IsEntityInBox(_idPlayer,"Sector_Event_Lane_Secto_1")then	
					FreezeAll(GetGroupID("Group_UAN_Lane_B_1"),false)
				else
					FreezeAll(GetGroupID("Group_UAN_Lane_B_2"),false)
				end
				_nSpawnHide = 2
				return
			end
		end

		if (_nSpawnHide == 2)then
			if (AliveMembersCount(GetGroupID("Group_UAN_Lane_B_1")) <= 1)
			or (AliveMembersCount(GetGroupID("Group_UAN_Lane_B_2")) <= 1) then
				if IsEntityInBox(_idPlayer,"Sector_Event_Lane_Secto_1")then	
					FreezeAll(GetGroupID("Group_UAN_Lane_c_1"),false)
				else
					FreezeAll(GetGroupID("Group_UAN_Lane_C_2"),false)
				end
				--FreezeAll(GetGroupID("Group_UAN_Lane_E"),false)
				_nSpawnHide = 3
				return
			end
		end


		if (_nSpawnHide == 3)then
			if (AliveMembersCount(GetGroupID("Group_UAN_Lane_c_1")) <= 1)
			or (AliveMembersCount(GetGroupID("Group_UAN_Lane_C_2")) <= 1) then
				if IsEntityInBox(_idPlayer,"Sector_Event_Lane_Secto_1")then	
					FreezeAll(GetGroupID("Group_UAN_Lane_D_1"),false)
				else
					FreezeAll(GetGroupID("Group_UAN_Lane_D_2"),false)
				end
				CreationTimer(true,true,false,"SpawnEnd",2.5)
				_nSpawnHide = 4
				return
			end
		end

	end
end

function SpawnEnd ()
	_nSpawnHide = 4
end


function OnEnter_Sector_Event_Lane_B_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) 
	and (_nSpawnHide == 4)then --- attention debug!! good == 4
		StartMusic("Sounds//Music//BoS - Little theme.wav",false)
		Freeze(_idChampion_0, false)
		EnableCharacterCommand(_idChampion_0, true)
		CharacterPlaySpecialAction(_idChampion_0, "STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL",true,false)
		SetGodMode(_idChampion_0,true)
		EnableCharacterCommand(_idPlayer, false)
		ShowCinematicBlackStripes(true)
		LaunchCameraTransition(GetCamTransitionID("CamTransition_B"))
		Freeze(GetCharacterID("Char_Synd_01"),false)
		CharacterPlaySpecialAction(GetCharacterID("Char_Synd_01"), "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
		Freeze(GetCharacterID("Char_Synd_02"),false)
		CharacterPlaySpecialAction(GetCharacterID("Char_Synd_02"), "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
		Freeze(GetCharacterID("Char_Synd_03"),false)
		CharacterPlaySpecialAction(GetCharacterID("Char_Synd_03"), "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
		Teletransportation("Char_Champion_0_Repere_Player_1",_idPlayer)
		_nSpawnHide = 5
	end
end

function Cine_Bos_0()
	EnableCharacterCommand(_idPlayer, true)
	ShowCinematicBlackStripes(false)
end


-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_00 ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Lane_B_00")
	and (_nSpawnHide == 5) then
		if (_bDefreeze_Defreeze_BOS_00 == 0) then	
			CharacterStopSpecialAction(_idChampion_0)
			StopMusic()
			LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut") 
			g_bBoSEnCours = true
			_bDefreeze_Defreeze_BOS_00 = 1
		end
	end
end




function Champion_0_Setup()
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
	EnableCharacterCommand(_idPlayer, false)
	SetGodMode(_idChampion_0,false)

	if (_idMerc[0] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])
		Freeze(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])
		Freeze(_idMerc[1], true)
	end
end

function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
	SetVarValue(GetPlug_PulseID("Plug_Pulse_Champion_0_3"),"Active",true)
end

function Champion_0_OnTimeOut()
	Freeze(_idChampion_0,true)
	Freeze(GetCharacterID("Char_Synd_01"),true)
	Freeze(GetCharacterID("Char_Synd_02"),true)
	Freeze(GetCharacterID("Char_Synd_03"),true)
	OpenDoor(GetDoorID("Door_Champion_00"))
	OpenDoor(GetDoorID("Door_Champion_02"))
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0], false)
		EnableCharacterCommand(_idMerc[0], true)
	end

	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], false)
		EnableCharacterCommand(_idMerc[1], true)
	end
	g_bBoSEnCours = false
	_bBoS_Done_00 = 1
end