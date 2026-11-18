function Bullet()
	idBullet = CreateBullet()
--	SetVarValue(idBullet,"Position",	Vector3D(GetFloatRandom(1830,3800),GetFloatRandom(1200,3120),GetFloatRandom(400,600)))
--	SetVarValue(idBullet,"Rotation",	Vector3D(0,3.06,0))
--	SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
--	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
	SetVarValue(idBullet,"Position",Vector3D(3231.9,1452.1,300.0))
	SetVarValue(idBullet,"Rotation",Vector3D(-1.5,3,1.5))
	if (nShoot >= 95) then
		rDuration_Timer_Bullet = GetFloatRandom(5.0,8.0) -- accalmie
	else
		rDuration_Timer_Bullet = GetFloatRandom(0.1,0.3) -- normal
	end
	SetVarValue(GetTimerID("Timer_Bullet"),"Duration",rDuration_Timer_Bullet)
end