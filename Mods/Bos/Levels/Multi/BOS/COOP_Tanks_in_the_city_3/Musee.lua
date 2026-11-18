function UpdateLevel_Musee()
	Defreeze_Group_UAN_Sewer_A()
	Defreeze_Group_UAN_Hotel_B()
	Defreeze_BOS_01 ()
end


----------------------------------------
--[[ Change l'order list du leader pour k'il explose le mur destructible --]]
function OnEnter_Sector_Event_Aile(id)
	--if (id == GetCharacterID("Char_UAN_Lane_05_1")) then
--		SetVarValue(GetCharacterID("Char_UAN_Lane_05_1"),"CharacterOrderList",GetAI_Order_ListID("AIO_List_BOS_Lane_Aileb"))
--	end
end



function OnEnter_Sector_Event_Musee_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Musee_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Exo_Driver_01"),false)
			Freeze(_idExo_01,false)
			Freeze(_idExo_02,false)
			Freeze(_idExo_03,false)
			FreezeAll(GetGroupID("Group_UAN_Place_A"),false)
			_bOnEnter_Sector_Event_Musee_A_00 = 1
		end
	end
end


function OnEnter_Sector_Event_Musee_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Musee_B_00 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Musee_A"),false)
			_bOnEnter_Sector_Event_Musee_B_00 = 1
		end
	end
end


function Defreeze_Group_UAN_Sewer_A()
	if IsEntityInBox(_idPlayer,"Sector_Event_Sewer_A_00" )
	or IsEntityInBox(_idPlayer,"Sector_Event_Sewer_A_01" )
	or IsEntityInBox(_idPlayer,"Sector_Event_Sewer_A_03" )
	or IsEntityInBox(_idPlayer,"Sector_Event_Sewer_A_04" )then
		if (_bDefreeze_Group_UAN_Sewer_A == 0)then
			FreezeAll(GetGroupID("Group_UAN_Sewer_A"),false)
			_bDefreeze_Group_UAN_Sewer_A = 1
		end
	end
end


function OnEnter_Sector_Event_Hotel_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Hotel_A_00 == 0) then
			FreezeAll(GetGroupID("Group_UAN_Hotel_A"),false)
			_bOnEnter_Sector_Event_Hotel_A_00 = 1
		end
	end
end

function Defreeze_Group_UAN_Hotel_B()
	if IsEntityInBox(_idPlayer,"Sector_Event_Hotel_A_01" )
	or (AliveMembersCount(GetGroupID("Group_UAN_Hotel_A")) <= 1)then
		if (_bDefreeze_Group_UAN_Sewer_A == 0)then
			FreezeAll(GetGroupID("Group_UAN_Hotel_B"),false)
			Freeze(GetCharacterID("Char_UAN_Place_A_02"),true)
			Freeze(GetCharacterID("Char_UAN_Place_A_03"),true)
			_bDefreeze_Group_UAN_Sewer_A = 1
		end
	end
end




-- defreeze BOS
-- WARNING BOS --
function Defreeze_BOS_01 ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Hotel_A_02") then
		if (_bDefreeze_Defreeze_BOS_01 == 0) then
			FreezeAllCharactersButBetters()
			StartMusic("Sounds//Music//BoS - Little theme 2.wav",false)
			ShowCinematicBlackStripes(true)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
			Freeze(_idChampion_1, false)
			Teletransportation("Char_Champion_1_Repere_Player",_idPlayer)
			EnableCharacterCommand(_idPlayer, false)
			EnableCharacterCommand(_idChampion_1, false)
			CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
			CreationTimer(true,true,false,"Anim_Bos_01",4.5)
			Freeze(GetCharacterID("Char_UAN_Exo_Driver_01"),true)
			Freeze(GetCharacterID("Char_UAN_Exo_Driver_02"),true)
			Freeze(GetCharacterID("Char_UAN_Exo_Driver_03"),true)
			Freeze(GetExoskeletonID("Exo_01"),true)
			Freeze(GetExoskeletonID("Exo_02"),true)
			Freeze(GetExoskeletonID("Exo_03"),true)
			
			_bDefreeze_Defreeze_BOS_01 = 1
		end
	end
end

function Anim_Bos_01 ()
	CharacterPlaySpecialAction(_idChampion_1, "STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT",false,false)
end

function Launch_BOS_01 ()
	CharacterStopSpecialAction(_idPlayer)
	ShowCinematicBlackStripes(false)
	LaunchBOS(1,"Champion_1_Setup","Champion_1_WarmUp","Champion_1_Combat", "Champion_1_OnTimeOut", "", "Champion_1_OnTimeOut") 
	g_bBoSEnCours = true
end

function Champion_1_Setup()
	Teletransportation("Char_Champion_1_Repere_Champion",_idChampion_1)
--	EnableCharacterFire(_idChampion_1, false)
	EnableCharacterCommand(_idChampion_1, true)
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Char_Champion_1_Repere_Merc1",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_1_Repere_Merc2",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1], true)
	end
	g_bBoSEnCours = false
end	


function Champion_1_WarmUp()
	EnableCharacterCommand(_idChampion_1, false)
	EnableCharacterCommand(_idPlayer, true)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_1_Combat()
	EnableCharacterCommand(_idChampion_1, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_1_OnTimeOut()
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], true)
		Freeze(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], true)
		Freeze(_idMerc[1], false)
	end
	Freeze(_idChampion_1, true)
	OpenDoor(GetDoorID("Door_Champion_01"))
	FreezeAll(GetGroupID("Group_UAN_End_A"),false)
	Freeze(GetCharacterID("Char_UAN_Exo_Driver_01"),false)
	Freeze(GetCharacterID("Char_UAN_Exo_Driver_02"),false)
	Freeze(GetCharacterID("Char_UAN_Exo_Driver_03"),false)
	Freeze(GetExoskeletonID("Exo_01"),false)
	Freeze(GetExoskeletonID("Exo_02"),false)
	Freeze(GetExoskeletonID("Exo_03"),false)
	_bBoS_Done_01 = 1
end


function OnEnter_Sector_Event_Hotel_A_03 (_idCharInBox)
	if (_idCharInBox == _idChampion_1) then
		if (_bOnEnter_Sector_Event_Hotel_A_03 == 0) then
			EnableCharacterFire(_idChampion_1, true)
			EnableCharacterCommand(_idChampion_1, false)
			_bOnEnter_Sector_Event_Hotel_A_03 = 1
		end
	end
end



------------------------------

function OnEnter_Sector_Event_Sewer_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Sewer"),"Playing",true)
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_18"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_03"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_04"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_05"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_06"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_07"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_08"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_09"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_10"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_11"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_12"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_13"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_14"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_15"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_16"),"Volume",0.1)
		SetVarValue(GetSound_ClientID("Sound_Client_War_17"),"Volume",0.1)
	end
end



function OnExit_Sector_Event_Sewer_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		SetVarValue(GetSound_ClientID("Sound_Client_Ambiance_Sewer"),"Playing",false)
		SetVarValue(GetSound_ClientID("Sound_Client_vent"),"Volume",0.3)
		SetVarValue(GetSound_ClientID("Sound_Client_War_18"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_03"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_04"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_05"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_06"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_07"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_08"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_09"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_10"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_11"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_12"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_13"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_14"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_15"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_16"),"Volume",0.8)
		SetVarValue(GetSound_ClientID("Sound_Client_War_17"),"Volume",0.8)
	end
end













