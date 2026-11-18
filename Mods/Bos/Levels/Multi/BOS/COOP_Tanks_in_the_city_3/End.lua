function UpdateLevel_End()
	Gameplay_Tank ()
end


function OnEnter_Sector_Event_End_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_End_A_00 == 0) then
			OpenDoor(GetDoorID("Door_Portal"))
			FreezeAll(GetGroupID("Group_UAN_End_B"),false)
			StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
			_bOnEnter_Sector_Event_End_A_00 = 1
		end
	end
end


function OnEnter_Sector_Event_End_A_01 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_End_A_01 == 0) then
			SetVarValue(GetSound_ClientID("Sound_Client_Alarma"),"Playing",true)	
			_bOnEnter_Sector_Event_End_A_01 = 1
		end
	end
end



function Gameplay_Tank ()
	_nHealth_Tank														= GetVarValue(_idTank,"Health")
	PrintDebug("_nHealth_Tank = " .. 	_nHealth_Tank )
	if (_nHealth_Tank	 < 700) 
	and (_bDefreeze_Group_UAN_End_C == 0)then
		FreezeAll(GetGroupID("Group_UAN_End_C"),false)
		_bDefreeze_Group_UAN_End_C = 1
	end
		if (_nHealth_Tank	 < 300) 
	and (_bDefreeze_Group_UAN_End_D == 0)then
		FreezeAll(GetGroupID("Group_UAN_End_D"),false)
		_bDefreeze_Group_UAN_End_D = 1
	end
	if (_nHealth_Tank <= 0) and (_bObj_A_1 == 0)then
		CreationTimer(true, true, false, "SubObj_1_Done", 2.5)	
		_bObj_A_1 = 1
	end

end


-- le premier tank se réinitialise
-- Security tank
-- Si Nolan passe le tank devient très dangereux
function OnEnter_Sector_Event_End_A_03(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank > 0) then
			SetVarValue(_idTank,"Rotation Speed",90)
			SetVarValue(_idTank,"Shoot Delay",0.5)
		end
	end
end


-- Update obj, tank dead
function SubObj_1_Done ()
	NewSubObjective ("Obj_A_1","Obj_A_2")
end


function OnEnter_Sector_Event_End_Of_Level(id)
	if (id == _idPlayer) then
		if(_bObj_A_1 == 1) then
			EndOfLevel()
		end
	end
end