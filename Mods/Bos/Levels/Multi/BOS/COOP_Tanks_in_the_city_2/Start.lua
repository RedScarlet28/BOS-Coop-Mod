function OnEnter_Sector_Event_Start_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_C_00 == 0) then
		FreezeAll(GetGroupID("Group_Start_UAN_A"),false)
			_bOnEnter_Sector_Event_Start_C_00 = 1
		end
	end
end


function OnEnter_Sector_Event_Start_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then	
		TankCancelAttack(GetTankID("Tank_01"))
	end
end

function OnExit_Sector_Event_Start_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnExit_Sector_Event_Start_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Start_UAN_B"),false)
			_bOnExit_Sector_Event_Start_A_00 = 1
		end
			TankTargetEntity(GetTankID("Tank_01"),_idPlayer)
	end
end


function OnEnter_Sector_Event_Start_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Start_B_00 == 0) then
		FreezeAll(GetGroupID("Group_Start_UAN_C"),false)
			_bOnEnter_Sector_Event_Start_B_00 = 1
		end
	end
end


function OnEnter_Sector_Event_DEBUG (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		EndOfLevel()
	end
end


-- le premier tank se réinitialise
-- Security tank
-- Si Nolan passe le tank devient très dangereux
function OnEnter_Sector_Security_Tank(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bTankIsDestroyed == 0) then
			SetVarValue(GetTankID("Tank_01"),"Rotation Speed",90)
			SetVarValue(GetTankID("Tank_01"),"Shoot Delay",0.5)
		end
	end
end

function OnEnter_Sector_Security_Tank1(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bTankIsDestroyed == 0) then
			DamageCharacter(_idPlayer,10000)
		end
	end
end

