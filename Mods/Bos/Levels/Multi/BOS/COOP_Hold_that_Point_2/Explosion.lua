function InitLevel_Explosion()
	InitScriptVariable_Explosion();

end


function UpdateLevel_Explosion()

end


function InitScriptVariable_Explosion()
	_nBombardement	=	50;
end


function Explosion()
	idExplosion = CreateRocket();
	SetVarValue(idExplosion,"Position",	Vector3D(GetFloatRandom(2000,3500),GetFloatRandom(-500,450),GetFloatRandom(400,600)));
	SetVarValue(idExplosion,"Rotation",	Vector3D(0,3.06,0));
	SetVarValue(idExplosion,"Rotation",	Vector3D(GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5),GetFloatRandom(2.5,3.5)));
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement");


	if (_nBombardement > 5)then
		_nBombardement = GetRandom(0,100);
	end
	if (_nBombardement >= 95) then
		rDuration_Timer = GetFloatRandom(10.0,20.0); -- accalmie
	elseif (_nBombardement <= 5) then
		_rDuration_Timer = GetFloatRandom(0.4,2.0); -- pluie folle
		_nBombardement = -1
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Active",true);
		SetVarValue(GetTimerID("Timer_Explosion_pluie_folle"),"Duration",10);
	else
		_rDuration_Timer = GetFloatRandom(1.0,4.0); -- normal
	end
	SetVarValue(GetTimerID("Timer_Explosion"),"Duration",_rDuration_Timer);
end

function Explosion_Pluie_Folle()
	_nBombardement = 50;
end