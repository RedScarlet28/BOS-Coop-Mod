function UpdateLevel_City1 ()
	if(_bObjectif_1_done == 1)then 
		if (_bObjectif_2_done == 0) then	
			Defreeze_Sniper_Building()
			MapTracking_Obj_B_2 ()
			Defreeze_BOS ()
			Defreeze_Group_UAN_City1_01()
			Defreeze_Group_UAN_City1_08()
			--Objectif_2_done()
		end
	end
end


-- defreeze dun groupe dans l'escalier
function OnEnter_Sector_Event_City1_B_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_City1_B_01 == 0) then
				if (_bObjectif_1_done == 1)then 
					FreezeAll(GetGroupID("Group_UAN_City1_07"), false)
					_bOnEnter_Sector_Event_City1_B_01 = 1
				end			
			end
	end
end

-- des groupes se battent dans la rue devant le building
function OnEnter_Sector_Event_City1_B_00(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			if (_bOnEnter_Sector_Event_City1_B_00 == 0) then
				if (_bObjectif_1_done == 1)then 
					FreezeAll(GetGroupID("Group_UAN_City1_06"), false)
					FreezeAll(GetGroupID("Group_WRF_City1_01"), false)
					Freeze (GetCharacterID("Char_PARA_FAKE_WRF_04"),false)
					CreationTimer(true,true,false,"Char_PARA_FAKE_WRF_04_Refreeze",20)
					_bOnEnter_Sector_Event_City1_B_00 = 1		
				end	
			end
	end
end


function Char_PARA_FAKE_WRF_04_Refreeze ()
	Freeze (GetCharacterID("Char_PARA_FAKE_WRF_04"),true)
end



-- Un sniper est defreezé dans l'enceinte du Building
function Defreeze_Sniper_Building()
		if (_bObjectif_1_done == 1)then
			if (_bDefreeze_Sniper_Building == 0)then
				Freeze(GetCharacterID("Char_UAN_City1_03_1"), false)
				_bDefreeze_Sniper_Building = 1
			end
		end
end


-- Un groupe UAN arrive depuis le building
-- NEW OBJ_B_2 -- HERE --
function OnEnter_Sector_Event_City1_A_01(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_City1_A_01 == 0) then
			if (_bObjectif_1_done == 1)then 
				Defreeze_Group_UAN_City1_01B ()
				NewSubObjective ( "Obj_B_1","Obj_B_2")
				_bOnEnter_Sector_Event_City1_A_01 = 1		
			end	
		end
	end
end

function MapTracking_Obj_B_2 ()
	if (_bOnEnter_Sector_Event_City1_A_01 == 1) and (_bDefreeze_Defreeze_BOS == 0) then
		if IsAlive(GetCharacterID("Char_UAN_City1_04_1"))then
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_1"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_1"),2, false)
		end
		if IsAlive(GetCharacterID("Char_UAN_City1_04_2"))then
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_2"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_2"),2, false)
		end
		if IsAlive(GetCharacterID("Char_UAN_City1_04_4"))then
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_4"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_City1_04_4"),2, false)
		end
		if IsAlive(GetCharacterID("Char_UAN_City1_03_1"))then
			MiniMapTrack(GetCharacterID("Char_UAN_City1_03_1"),2, true)
		else
			MiniMapTrack(GetCharacterID("Char_UAN_City1_03_1"),2, false)
		end
	end
end



function Defreeze_Group_UAN_City1_01 ()
	if (_bDefreeze_Group_UAN_City1_01 == 0) then
		if ( AliveMembersCount(GetGroupID("Group_UAN_City1_06")) <= 1 ) then
		Defreeze_Group_UAN_City1_01B()
		_bDefreeze_Group_UAN_City1_01 = 1
		end
	end
end

function Defreeze_Group_UAN_City1_01B ()
		FreezeAll(GetGroupID("Group_UAN_City1_01"), false)
		FreezeAll(GetGroupID("Group_UAN_City1_02"), false)
end

-- Un groupe UAN est defreezé dans les terrasses du building
function OnEnter_Sector_Event_City1_A_02(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bObjectif_1_done == 1)then 
			Defreeze_Group_UAN_City1_04 ()
		end
	end
end

function OnEnter_Sector_Event_City1_A_03(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		Defreeze_Group_UAN_City1_04 ()
	end
end

function Defreeze_Group_UAN_City1_04 ()
	if (_bDefreeze_Group_UAN_City1_04 == 0) then
		FreezeAll(GetGroupID("Group_UAN_City1_04"), false)
		_bDefreeze_Group_UAN_City1_04 = 1
	end
end

-- Un groupe UAN est defreezé dans les escaliers du building

function OnEnter_Sector_Event_City1_A_04(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		Defreeze_Group_UAN_City1_08 ()
	end
end

function Defreeze_Group_UAN_City1_08 ()
	if (_bDefreeze_Group_UAN_City1_08 == 0) then
		if ( AliveMembersCount(GetGroupID("Group_UAN_City1_04")) <= 2 ) then
			FreezeAll(GetGroupID("Group_UAN_City1_08"), false)
			_bDefreeze_Group_UAN_City1_08 = 1
		end
	end
end





-------------------------------------------------------
-- :::::::: B.O.S :::::::::::::::::::::::::::::::::: --
-------------------------------------------------------

-- defreeze BOS
function Defreeze_BOS ()
	if	(AliveMembersCount(GetGroupID("Group_UAN_City1_04"))<= 0)
	and (not IsAlive(GetCharacterID("Char_UAN_City1_03_1")))
	and IsEntityInBox(_idPlayer,"Sector_Event_City1_C_00") then
		if (_bDefreeze_Defreeze_BOS == 0) then
			SetVarValue(GetTimerID("Timer_City1_B_00"),"Active",true)
			NewSubObjective ( "Obj_B_2", "Obj_b_3")	
			OpenDoor(GetDoorID("Door_Portal_Begin"))
			OpenDoor(GetDoorID("Door_Portal_Begin1"))	
			_bDefreeze_Defreeze_BOS = 1
		end
	end
end

-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_01 ()

	StopMusic()
	g_bBoSEnCours = true
	LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut") 
end



function Champion_0_Setup()
	Freeze(_idChampion_0, false)
	Refreeze_City()
	FreezeAll(GetGroupID("Group_Syn_Bos_A"), false)
	

	CloseDoor(GetDoorID("Door-BOS_01"))
	CloseDoor(GetDoorID("Door-BOS_02"))
	CloseDoor(GetDoorID("Door-BOS_03"))
	CloseDoor(GetDoorID("Door-BOS_04"))
	CloseDoor(GetDoorID("Door-BOS_05"))
	CloseDoor(GetDoorID("Door-BOS_06"))

	-- Télétransportation du joueur
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
end

function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_0_OnTimeOut()
	_bBoS_Done = 1
-- OBJECTIF 2 DONE
	

	Freeze(_idChampion_0, true)
	FreezeAll(GetGroupID("Group_Syn_Bos_A"), true)	
	OpenDoor(GetDoorID("Door-BOS_01"))
	OpenDoor(GetDoorID("Door-BOS_02"))
	OpenDoor(GetDoorID("Door-BOS_03"))
	OpenDoor(GetDoorID("Door-BOS_04"))
	OpenDoor(GetDoorID("Door-BOS_05"))
	OpenDoor(GetDoorID("Door-BOS_06"))
	if IsAlive(_idPlayer) then
		_bObjectif_2_done = 1
		RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_11", true, 110, 0,"")
	end
	g_bBoSEnCours = false
end



function Refreeze_City()
	FreezeAll(GetGroupID("Group_WRF_City1_01"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_01"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_02"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_04"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_06"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_07"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_08"), true)
	FreezeAll(GetGroupID("Group_UAN_City1_08"), true)
	FreezeAll(GetGroupID("Group_WRF_Start_00"), true)
	Freeze(GetCharacterID("Char_WRF_Start_02_1"), true)
end


-------------------------------------------------------
-- ::::::::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------





-- TIMER DE L'OBJECTIF 2
-- premier dialogue pour timing
function Timer_Start_Objectif_B1()
	if (_bObjectif_1_done == 1)then
		if (_bDefreeze_Defreeze_BOS == 0)then
			RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_08", true, 110, 0,"")
			SetVarValue(GetTimerID("Timer_City1_A_01"),"Active",true)
		end
	end
end

-- deuxième dialogue pour timing seulement si Nolan est "loin" de rencontrer le Champion
function Timer_Start_Objectif_B2()
	if (_bObjectif_1_done == 1)then
		if (_bDefreeze_Defreeze_BOS == 0)then
			SetVarValue(GetTimerID("Timer_City1_A_02"),"Active",true)
			if (AliveMembersCount(GetGroupID("Group_UAN_City1_04")) <= 4)  then
				RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_17", true, 110, 0,"")
			end
		end
	end
end

-- troisième dialogue pour timing Nolan a perdu
function Timer_Start_Objectif_B3()
	if (_bObjectif_1_done == 1)then
		if (_bDefreeze_Defreeze_BOS == 0)then
			RadioMessage("DIA_SPE_NIV_J_GENERAL_RADIO_10", true, 110, 0,"")
			MissionFailed ("HUD_MISSION_FAILED_REASON_13")	
		end
	end
end