function Explosion()
	if _bDeath_All_Exo == 0 then
		idExplosion = CreateRocket()
		SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(3000,3700),GetFloatRandom(430,1047),GetFloatRandom(480,520)))
		SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
		SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(1.75,1.76),GetFloatRandom(1.74,1.77),GetFloatRandom(-1.63,-1.60)))
		SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt")
	end

	if (_nBombardement > 5)then
		_nBombardement = GetRandom(0,100)
	end
	if (_nBombardement >= 95) then
		_rDuration_Timer = GetFloatRandom(10.0,20.0) -- accalmies
	elseif (_nBombardement <= 5) then
		_rDuration_Timer = GetFloatRandom(0.4,2.0) -- pluie folle
		_nBombardement = -1
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Active",true)
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Duration",GetRandom(5,15))
	else
		_rDuration_Timer = GetFloatRandom(1.0,4.0) -- normal
	end
	SetVarValue(GetTimerID("Timer_Explosion"),"Duration",_rDuration_Timer)
end

function Explosion_Pluie_Folle()
	_nBombardement = 50
end