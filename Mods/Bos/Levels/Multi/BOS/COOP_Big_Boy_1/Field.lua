 function UpdateLevel_Field ()
	Defreeze_BOS ()
	Char_Engineer_Place_C4 ()
	Char_Engineer_Go_See_Door ()
end



-- Defreeze d'autres ennemis sur la zone battlefield
function OnEnter_Sector_Event_Field_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_A_00 == 0) then	
			FreezeAll(GetGroupID("Group_Field_UAN_04"), false)
			_bOnEnter_Sector_Event_Field_A_00 = 1
		end
	end
end

-- l'ingénieur va voir la main door
-- changement d'objectif
function OnEnter_Sector_Event_Field_F_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_F_00 == 0) then
			if _bChar_Engineer_Go_See_Door == 0 then
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Field_G"))	
				Char_Engineer_Go_See_Door ()
				_bOnEnter_Sector_Event_Field_F_00 = 1
			end
		end
	end
end



-- il dit que c'est pas bon
function Char_Engineer_Go_See_Door ()
	if _bOnEnter_Sector_Event_Field_F_00 == 1
	and IsEntityInBox(_idMerc[0],"Sector_Event_Field_F_01") then
		if _bChar_Engineer_Go_See_Door == 0 then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_27",true,110,2, 0, "",31)
			SetVarValue(GetTimerID("Timer_Field_A_00"),"Active",true)
			_bChar_Engineer_Go_See_Door = 1
		end	
	end		
end


-- il dit que c'est pas bon
function Char_Engineer_Go_See_Door_02 ()
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_31",true,110,2, 0, "",31)
	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_EMPTY"))	
	SetVarValue(GetTimerID("Timer_Field_A_01"),"Active",true)	
end

---- OBJECTIF Update
---- finc the other entrance
function Obj_A_Update ()
	NewSubObjective ( "Obj_A_1", "Obj_A_2")
end


-- Defreeze d'autres ennemis sur la sone battlefield
function OnEnter_Sector_Event_Field_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_C_00 == 0) then
			FreezeAll(GetGroupID("Group_Field_UAN_05"), false)
			FreezeAll(GetGroupID("Group_Field_UAN_02"), false)
			--FreezeAll(GetCharacterID("Char_Field_UAN_05_02"), false)	
			_bOnEnter_Sector_Event_Field_C_00 = 1
		end
	end
end

-- Defreeze d'autres ennemis sur la sone battlefield
function OnEnter_Sector_Event_Field_D_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_D_00 == 0) then
			FreezeAll(GetGroupID("Group_Field_UAN_06"), false)
			_bOnEnter_Sector_Event_Field_D_00 = 1
		end
	end
end

-- Defreeze d'autres ennemis sur la sone battlefield
function OnEnter_Sector_Event_Field_E_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_E_00 == 0) and(_bDefreeze_Defreeze_BOS == 0) then
			FreezeAll(GetGroupID("Group_Field_UAN_07"), false)
			_bOnEnter_Sector_Event_Field_E_00 = 1
		end
	end
end


-- Remise a jour des objectif, si le joueur n'est pas aller voir son obj_A_1
function OnEnter_Sector_Event_Field_J_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_J_00 == 0) then
			if _bChar_Engineer_Go_See_Door == 0 then
				NewSubObjective ( "Obj_A_1", "Obj_A_2")
				_bChar_Engineer_Go_See_Door = 1
				_bOnEnter_Sector_Event_Field_J_00 = 1
			end 	
		end
	end
end





-- defreeze BOS
function Defreeze_BOS ()
	if	(AliveMembersCount(GetGroupID("Group_Field_UAN_05"))<= 0)
	and IsEntityInBox(_idPlayer,"Sector_Event_Field_I_00") then
		if (_bDefreeze_Defreeze_BOS == 0) then
			SetVarValue(GetTimerID("Timer_Field_B_00"),"Active",true)		
			_bDefreeze_Defreeze_BOS = 1
		end
	end
end

-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_01 ()
	StopMusic()
	StartMusic("Sounds//Music//BoS - Little theme.wav",false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_D"))
	Freeze(_idChampion_0, false)
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
	EnableCharacterCommand(_idPlayer, false)
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterCommand(GetCharacterID("Char_Field_UAN_02_01"), false)
	EnableCharacterCommand(GetCharacterID("Char_Field_UAN_02_02"), false)
	CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1],true)
	end
	CreationTimer(true,true,false,"Anim_Bos",5.0)
end

function Anim_Bos ()
	CharacterPlaySpecialAction(_idChampion_0, "STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT",false,false)
end

function Launch_BOS ()
	g_bBoSEnCours = true
	CharacterStopSpecialAction(_idPlayer)
	ShowCinematicBlackStripes(false)
	LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut") 
end

function Champion_0_Setup()
	

	Freeze(_idChampion_0, false)
end

function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_0_OnTimeOut()
	EnableCharacterCommand(GetCharacterID("Char_Field_UAN_02_01"), true)
	EnableCharacterCommand(GetCharacterID("Char_Field_UAN_02_02"), true)
	Freeze(_idChampion_0,true)


	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0], true)
		Freeze(_idMerc[0],false)
	end
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1], true)
		Freeze(_idMerc[1],false)
	end
	_bBoS_Done = 1
	g_bBoSEnCours = false
end





-- l'ingénieur va poser une charge sur la porte
function Char_Engineer_Place_C4 ()
		if	(_bBoS_Done == 1)
		and	IsEntityInBox(_idPlayer,"Sector_Event_Field_H_00") then
			if (_bC4_First_Door_Placed == 0)then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_05",true,110,2, 0, "",31)			
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Field_F"))	
			_bC4_First_Door_Placed = 1
			end
		end
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

-- Explosion
function Ouverture_Door ()
		SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",false)
		SetVarValue(GetDoorID("Door_01"),"Locked",false)
		OpenDoor(GetDoorID("Door_01"))
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_EMPTY"))
--	idexplosion = CreateExplosion ()
--	SetVarValue(idexplosion,"Position",Vector3D(-544,-1335,65))
--	SetVarValue(idexplosion,"Type","Explosion_Rocket_A")
end


function Ouverture_Code_A_Sound ()
	CreationTimer(true,true,false,"Ouverture_Code_B_Sound",1.0)
end

function Ouverture_Code_B_Sound ()
	SetVarValue(GetSound_ClientID("Sound_Code"),"Playing",true)
	CreationTimer(true,true,false,"Ouverture_Door",4.0)
end

-- OBJECTIF NEW
function OnEnter_Sector_Event_Field_B_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_B_01 == 0) then
			ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
			SetVarValue ( GetObjectiveID ("Obj_B_a"),"Active", true )
			_bOnEnter_Sector_Event_Field_B_01 = 1
		end
	end
end

-- End Of Level
function OnEnter_Sector_Event_Field_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Field_B_00 == 0) then
			--EndOfDemo ()
			EndOfLevel ()
			_bOnEnter_Sector_Event_Field_B_00 = 1
		end
	end
end



