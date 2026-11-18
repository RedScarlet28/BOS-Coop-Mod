
function Cine_A()
	CharacterPlaySpecialAction(_idMerc[0], "STAND COMPLETE WAIT W_NONE COOL",true,false)
	CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_NONE COOL",true,false)
	ShowCinematicBlackStripes(true)	
	LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
	EnableCharacterCommand(_idPlayer, false)
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], false)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], false)
	end
end

function Cine_B()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_B"))
end


function Cine_B2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_C"))
end


function Cine_C()
	CharacterStopSpecialAction(_idMerc[0])
	CharacterStopSpecialAction(_idPlayer)
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
	if (_idMerc[0] ~= nil) then
		EnableCharacterCommand(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then
		EnableCharacterCommand(_idMerc[1], true)
	end

	SetVarValue(GetTimerID("Timer_Camp_A_00"),"Active",true)
	SetVarValue(GetTimerID("Timer_Camp_A_01"),"Active",true)
	SetVarValue(GetTimerID("Timer_Explosion"),"Active",true)

	Freeze(GetCharacterID("Char_Camp_UAN_00_01"),false)

	Freeze(GetCharacterID("Char_Field_UAN_00_01"),true)
	SetVarValue(GetCharacterID("Char_Field_UAN_00_01"),"CharacterAI",GetCharacter_AIID("Char_AI_UAN_Snipers"))

end



function Cine_Canon_fire ()
	idExplosion = CreateRocket()
	_idSound_Canon_Shoot =	CreateSound_Client()
	_idShoot	= CreateParticleFX_Client ()


	SetVarValue(idExplosion,"Position",	Vector3D(-90,-1023.0,116))
	SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-90,-1023.0,116))
	SetVarValue(_idShoot,"Position",Vector3D(-90,-1023.0,116))
	SetVarValue(idExplosion,"Rotation",	Vector3D(1.5,1.5,1.59))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Canon")

	SetVarValue(_idSound_Canon_Shoot,"Attenuation Start",500)
	SetVarValue(_idSound_Canon_Shoot,"Attenuation End",1100)
	SetVarValue(_idSound_Canon_Shoot,"SoundShader","bombe")
	SetVarValue(_idSound_Canon_Shoot,"AutoRelease",true)
	SetVarValue(_idSound_Canon_Shoot,"Playing",true)

	SetVarValue(_idShoot,"FX_Filename","fx/Explosion.ifx")

	CameraShake(1.0,1,1,1)


end