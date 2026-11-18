function Bombardement()
		_nR=20
		_nHm=900
		_nHM=1200
		_nPos=GetRandom(1,5)

		if (_nPos == 1) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(815,2224),GetFloatRandom(-1830,-1701),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nPos == 2) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(2290,2359),GetFloatRandom(-1697,-254),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nPos == 3) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(565,760),GetFloatRandom(-1646,-461),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nPos == 4) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-4000,-3000),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if ((_nPlayerZone == 0) and (_nPos == 5)) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(786,1446),GetFloatRandom(-1527,-457),GetFloatRandom(_nHm,_nHM)))
		end

		if ((_nPlayerZone == 1) and (_nPos == 5)) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(786,1446),GetFloatRandom(-1527,-457),GetFloatRandom(_nHm,_nHM)))
		end
		
		if ((_nPlayerZone == 2) and (_nPos == 5)) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(1431,1557),GetFloatRandom(-1598,-533),GetFloatRandom(_nHm,_nHM)))
		end

	if (nBombardement > 5) then
		nBombardement = GetRandom(0,100)
	end
	if (nBombardement >= 95) then
		rDuration_Timer = GetFloatRandom(10.0,20.0) -- accalmie
	elseif (nBombardement <= 3) --[[and (nBombardement > 0)--]] then
		rDuration_Timer = GetFloatRandom(0.2,1.0) -- pluie folle
		nBombardement = -1
		if (_bOkPluieFolle == true) then
			SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Active",true)
			SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Duration",GetRandom(5,10))
			_bOkPluieFolle = false
		end
	else
		rDuration_Timer = GetFloatRandom(0.5,2.0) -- normal
	end
	SetVarValue(GetTimerID("Timer_Explosion"),"Duration",rDuration_Timer)
end


function Explosion_Pluie_Folle()
	nBombardement = 50
	_bOkPluieFolle = true
end