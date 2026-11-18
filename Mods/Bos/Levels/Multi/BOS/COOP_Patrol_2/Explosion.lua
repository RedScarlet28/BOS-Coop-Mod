--[[
function Explosion()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(1830,3800),GetFloatRandom(1200,3120),GetFloatRandom(400,600)))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
	--SetVarValue(idExplosion,"Rotation",	Vector3D(0,GetFloatRandom(2.5,3.5),0))
	SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")


	if (nBombardement > 5)then
		nBombardement = GetRandom(0,100)
	end
	if (nBombardement >= 95) then
		rDuration_Timer = GetFloatRandom(10.0,20.0) -- accalmie
	elseif (nBombardement <= 5) then
		rDuration_Timer = GetFloatRandom(0.2,1.0) -- pluie folle
		nBombardement = -1
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Active",true)
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Duration",10)
	else
		rDuration_Timer = GetFloatRandom(0.5,2.0) -- normal
	end
	SetVarValue(GetTimerID("Timer_Explosion"),"Duration",rDuration_Timer)
end

--]]
function ExplosionCamp_4()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(0,0,70)+GetVarValue(GetCharacterID("Char_WRF_Camp_4_1"),"Position"))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.143,0))
	--SetVarValue(idExplosion,"Rotation",	Vector3D(0,GetFloatRandom(2.5,3.5),0))
--	SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
end

function Explosion_Pluie()
	nBombardement = 30
end

function OnEnter_SE_Bombardement_Mordor_1(id)
	if (id == _idPlayer) then
		_nBombPlayer = 1
	end
end

function OnEnter_SE_Bombardement_Mordor_2(id)
	if (id == _idPlayer) then
		_nBombPlayer = 2
	end
end

function OnEnter_SE_Bombardement_Mordor_3(id)
	if (id == _idPlayer) then
		_nBombPlayer = 3
	end
end

function OnEnter_SE_Camp_4_T_01(id)
	if (id == _idPlayer) then
		SetVarValue(GetTimerID("Timer_Explosion"),"Active",true)

	end
end



function Bombardement()
		_nR=20
		_nHm=350
		_nHM=550
		_nPos=GetRandom(1,3)

		if (_nBombPlayer == 1) and (_nPos == 1) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-2000,-850),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nBombPlayer == 1) and (_nPos == 2) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-4000,-3000),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nBombPlayer == 2)and (_nPos == 1) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-1300,-850),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nBombPlayer == 2)and (_nPos == 2) then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-4000,-3000),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nBombPlayer == 3) and (_nPos == 1)then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-4000,-3300),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end

		if (_nBombPlayer == 3) and (_nPos == 2)then
			idExplosion = CreateRocket()
			SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(-2650,-850),GetFloatRandom(100,920),GetFloatRandom(_nHm,_nHM)))
		end
		
		if (_nPos == 3)then
			idExplosion1 = CreateRocket()
			SetVarValue(idExplosion1,"Rotation",	Vector3D(0,3.06,0))
			SetVarValue(idExplosion1,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
			SetVarValue(idExplosion1,"Type","Projectile_Rocket_Bombardement")
			SetVarValue(idExplosion1,"Position",	Vector3D(GetFloatRandom(-2900,-1800),GetFloatRandom(-500,200),GetFloatRandom(500,1500)))
		end
	if (nBombardement > 5)then
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


function Bombardement_Tour()

		idExplosion1 = CreateRocket()
		SetVarValue(idExplosion1,"Rotation",	Vector3D(0,3.06,0))
		SetVarValue(idExplosion1,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)))
		SetVarValue(idExplosion1,"Type","Projectile_Rocket_Bombardement")
		SetVarValue(idExplosion1,"Position",	Vector3D(GetFloatRandom(-2900,-1800),GetFloatRandom(-500,200),GetFloatRandom(500,1500)))

end


function ExplosionCamp_4_Cin()
	idExplosionCin = CreateRocket()
	SetVarValue(idExplosionCin,"Position",	Vector3D(-2470,874,300))
	SetVarValue(idExplosionCin,"Rotation",	Vector3D(0,3.343,0))
	SetVarValue(idExplosionCin,"Type","Projectile_Rocket_Bombardement")
end