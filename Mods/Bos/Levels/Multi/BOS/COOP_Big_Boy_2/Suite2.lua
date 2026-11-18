function UpdateLevel_Suite_02 ()
	Last_Group_flee_01 ()
	Last_Group_flee_02 ()
	Last_Group_flee_03 ()
	Last_Group_flee_04 ()
end


-- Defreeze soldats....
function OnEnter_Sector_Event_Suite2_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Suite2_UAN_01"), false)
			_bOnEnter_Sector_Event_Suite2_A_00 = 1
		end
	end
end

-- Defreeze soldat tout seul avec arme lourdes
function OnEnter_Sector_Event_Suite2_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_01 == 0) then
			Freeze(GetCharacterID("Char_Suite2_UAN_03_01"), false)
			_bOnEnter_Sector_Event_Suite2_A_01 = 1
		end
	end
end

-- Defreeze soldats....
function OnEnter_Sector_Event_Suite2_A_02 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_02 == 0) then
			if (_bComputer_Hacked == 1)then  
			FreezeAll(GetGroupID("Group_Suite2_UAN_02"), false)
			_bOnEnter_Sector_Event_Suite2_A_02 = 1
			end
		end
	end
end



-- defreeze BOS
function OnEnter_Sector_Event_Suite2_A_03 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_03 == 0) then
			if (_bComputer_Hacked == 1)then 
			Freeze(_idChampion_0, false)
			SetGodMode(_idChampion_0, true)
			EnableCharacterCommand(_idChampion_0, false)
		--	SetVarValue(GetTimerID("Timer_Suite2_A_00"),"Active",true)
		--	SetVarValue(GetDoorID("Door_06"),"Locked",false) 
		--	SetVarValue(GetDoorID("Door_07"),"Locked",false) 
		--	SetGodMode(_idChampion_0, true)
			SetVarValue(GetDoorID("Door_06"),"Locked",false) 
			OpenDoor(GetDoorID("Door_06")) -- door bos
			Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
			ShowCinematicBlackStripes(true)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Bos_A"))
			_bOnEnter_Sector_Event_Suite2_A_03 = 1
			end
		end
	end
end

function Cine_Bos_B()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Bos_B"))
end

-- WARNING BOS --
function Defreeze_BOS ()
	g_bBoSEnCours = true
	ShowCinematicBlackStripes(false)
	if _idMusic ~= nil then
			SetVarValue (_idMusic, "Playing", false )
	end
	LaunchBOS(0,"Champion_0_OnSetup","Champion_0_WarmUp","Champion_0_Combat","Champion_0_OnTimeOut","Champion_0_OnTimeOut","Champion_0_OnTimeOut")			
	_bDefreeze_Defreeze_BOS = 1
end


function Champion_0_OnSetup()
	CloseDoor(GetDoorID("Door_06"))
	Teletransportation("Char_Champion_0_Repere_Player1",_idPlayer)
		if (_idMerc[0] ~= nil) then 
					Teletransportation("Repere_Merc_0",_idMerc[0])
					Freeze(_idMerc[0], true)
				end
				if (_idMerc[1] ~= nil) then 
					Teletransportation("Repere_Merc_0",_idMerc[1])
					Freeze(_idMerc[1], true)
				end
end


function Champion_0_WarmUp()
	EnableCharacterFire(_idPlayer,false)
	EnableCharacterCommand(_idChampion_0,false)
end

function Champion_0_Combat()
	EnableCharacterFire(_idPlayer,true)
	EnableCharacterCommand(_idChampion_0, true)
	SetGodMode(_idChampion_0, false)
end

function Champion_0_OnTimeOut()
	Freeze(_idChampion_0, true)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0], true)
		Freeze(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1], true)
		Freeze(_idMerc[1], false)
	end
	OpenDoor(GetDoorID("Door_06"))
	g_bBoSEnCours = false
end





-- Dernier Groupe qui spawn, tir, puis fuit....
function OnEnter_Sector_Event_Suite2_A_04 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_04 == 0) then
			if (_bDefreeze_Defreeze_BOS == 1)then 
			FreezeAll(GetGroupID("Group_Suite2_UAN_04"), false)
			_bOnEnter_Sector_Event_Suite2_A_04 = 1
			end
		end
	end
end

-- calcul vie Life_UAN_04_01
function Last_Group_flee_01 ()
		_bLife_UAN_04_01 		= GetHealthPct(GetCharacterID("Char_Suite2_UAN_04_01"))
		_bArmor_UAN_04_01 	= GetArmorGlobalHPPct(GetCharacterID("Char_Suite2_UAN_04_01"))
		_bShield_UAN_04_01	= GetVarValue(GetCharacterID("Char_Suite2_UAN_04_01"), "ShieldHitPoints" )
end

-- fuite premiers hommes
function Last_Group_flee_02 ()
	if (_bLast_Group_flee_02 == 0) then
		if ((IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_05"))
	 	or(_bLife_UAN_04_01 < 60 ) 
		or (_bArmor_UAN_04_01 < 50 )) then
			SetVarValue(GetCharacterID("Char_Suite2_UAN_04_02"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite2_D_03"))	
			SetVarValue(GetCharacterID("Char_Suite2_UAN_04_03"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite2_D_03"))	
			SetVarValue(GetCharacterID("Char_Suite2_UAN_04_04"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite2_D_03"))
				
			_bLast_Group_flee_02 = 1
		end
	end
end

-- fuite du bouclier
function Last_Group_flee_03 ()
	if (_bLast_Group_flee_03 == 0) then
		if ((IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_05"))
	 	or(_bLife_UAN_04_01 < 40 ) 
		or (_bArmor_UAN_04_01 < 20 )
		or (_bShield_UAN_04_01 <= 0)) then
			SetVarValue(GetCharacterID("Char_Suite2_UAN_04_01"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite2_D_03"))				
			_bLast_Group_flee_03 = 1
		end
	end
end

-- Les bots disparaissent dans certaines conditions
function Last_Group_flee_04 ()
	if not IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_06")
	and IsEntityInBox(GetCharacterID("Char_Suite2_UAN_04_04"),"Sector_Event_Suite2_A_06")
	and IsDoorClosed(GetDoorID("Door_08"))
	and not IsFrozen(GetCharacterID("Char_Suite2_UAN_04_04")) then
	Freeze(GetCharacterID("Char_Suite2_UAN_04_04"),true)
	end
	if not IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_06")
	and IsEntityInBox(GetCharacterID("Char_Suite2_UAN_04_03"),"Sector_Event_Suite2_A_06")
	and IsDoorClosed(GetDoorID("Door_08"))
	and not IsFrozen(GetCharacterID("Char_Suite2_UAN_04_03")) then
	Freeze(GetCharacterID("Char_Suite2_UAN_04_03"),true)
	end
	if not IsEntityInBox(_idPlayer,"Sector_Event_Suite2_A_06")
	and IsEntityInBox(GetCharacterID("Char_Suite2_UAN_04_01"),"Sector_Event_Suite2_A_06")
	and IsDoorClosed(GetDoorID("Door_08"))
	and not IsFrozen(GetCharacterID("Char_Suite2_UAN_04_01")) then
	Freeze(GetCharacterID("Char_Suite2_UAN_04_01"),true)
	end
end



-- OBJECTIVE
function OnEnter_Sector_Event_Suite2_A_06 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Suite2_A_06 == 0) then
			NewSubObjective ("Obj_B_1","Obj_B_2")
			_bOnEnter_Sector_Event_Suite2_A_06 = 1
			end
		end
end


-- END OF LEVEL
function OnEnter_Sector_Event_Suite2_C_00(_idCharInBox)
	if (_idCharInBox == _idPlayer) then
			EndOfLevel ()
	end
end