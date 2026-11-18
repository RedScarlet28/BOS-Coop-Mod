function UpdateLevel_Suite ()
	Defreeze_Group_Suite_UAN_03 ()
	Defreeze_Group_Suite_UAN_04 ()
	Defreeze_Group_Suite_UAN_05 ()
	Defreeze_Group_Suite_UAN_07 ()
	Defreeze_Char_Suite_UAN_06_01 ()
	Defreeze_Exoskeleton_UAN_QG_01 ()
	--Engineer_See_Exo ()
end


-- ATTAQUE DE LA TORTUE
-- siege QG
function OnEnter_Sector_Event_Suite_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bComputer_Hacked == 1)then  
			if (_bOnEnter_Sector_Event_Suite_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_01"), false)
			FreezeAll(GetGroupID("Group_Suite_UAN_02"), false)
			Freeze(_idExo,false)
			Freeze(_Pilote_exo,false)
			StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite_A_02"))
			ShowCinematicBlackStripes(true)
			EnableCharacterCommand(_idPlayer, false)
			SetGodMode(_idPlayer,true)
			SetGodMode(_idMerc[0],true)


			if (_idMerc[0] ~= nil) then 
					Teletransportation("Repere_Merc_CINE_0",_idMerc[0])
					SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite_D_00"))
					SetGodMode(_idMerc[0],true)
			end			
			if (_idMerc[1] ~= nil) then 
					Teletransportation("Repere_Merc_CINE_1",_idMerc[1])
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Suite_C_00"))	
					SetGodMode(_idMerc[1],true)
			end	
			_bOnEnter_Sector_Event_Suite_A_00 = 1
			CreationTimer(true,true,false,"Engineer_See_Exo",22.0)
			

			end
		end
	end
end

-- cine suite
function Cine_Suite_A_01()
	--LaunchCameraTransition(GetCamTransitionID("CamTransition_Suite_A_02"))
end
-- cine end
function Cine_Suite_A_02()
	EnableCharacterCommand(_idPlayer, true)
	--SetGodMode(_idMerc[0],false)
	SetGodMode(_idPlayer,false)
	MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_17",true,110,2, 0, "",21)	
	ShowCinematicBlackStripes(false)		
end


-- defreeze renfort siège 1
function Defreeze_Group_Suite_UAN_03 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_02"))<= 1)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_02")then
		if (_bDefreeze_Group_Suite_UAN_03 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_03"), false)
			_bDefreeze_Group_Suite_UAN_03 = 1
		end
	end
end

-- defreeze renfort siège 2
function Defreeze_Group_Suite_UAN_04 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_03"))<= 0)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_02")then
		if (_bDefreeze_Group_Suite_UAN_04 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_04"), false)
			_bDefreeze_Group_Suite_UAN_04 = 1
		end
	end
end

-- defreeze renfort sur les coursives
-- Attention blindé le déclenchement par box (rajouter une box... a voir)
function Defreeze_Group_Suite_UAN_05 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_01"))<= 4)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_03")then
		if (_bDefreeze_Group_Suite_UAN_05 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_05"), false)
			_bDefreeze_Group_Suite_UAN_05 = 1
		end
	end
end

-- defreeze renfort siège 3
function Defreeze_Group_Suite_UAN_07 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_01"))<= 3)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_02")then
		if (_bDefreeze_Group_Suite_UAN_07 == 0) then
			FreezeAll(GetGroupID("Group_Suite_UAN_07"), false)
			_bDefreeze_Group_Suite_UAN_07 = 1
		end
	end
end


-- defreeze sniper coursive en hauteur
function Defreeze_Char_Suite_UAN_06_01 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_01"))<= 1)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_02")then
		if (_bDefreeze_Char_Suite_UAN_06_01 == 0) then
			Freeze(GetCharacterID("Char_Suite_UAN_06_01"), false)
			_bDefreeze_Char_Suite_UAN_06_01 = 1
		end
	end
end

--defreeze de l'exo
function Defreeze_Exoskeleton_UAN_QG_01 ()
	if	(AliveMembersCount(GetGroupID("Group_Suite_UAN_01"))<= 2)
	or 	(AliveMembersCount(GetGroupID("Group_Suite_UAN_07"))<= 2)
	or	IsEntityInBox(_idPlayer,"Sector_Event_Suite_A_04")then
		if (_bDefreeze_Exoskeleton_UAN_QG_01 == 0) then
			--Freeze(_idExo, false)
				Freeze(_Pilote_exo, false)		
			_bDefreeze_Exoskeleton_UAN_QG_01 = 1
		end
	end
end

--dialogue ingénieur exo 1
function Engineer_See_Exo ()
--	if CharacterCanSee(_idPlayer,_Pilote_exo)
--	and CharacterCanSee(_idEngineer,_Pilote_exo)then
	--if CharacterCanSee(_idPlayer,_idExo)
	--and CharacterCanSee(_idEngineer,_idExo)then
		if (_bEngineer_See_Exo == 0)then
			MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_18",true,110,2, 0, "",21)			
			SetVarValue(GetTimerID("Timer_QG_A_01"),"Active",true)
			_bEngineer_See_Exo = 1
		end
--	end
end

--dialogue ingénieur exo 2
--ingénieur demande le soutien aérien
function Engineer_call_Support_01 ()
		MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_19",true,110,2, 0, "",21)			
		SetVarValue(GetTimerID("Timer_QG_A_02"),"Active",true)
end



--ingénieur demande le soutien aérien
function Engineer_call_Support_02 ()
		MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_20",true,110,2, 0, "",21)			
		SetVarValue(_idEngineer,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_O_Use_Path_QG_H"))			
		SetVarValue(GetTimerID("Timer_QG_A_03"),"Active",true)
end

--ingénieur demande le soutien aérien
function Engineer_call_Support_03 ()
		if IsEntityInBox(_idPlayer,"Sector_Event_QG_D_01")then
			MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_21",true,110,2, 0, "",21)			
		else
			MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_22",true,110,2, 0, "",21)			
		end
		SetVarValue(GetTimerID("Timer_QG_A_04"),"Active",true)
end

--ingénieur demande le soutien aérien
function Engineer_call_Support_04 ()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1094,-1450,250))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1063,-1500,500))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1099,-1580,750))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1145,-1686,800))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1136,-1745,1250))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	
	-- explosion vers player
	vPosition_player = GetVarValue(_idPlayer, "Position" )
	vPosition_player = (Vector3D(0,0,600) + vPosition_player)
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	vPosition_player)
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")

	SetVarValue(GetTimerID("Timer_QG_A_05"),"Active",true)

end

--ingénieur demande le soutien aérien
function Engineer_call_Support_05 ()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1000,-1760,250))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1080,-1830,500))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(990,-1833,750))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1125,-1644,950))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(980,-1750,1000))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	
	SetVarValue(GetTimerID("Timer_QG_A_06"),"Active",true)
end

--ingénieur demande le soutien aérien
function Engineer_call_Support_06 ()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1060,-1440,250))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1050,-1915,500))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1060,-1943,750))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1100,-1929,950))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1070,-1800,1000))
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement_Hurt_2")
	-- explosion vers exo
	vPosition_exo = GetVarValue(_idExo, "Position" )
	vPosition_exo = (Vector3D(0,0,300) + vPosition_exo)
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",vPosition_exo)
	SetVarValue(idExplosion,"Rotation",	Vector3D(0.5,3.1,-2.6))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")

	nLife_Exo  = GetVarValue(_Pilote_exo, "Health" )
	nLife_Exo = 	(nLife_Exo / 4)
	SetVarValue(_idExo,"Health",nLife_Exo)
	SetVarValue(GetTimerID("Timer_QG_A_07"),"Active",true)
end


-- fin des bombardements
-- selon vie exo, lingénieur ne dit pas la meme chose
function Engineer_call_Support_07 ()
	if IsAlive(_Pilote_exo) then
		MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_23",true,110,2, 0, "",21)			
	else
		MakeCharacterSpeak(_idEngineer,_idPlayer,"DIA_SPE_NIV_E_INGENIEUR_24",true,110,2, 0, "",21)	
	end
		if (_idMerc[0] ~= nil) then 
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))
		SetGodMode(_idMerc[0],false)
	end			
	if (_idMerc[1] ~= nil) then 
			SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Follow_Player"))	
			SetGodMode(_idMerc[1],false)
	end	
	SetVarValue(GetDoorID("Door_12"),"Locked",false) 
	OpenDoor(GetDoorID("Door_12"))
end





--[[
]]
