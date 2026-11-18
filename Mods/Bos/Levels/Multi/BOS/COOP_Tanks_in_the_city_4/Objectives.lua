function UpdateLevel_Objectives()
	Gameplay_Tank ()
end



function Gameplay_Tank ()
	_nHealth_Tank														= GetVarValue(_idTank_2,"Health")
	if (_nHealth_Tank	 < 725) 
	and (_bDefreeze_Group_UAN_Barricades_02 == 0)then
		FreezeAll(GetGroupID("Group_UAN_Barricades_02"),false)
		_bDefreeze_Group_UAN_Barricades_02 = 1
	end
		if (_nHealth_Tank	 < 450) 
	and (_bDefreeze_Group_UAN_Barricades_03 == 0)then
		FreezeAll(GetGroupID("Group_UAN_Barricades_03"),false)
		_bDefreeze_Group_UAN_Barricades_03 = 1
	end
	if (_nHealth_Tank <= 0) and (_bObj_A_1 == 0)then
		CreationTimer(true, true, false, "NewObjB", 1.5)	
		_bObj_A_1 = 1
	end

end


-- le premier tank se réinitialise
-- Security tank
-- Si Nolan passe le tank devient très dangereux
function OnEnter_Sector_Event_SECURE_tank_exo(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank > 0) then
			SetVarValue(_idTank_2,"Rotation Speed",100)
			SetVarValue(_idTank_2,"Shoot Delay",0.3)
		end
	end
end


function NewObjB ()
	ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
end
	

