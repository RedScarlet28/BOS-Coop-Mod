function InitLevel_Intro()

end

function UpdateLevel_Intro()

end

function IntroCargoBay()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Intro1"))
	ShowCinematicBlackStripes(true)
	
	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_1"),false)
	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_2"),false)
	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_3"),false)

	EnableCharacterCommand(_idPlayer,false)
	if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
	end
	if (_idMerc[0] ~= nil) then
			EnableCharacterCommand(_idMerc[0],false)
	end

	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_8"),false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_1"),false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_2"),false)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_3"),false)
end

function CamTransition_Intro2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Intro2"))
end

function CamTransition_Intro3()

	LaunchCameraTransition(GetCamTransitionID("CamTransition_Intro3"))
	Freeze(GetCharacterID("Player_Cine"),false)

	if (_idMerc[0] ~= nil) then
		Freeze(GetCharacterID("Char_Merc_Intro2"),false)
	end

	if (_idMerc[1] ~= nil) then
		Freeze(GetCharacterID("Char_Merc_Intro1"),false)
	end
end

function EndCineIntro()
	ShowCinematicBlackStripes(false)

	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_8"),true)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_1"),true)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_2"),true)
	Freeze(GetCharacterID("Char_Camp1_UAN_Trooper_Cine_3"),true)

	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_1"),true)
	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_2"),true)
	EnableCharacterFire(GetCharacterID("Char_Camp1_UAN_Trooper_3"),true)

	Freeze(GetCharacterID("Player_Cine"),true)
	EnableCharacterCommand(_idPlayer,true)
	if (_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],true)
			Freeze(GetCharacterID("Char_Merc_Intro1"),true)
	end
	if (_idMerc[0] ~= nil) then
			EnableCharacterCommand(_idMerc[0],true)
			Freeze(GetCharacterID("Char_Merc_Intro2"),true)
	end
end
