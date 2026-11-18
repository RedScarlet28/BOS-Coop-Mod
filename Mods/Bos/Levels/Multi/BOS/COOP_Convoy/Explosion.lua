function Explosion()
	if (_bDefreeze_Defreeze_BOS == 0) then 
		
		idExplosion = CreateRocket()
		SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(1364.0,1370.0),GetFloatRandom(534.0,540.0),GetFloatRandom(43.0,44.0)))
		SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(-2.74,-2.6),GetFloatRandom(0.55,0.65),GetFloatRandom(2.75,2.85)))
		SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt")


		_nBombardement = GetRandom(0,100)
		if (_nBombardement >= 85) then
			_rDuration_Timer = GetFloatRandom(5.0,12.0) -- accalmies
			SetVarValue(GetTimerID("Timer_Explosion"),"Duration",_rDuration_Timer)
		else
			_rDuration_Timer = GetFloatRandom(0.4,0.6) -- normal
			SetVarValue(GetTimerID("Timer_Explosion"),"Duration",_rDuration_Timer)
		end
	end

end

