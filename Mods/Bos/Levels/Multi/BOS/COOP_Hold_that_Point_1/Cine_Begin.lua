-- Pano dans bunker
function Cine_Begin_A ()
	EnableCharacterCommand(_idPlayer, false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_C"))
end	


-- Survol
function Cine_Begin_C ()
	StartMusic("Sounds//Music//Bos - War theme.wav",true)
	SetVarValue(GetCharacterID("Char_Cine_WRF_02"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Cine_Begin_A_02"))	
	Freeze(GetCharacterID("Char_Cine_WRF_05"), true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_A"))
end


function Cine_Begin_B ()
	Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_05"), false)
	Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_07"), false)
	Freeze(GetCharacterID("Char_Cine_WRF_08"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_09"), true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_B"))
end

function Cine_Begin_D ()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_D"))
--	SetVarValue(GetTimerID("Timer_Cine_Begin_A"),"Active",true)	
end

-- Trav avant, para take exo
function Cine_Begin_E ()
	Freeze(GetCharacterID("Char_Cine_WRF_07"), true)
	--SetVarValue(GetCharacterID("Char_Cine_WRF_07"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Go_Waypoint_Cine_Begin_A_03"))	
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_E"))
end

-- Trav arrière dans battlefield
function Cine_Begin_F ()
	Freeze(GetCharacterID("Char_Cine_UAN_01"), false)
	Freeze(GetCharacterID("Char_Cine_UAN_02"), false)
	Freeze(GetCharacterID("Char_Cine_UAN_03"), false)
	Freeze(GetCharacterID("Char_Cine_UAN_04"), false)
	Freeze(GetCharacterID("Char_Cine_UAN_05"), false)
	Freeze(GetCharacterID("Char_Cine_WRF_01"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_02"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_03"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_05"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_06"), true)
	Freeze(GetCharacterID("Char_Cine_WRF_07"), true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_F"))
end

-- Trav vers joueur
function Cine_Begin_G () 
	Freeze(GetCharacterID("Char_Cine_UAN_01"), true)
	Freeze(GetCharacterID("Char_Cine_UAN_02"), true)
	Freeze(GetCharacterID("Char_Cine_UAN_03"), true)
	Freeze(GetCharacterID("Char_Cine_UAN_04"), true)
	Freeze(GetCharacterID("Char_Cine_UAN_05"), true)
	Freeze(GetCharacterID("Char_WRF_Camp1_00_1"), false)
	--SetVarValue(GetSound_ClientID("Sound_Music_Cine"),"Playing",false)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Cine_Begin_G"))
end




