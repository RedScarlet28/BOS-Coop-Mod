function Explosion()
	idExplosion = CreateRocket()
	_idSound_Canon_Shoot =	CreateSound_Client()
	_idShoot	= CreateParticleFX_Client ()
	_nCanon = GetRandom(1,9)
	if (_nCanon == 1) then
			SetVarValue(idExplosion,"Position",	Vector3D(395.0,-840.0,95.8))
			SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(395.0,-1040.0,95.8))
			SetVarValue(_idShoot,"Position",Vector3D(395.0,-1040.0,95.8))
	elseif (_nCanon == 2) then 
		SetVarValue(idExplosion,"Position",	Vector3D(512.3,-840.0,95.8))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(512.3,-1040.0,95.8))
		SetVarValue(_idShoot,"Position",Vector3D(512.3,-1040.0,95.8))
	elseif (_nCanon == 3) then 
		SetVarValue(idExplosion,"Position",	Vector3D(865.5,-840.0,95.8))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(865.5,-1040.0,95.8))
		SetVarValue(_idShoot,"Position",Vector3D(865.5,-1040.0,95.8))
	elseif (_nCanon == 4) then 
		SetVarValue(idExplosion,"Position",	Vector3D(-874.5,-1050.0,178))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-874.5,-1250.0,178))
		SetVarValue(_idShoot,"Position",Vector3D(-874.5,-1250.0,178))
	elseif (_nCanon == 5) then 
		SetVarValue(idExplosion,"Position",	Vector3D(-988,-1050.0,178))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-988,-1250.0,178))
		SetVarValue(_idShoot,"Position",Vector3D(-988,-1250.0,178))
	elseif (_nCanon == 6) then 
		SetVarValue(idExplosion,"Position",	Vector3D(-1320,-1050.0,235))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-1320,-1250.0,235))
		SetVarValue(_idShoot,"Position",Vector3D(-1320,-1250.0,235))
	elseif (_nCanon == 7) then 
		SetVarValue(idExplosion,"Position",	Vector3D(-220,-823.0,116))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-220,-1023.0,116))
		SetVarValue(_idShoot,"Position",Vector3D(-220,-1023.0,116))
	elseif (_nCanon == 8) then 
		SetVarValue(idExplosion,"Position",	Vector3D(-90,-823.0,116))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(-90,-1023.0,116))
		SetVarValue(_idShoot,"Position",Vector3D(-90,-1023.0,116))
	else
		SetVarValue(idExplosion,"Position",	Vector3D(850.5,-840.0,95.8))
		SetVarValue(_idSound_Canon_Shoot,"Position",Vector3D(850.5,-1040.0,95.8))
		SetVarValue(_idShoot,"Position",Vector3D(850.5,-1040.0,95.8))
	end

	SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(1.45,1.65),GetFloatRandom(1.35,1.45),1.59))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Canon")

	SetVarValue(_idSound_Canon_Shoot,"Attenuation Start",500)
	SetVarValue(_idSound_Canon_Shoot,"Attenuation End",1100)
	--SetVarValue(_idSound_Canon_Shoot,"FileName","Sounds/Weapon/Bombe/Bombe_02.wav")
	SetVarValue(_idSound_Canon_Shoot,"SoundShader","bombe")
	SetVarValue(_idSound_Canon_Shoot,"Playing",true)

	SetVarValue(_idShoot,"FX_Filename","fx/Explosion.ifx")


	if (_nBombardement > 5)then
		_nBombardement = GetRandom(0,100)
	end
	if (_nBombardement >= 95) then
		rDuration_Timer = GetFloatRandom(10.0,20.0) -- accalmie
	elseif (_nBombardement <= 5) then
		_rDuration_Timer = GetFloatRandom(0.4,2.0) -- pluie folle
		_nBombardement = -1
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Active",true)
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Duration",10)
	else
		_rDuration_Timer = GetFloatRandom(1.0,4.0) -- normal
	end
	SetVarValue(GetTimerID("Timer_Explosion"),"Duration",_rDuration_Timer)
end

function Explosion_Pluie_Folle()
	_nBombardement = 50
end