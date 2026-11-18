--
function InitLevel_Hangar()
	_bObj_B_1								= 0
end


--
function UpdateLevel_Hangar()
	PlayerIsInExo ()
	Life_Tank_02 ()
end


--
function OnEnter_Sector_Hangar_1(idEntrant)
	if (idEntrant==_idPlayer) then
		if (not _bVolExo) then
			-- Les autres persos sont squeeze
			--Optimisitron()
			FreezeAll(GetGroupID("Grp_UAN_Hangar_1"),false)
			FreezeAll(GetGroupID("Grp_UAN_Hangar_2"),false)
			FreezeAll(GetGroupID("Grp_UAN_Hangar_3"),false)
			FreezeAll(GetGroupID("Grp_UAN_Hangar_Sniper_1"),false)
			Freeze(GetExoskeletonID("Exo_UAN_Hangar_3"),false)
			Freeze(GetCharacterID("Char_Pilote_Exo_Hangar_3"),false)
			Freeze(GetExoskeletonID("Exo_UAN_Hangar_2"),false)
		else
			-- L'hélicoptère se pointe ammenant des renforts
			Freeze(GetCharacterID("Char_UAN_ADM_1"),false)
			Freeze(GetCharacterID("Char_UAN_ADM_2"),false)
			Freeze(GetCharacterID("Char_UAN_ADM_3"),false)
			Freeze(GetCharacterID("Char_UAN_ADM_4"),false)
			FreezeAll(GetGroupID("Grp_UAN_Heliport_Sniper_1"),false)
			--SetVarValue(GetTimerID("Timer_Assaut"),"Active",true)
			-- Les autres exo vont commencer à bouger vers le joueur
		end
	end
end


--
function OnEnter_Sector_Hangar_2(idEntrant)
	if (idEntrant==_idPlayer) then	
		FreezeAll(GetGroupID("Grp_UAN_Hangar_2"),false)
		Freeze(GetExoskeletonID("Exo_UAN_Hangar_3"),false)
		Freeze(GetCharacterID("Char_Pilote_Exo_Hangar_3"),false)
		-- Pour un peu optimiser le truc, en r"duisant les persos
		--FreezeAll(GetGroupID("Grp_UAN_Hide_8"),true)
		--FreezeAll(GetGroupID("Grp_UAN_Hide_9"),true)
		--FreezeAll(GetGroupID("Grp_UAN_Heliport_4"),true)
	end
end


--
function OnEnter_Sector_Hangar_3(idEntrant)
	if (idEntrant==_idPlayer) then
		-- Super fonction pour alléger tout ça
	--	Optimisitron()
		-- un acceuil
		FreezeAll(GetGroupID("Grp_UAN_Hangar_1"),false)
		FreezeAll(GetGroupID("Grp_UAN_Hangar_2"),false)
		FreezeAll(GetGroupID("Grp_UAN_Hangar_3"),false)
		Freeze(GetExoskeletonID("Exo_UAN_Hangar_2"),false)
		FreezeAll(GetGroupID("Grp_UAN_Hangar_Sniper_1"),false)
	end
end


--
function OnEnter_Sector_Hangar_4(idEntrant)
	if (idEntrant==_idPlayer and not _bVolExo) then	
		-- Une troupe lourdement armée vient voir
		FreezeAll(GetGroupID("Grp_UAN_Hangar_4"),false)
	end
end


--
function OnEnter_Sector_Hangar_5(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bVolExo) then
			-- L'hélicoptère se pointe ammenant des renforts
			Freeze(GetCharacterID("Char_UAN_ADM_2"),false)
			Freeze(GetCharacterID("Char_UAN_ADM_3"),false)
			Freeze(GetCharacterID("Char_UAN_ADM_4"),false)
			FreezeAll(GetGroupID("Grp_UAN_Heliport_Sniper_1"),false)
		end
	end
end


--
function OnEnter_Sector_Hangar_6(idEntrant)
	if (idEntrant==_idPlayer) then	
		FreezeAll(GetGroupID("Grp_UAN_Hangar_4"),false)
	end
end



function PlayerIsInExo ()
	if (_bVolExo == false) then
		if ( IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer))) then
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )
			CreationTimer(true, true, false, "PlayerIsInExo_2", 3.5)	
			_bVolExo=true
		end
	end
end

function PlayerIsInExo_2 ()
	SetVarValue(GetSound_ClientID("Sound_Hangar_Alarme"),"Playing",true)
	if (IsAlive(GetCharacterID("Char_UAN_Hangar_1_1"))) then
	 	MakeCharacterSpeak (GetCharacterID("Char_UAN_Hangar_1_1") ,_idPlayer,"DIA_SPE_NIV_K_UAN_A_01", true, 100,2,6.0,"Blabla",100)
	elseif (IsAlive(GetCharacterID("Char_UAN_Hangar_1_2"))) then
		MakeCharacterSpeak (GetCharacterID("Char_UAN_Hangar_1_2") ,_idPlayer,"DIA_SPE_NIV_K_UAN_A_01", true, 100,2,6.0,"Blabla",100)
	elseif (IsAlive(GetCharacterID("Char_UAN_Hangar_3_1"))) then
		MakeCharacterSpeak (GetCharacterID("Char_UAN_Hangar_3_1") ,_idPlayer,"DIA_SPE_NIV_K_UAN_A_01", true, 100,2,6.0,"Blabla",100)
	end
end


function Blabla()
	if (IsAlive(GetCharacterID("Char_UAN_Hangar_4_1"))) then
		MakeCharacterSpeak (GetCharacterID("Char_UAN_Hangar_4_1") ,_idPlayer,"DIA_SPE_NIV_K_UAN_B_01", true, 100,2,0.0,"",100)
	end
end

-- le premier tank se réinitialise
function OnEnter_Sector_Hangar_Global1(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank_01 > 0) then
		TankCancelAttack(GetTankID("Tank_02"))
		TankFireAtPosition(GetTankID("Tank_02"),Vector3D(2800,120,50))
		CreationTimer(true, true, false, "OnEnter_Sector_Hangar_Global1_Suite", 5.0)	
		end
	end
end


function OnEnter_Sector_Hangar_Global1_Suite()
	TankCancelAttack(GetTankID("Tank_02"))
	TankTargetEntity(GetTankID("Tank_02"),_idPlayer)
end


-- mort du premier tank
-- Updatation objectives
function Life_Tank_02 ()
	_nHealth_Tank_02 = GetVarValue(GetTankID("Tank_02"),"Health")
	PrintDebug("_nHealth_Tank_02 = " .. 	_nHealth_Tank_02 )
	if (_nHealth_Tank_02 <= 0) and ( _bObj_B_1 == 0)then
		CreationTimer(true, true, false, "SubObj_1_Done", 2.5)	
		_bObj_B_1 = 1
	end
end

-- Update obj, tank dead
function SubObj_1_Done ()
	NewSubObjective ("Obj_B_1","Obj_B_2")
end



----SECURITY FALL
-------------------------------------------------------------------
function OnEnter_Sector_Event_Security_Fall(id)

	if(id==_idPlayer)then
		DamageCharacter(id,10000)
	end
end