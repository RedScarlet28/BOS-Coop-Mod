function Cine_Debut ()
	CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_NONE COOL",true,false)
	ShowCinematicBlackStripes(true)	
	LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
	EnableCharacterCommand(_idPlayer, false)
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], false)
		CharacterPlaySpecialAction(_idMerc[0], "STAND COMPLETE WAIT W_NONE COOL",true,false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], false)
		CharacterPlaySpecialAction(_idMerc[1], "STAND COMPLETE WAIT W_NONE COOL",true,false)
	end
end

function Cine_End()
	CharacterStopSpecialAction(_idPlayer)
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], true)
		CharacterStopSpecialAction(_idMerc[0])
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], true)
		CharacterStopSpecialAction(_idMerc[1])
	end

	SetVarValue(GetTimerID("Timer-125"),"Active",true)
	SetVarValue(GetTimerID("Timer-126"),"Active",true)
end