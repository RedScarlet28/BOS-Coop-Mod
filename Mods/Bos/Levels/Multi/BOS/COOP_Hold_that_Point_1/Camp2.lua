function UpdateLevel_Camp2 ()
	Calcul_Alive_MenbersCount_Camp2 ()
	--ReFreeze_All_Char_Camp1()
--	Defreeze_Group_WRF_Camp2_00()
	Defreeze_Assault_1()
	Defreeze_Assault_2()
	Defreeze_Assault_3()
	Defreeze_Assault_4()
	Defreeze_Assault_5()
	Defreeze_Assault_6()
	Defreeze_Assault_7()
	Defreeze_Assault_9()
	Defreeze_Assault_10()
	Defreeze_Assault_10b()
	Defreeze_Assault_11()
	Defreeze_Assault_12()
	Defreeze_Assault_13()
	Defreeze_Assault_14()
	Defreeze_Char_WRF_Camp2_01_1()
	Defreeze_Assault_Second_Portal_01 ()
	Defreeze_Assault_Second_Portal_02 ()
	Behavior_Mercenary_Camp2 ()
	Behavior_Char_WRF_Camp2_01_1 ()
	Death_All_Exo()
end

function Calcul_Alive_MenbersCount_Camp2 ()
	_nAlive_00 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_00"))
	_nAlive_01 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_01"))
	_nAlive_02 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_02"))
	_nAlive_03 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_03"))
	_nAlive_04 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_04"))
	_nAlive_05 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_05"))
	_nAlive_06 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_06"))
	_nAlive_07 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_07"))
	_nAlive_08 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_08"))
	_nAlive_09 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_09"))
	_nAlive_10 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_10"))
	_nAlive_11 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_11"))
	_nAlive_12 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_12"))
	_nAlive_13 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_13"))
	_nAlive_14 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_14"))
	_nAlive_15 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_15"))
	_nAlive_16 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_16"))
	_nAlive_17 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_17"))
	_nAlive_18 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_18"))
	_nAlive_19 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_19"))
	_nAlive_20 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_20"))
	_nAlive_21 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_21"))
	_nAlive_22 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_22"))
	_nAlive_23 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_23"))
	_nAlive_24 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_24"))
	_nAlive_25 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_25"))
	_nAlive_Para_02 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_Para_02"))
	_nAlive_Para_03 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_Para_03"))
	_nAlive_Para_00 = AliveMembersCount(GetGroupID("Group_UAN_Camp2_Para_00"))

end






-- déFreeze fait à la fin du BOS
-- Des alliés foncent vers les murailles après le combat BOS
-- defreez des premiers ennemis sur le champ de bataille
-- lancement ciné
function Defreeze_Group_WRF_Camp2_00()
	FreezeAll(GetGroupID("Group_WRF_Camp2_00"), false)
	FreezeAll(GetGroupID("Group_UAN_Camp2_14"), false)
	FreezeAll(GetGroupID("Group_UAN_Camp2_15"), false)
	FreezeAll(GetGroupID("Group_UAN_Camp2_16"), false)
	SetVarValue(GetTimerID("Timer_Camp2_Exo"),"Active",true)
	SetGodMode(GetCharacterID("Char_WRF_Camp2_00_3"), true)
	SetGodMode(GetCharacterID("Char_WRF_Camp2_00_5"), true)

	Teletransportation("Char_Cine_Repere_C",_idPlayer)
	EnableCharacterCommand(_idPlayer, false)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_A_01"))	
	_bDefreeze_Group_WRF_Camp2_00 = 1
end

-- cine suite
function Cine_Camp2_A_01()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_A_02"))
end

-- cine suite
-- refreeze du bot utilisé juste pour ciné
function Cine_Camp2_A_02()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_A_03"))
	RadioMessage("DIA_SPE_NIV_K_USWE_B_01", true, 110, 0,"")
	Freeze(GetCharacterID("Char_WRF_Camp2_00_4"), true)
	SetVarValue(GetExoskeletonID("Exo_01"),"Freeze",false)
	Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_01"), false)
	OpenDoor(GetDoorID("Door_Portal_04"))
	OpenDoor(GetDoorID("Door_Portal_03"))

	Freeze(GetExoskeletonID("Exo_05"), true)
	Freeze(GetExoskeletonID("Exo_07"), true)
end

-- cine suite
-- defreeze de l'exo
function Cine_Camp2_A_03()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_A_04"))
end
-- cine end
function Cine_Camp2_A_04()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
	RadioMessage("DIA_SPE_NIV_K_USWE_D_01", true, 110, 0,"")

---- OBJECTIF Update
--- Stop the attack of first portal
	NewSubObjective ( "Obj_A_1", "Obj_A_2")
	SetVarValue ( GetObjectiveID ( "Obj_A_a"),"Active", true )


end



-- defreeze assault 1

function Defreeze_Assault_1()
	if (_bDefreeze_Assault_1 == 0) then
		if (_nAlive_14 + _nAlive_15 + _nAlive_16 <= 2 ) then 
			FreezeAll(GetGroupID("Group_UAN_Camp2_00"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_20"), false)
			_bDefreeze_Assault_1 = 1
		end
	end
end

-- defreeze assault 2

function Defreeze_Assault_2()
	if	(_bDefreeze_Assault_2 == 0)then
		if	(_nAlive_14 + _nAlive_15 == 0 )
		and (_nAlive_16 <= 1)  then 
		FreezeAll(GetGroupID("Group_UAN_Camp2_03"), false)
		_bDefreeze_Assault_2 = 1
		end	
	end
end

-- defreeze assault 3

function Defreeze_Assault_3()
	if (_bDefreeze_Assault_3 == 0) then	
		if  (_nAlive_16 == 0 )
		and (_nAlive_00 + _nAlive_03 + _nAlive_20 <= 2 ) then
			FreezeAll(GetGroupID("Group_UAN_Camp2_09"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_22"), false)
			_bDefreeze_Assault_3 = 1
		end
	end
end

-- defreeze assault 4

function Defreeze_Assault_4()
	if (_bDefreeze_Assault_4 == 0) then	
		if  (_nAlive_16 + _nAlive_03 + _nAlive_20  <= 1 )
		and	(_nAlive_09 + _nAlive_22 <= 1 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_01"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_12"), false)
			_bDefreeze_Assault_4 = 1
		end
	end
end

-- defreeze assault 5

function Defreeze_Assault_5()
	if (_bDefreeze_Assault_5 == 0) then	

		if  (_nAlive_16 + _nAlive_03 + _nAlive_20 + _nAlive_09 + _nAlive_22  == 0 )
		and	(_nAlive_01 + _nAlive_12 <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_08"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_19"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_Para_02"), false)
			SetVarValue(GetTimerID("Timer_Camp2_ExoArmor"),"Active",true)
			_bDefreeze_Assault_5 = 1
		end
	end
end

-- defreeze assault 6

function Defreeze_Assault_6()
	if (_bDefreeze_Assault_6 == 0) then	
		if  (_nAlive_08 + _nAlive_19 + _nAlive_02 + _nAlive_01 + _nAlive_12  <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_04"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_Para_00"), false)

			MakeCharacterSpeak(GetCharacterID("Char_WRF_Camp2_00_2"),_idPlayer, "DIA_SPE_NIV_K_USWE_E_01",true,110,2, 0, "",21)

			_bDefreeze_Assault_6 = 1
		end
	end
end

-- defreeze assault 7
-- ce groupe est lourdement protégé pour donner du gameplay pendant que le joueur est censé ce battre à l'autre portail

function Defreeze_Assault_7()
	if (_bDefreeze_Assault_7 == 0) then	
		if  (_nAlive_19 + _nAlive_Para_02 + _nAlive_01 + _nAlive_12 + _nAlive_04 + _nAlive_Para_00  <= 1 )
		and (_nAlive_08 <= 0) then
			FreezeAll(GetGroupID("Group_UAN_Camp2_02"), false)
			-- timer pour Attack_On_Second_Portal
			SetVarValue(GetTimerID("Timer_Camp2_04"),"Active",true)
			_bDefreeze_Assault_7 = 1
		end
	end
end

-- defreeze assault 8 (reprise....)
-- baisse de l'armure du Group_UAN_Camp2_02

function Defreeze_Assault_8()
	if (_bDefreeze_Assault_8 == 0) then	

	
			RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_09", true, 110, 0,"")
	
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_1"),"HelmetHitPoints",0)
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_1"),"BodyHitPoints",0)
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_1"),"LegsHitPoints",0)
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_2"),"HelmetHitPoints",0)
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_2"),"BodyHitPoints",0)
			SetVarValue(GetCharacterID("Char_UAN_Camp2_02_2"),"LegsHitPoints",0)

			FreezeAll(GetGroupID("Group_UAN_Camp2_10"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_21"), false)
			_bDefreeze_Assault_8 = 1
	end
end

-- defreeze assault 9

function Defreeze_Assault_9()
	if (_bDefreeze_Assault_9 == 0) then
		if  (_nAlive_08 + _nAlive_19 + _nAlive_Para_02 + _nAlive_01 + _nAlive_12 + _nAlive_04 + _nAlive_Para_00 + _nAlive_02 == 0 )
		and	(_nAlive_10 + _nAlive_21 <= 2 )then
			Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_02"), false)
			SetVarValue(GetExoskeletonID("Exo_02"),"Freeze",false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_07"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_17"), false)
			_bDefreeze_Assault_9 = 1
		end
	end
end

-- defreeze assault 10

function Defreeze_Assault_10()
	if (_bDefreeze_Assault_10 == 0) then	
		if  (_nAlive_10 + _nAlive_21 + _nAlive_07 + _nAlive_17 <= 2 )then
			Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_04"), false)
			SetVarValue(GetExoskeletonID("Exo_04"),"Freeze",false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_18"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_22"), false)
			_bDefreeze_Assault_10 = 1
		end
	end
end

-- defreeze assault 10b

function Defreeze_Assault_10b()
	if (_bDefreeze_Assault_10b == 0) and (_bDeath_All_Exo == 0) then
		if  (_nAlive_10 + _nAlive_21 + _nAlive_07 + _nAlive_17 + _nAlive_18 + _nAlive_22  <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_23"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_Para_03"), false)
			_bDefreeze_Assault_10b = 1
		end
	end
end

-- defreeze assault 11

function Defreeze_Assault_11()
	if (_bDefreeze_Assault_11 == 0) and (_bDeath_All_Exo == 0) then
		if	(_nAlive_10 + _nAlive_21 + _nAlive_07 + _nAlive_17 + _nAlive_18 + _nAlive_22  <= 1 )
		and	(_nAlive_23 + _nAlive_Para_03 <= 1 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_06"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_24"), false)
			_bDefreeze_Assault_11 = 1
		end
	end
end

-- defreeze assault 12

function Defreeze_Assault_12()
	if (_bDefreeze_Assault_12 == 0) and (_bDeath_All_Exo == 0) then
	if	(_nAlive_10 + _nAlive_21 + _nAlive_07 + _nAlive_17 + _nAlive_18 + _nAlive_22  == 0 )
		and	(_nAlive_23 + _nAlive_Para_03 + _nAlive_06 + _nAlive_24 <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_13"), false)
			_bDefreeze_Assault_12 = 1
		end
	end
end

-- defreeze assault 13

function Defreeze_Assault_13()
	if (_bDefreeze_Assault_13 == 0) and (_bDeath_All_Exo == 0) then	
		if	(_nAlive_23 + _nAlive_Para_03 + _nAlive_06 + _nAlive_24 + _nAlive_13  <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_05"), false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_25"), false)
			_bDefreeze_Assault_13 = 1
		end
	end
end

-- defreeze assault 14

function Defreeze_Assault_14()
	if (_bDefreeze_Assault_14 == 0) and (_bDeath_All_Exo == 0) then
		if	(_nAlive_23 + _nAlive_Para_03 + _nAlive_06 + _nAlive_24 + _nAlive_13 + _nAlive_05 + _nAlive_25  <= 2 )then	
			FreezeAll(GetGroupID("Group_UAN_Camp2_11"), false)
			_bDefreeze_Assault_14 = 1
		end
	end
end

-- Le mercenaire suit Nolan ou se poste sur les murailles selon la position de Nolan
function Behavior_Mercenary_Camp2 ()
	if _nPhase == 2 then
		if (_idMerc[1] ~= nil) then
			if IsEntityInBox(_idPlayer,"Sector_Event_Camp1_C_01")then
				if GetVarValue(_idMerc[1],"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Path_Camp2_A_02")then
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Path_Camp2_A_02"))	
				end
			elseif IsEntityInBox(_idPlayer,"Sector_Event_Camp2_C_00")then
				if GetVarValue(_idMerc[1],"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_Path_Camp2_A_10")then
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Path_Camp2_A_10"))			
				end
			else
				if GetVarValue(_idMerc[1],"CharacterOrderList") ~= GetAI_Order_ListID("AI_O_List_TYP_Mercenary")then
					SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_TYP_Mercenary"))	
				end
			end
		end
	end
end


-- Attaque deuxième porte
function Attack_On_Second_Portal ()
	RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_02", true, 110, 0,"")
	SetVarValue(GetTimerID("Timer_Camp2_02"),"Active",true)
	ShowCinematicBlackStripes(true)
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_B_01"))
	EnableCharacterCommand(_idPlayer, false)	
	_bAttack_On_Second_Portal = 1
end

-- cine suite
function Cine_Camp2_B_01()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Camp2_B_02"))
end

-- cine end
function Cine_Camp2_B_02()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer, true)
---- OBJECTIF Update
--- Stop the attack of second portal
	NewSubObjective ( "Obj_A_2", "Obj_A_3")

end

-- spawn d'un allié
function Defreeze_Char_WRF_Camp2_01_1()
	if (_bDefreeze_Char_WRF_Camp2_01_1 == 0)
	and (_bAttack_On_Second_Portal == 1)
	--and (_bOnEnter_Sector_Event_Camp1_B_00 == 0) then
	and not IsEntityInBox(GetCharacterID("Char_WRF_Camp2_01_1"),"Sector_Event_Camp2_C_00")then
			Freeze(GetCharacterID("Char_WRF_Camp2_01_1"), false)
			_bDefreeze_Char_WRF_Camp2_01_1 = 1
		end
end

-- Nolan est-il pres de la deuxième muraille??
function OnEnter_Sector_Event_Camp2_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp2_B_00 == 0) then
			_bOnEnter_Sector_Event_Camp2_B_00 = 1
		end
	end
end

function OnExit_Sector_Event_Camp2_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Camp2_B_00 == 1) then
				_bOnEnter_Sector_Event_Camp2_B_00 = 0
		end
	end
end

-- defreeze assault deuxième portail 01

function Defreeze_Assault_Second_Portal_01()
	if (_bDefreeze_Assault_Second_Portal_01 == 0)then
		if	(_bAttack_On_Second_Portal == 1 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_50"), false)
			_bDefreeze_Assault_Second_Portal_01 = 1
		end
	end
end

-- defreeze de l'Exo portail 2
-- defreeze de parachutistes

function Defreeze_EXO_03()
	if (_bDefreeze_EXO_03 == 0)then
			Freeze(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_03"), false)
			SetVarValue(GetExoskeletonID("Exo_03"),"Freeze",false)
			FreezeAll(GetGroupID("Group_UAN_Camp2_Para_01"), false)	
			SetVarValue(GetTimerID("Timer_Camp2_Exo2"),"Active",true)
			_bDefreeze_EXO_03 = 1
	end
end

-- defreeze assault deuxième portail 02

function Defreeze_Assault_Second_Portal_02()
	if (_bDefreeze_Assault_Second_Portal_02 == 0)then 	
		if	(AliveMembersCount(GetGroupID("Group_UAN_Camp2_50")) <= 2 )then
			FreezeAll(GetGroupID("Group_UAN_Camp2_51"), false)
			_bDefreeze_Assault_Second_Portal_02 = 1
		end
	end
end

-- Tous les ennemis du portail 2 sont morts !!!
-- New objective
-- Changement de place du Char_WRF_Camp2_01_1

function Behavior_Char_WRF_Camp2_01_1 ()
	if (_bBehavior_Char_WRF_Camp2_01_1 == 0)then 	
		if 	(GetVarValue(GetExoskeletonID("Exo_03"),"Health") <= 0 )
		and (AliveMembersCount(GetGroupID("Group_UAN_Camp2_50")) <= 0 )
		and (AliveMembersCount(GetGroupID("Group_UAN_Camp2_51")) <= 0 )then
			SetVarValue(GetTimerID("Timer_Camp2_05"),"Active",true)
			SetVarValue(GetTimerID("Timer_Explosion"),"Active",true)
			_bBehavior_Char_WRF_Camp2_01_1 = 1
		end
	end
end

-- ReAttack_First_Portal
function ReAttack_First_Portal ()
	Defreeze_Assault_8()
	SetVarValue(GetTimerID("Timer_Camp2_01"),"Active",true)
	SetVarValue(GetCharacterID("Char_WRF_Camp2_01_1"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Path_Camp2_A_07"))	
end

---- OBJECTIF Update
---- "Re go to the first portal"
function Obj_A_3_Update ()
	NewSubObjective ( "Obj_A_3", "Obj_A_4")
end




-- IA EXO BATTLEFIELD
-- random de comportement
-- si le joueur n'est pas sur les ramparts exo ne tire que sur le portal
function IA_Exo_Battlefield ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Camp1_C_01")then 

	--	_nBehavior_Exo_Type = GetRandom(1,3)
		_nBehavior_Exo_Type = 1
		if 	_nBehavior_Exo_Type == 1 then -- Attack  player
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_01"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Player"))	
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_04"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Player"))
		elseif _nBehavior_Exo_Type == 2 then -- Attack portal
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_01"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Portal"))
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_04"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Portal"))	
		else -- Attack all
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_01"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_All"))
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_04"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_All"))	
		end
	
	else 
		SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_01"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Portal"))
		SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_04"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_1_Force_Attack_Portal"))
	end 

	_nTiming_Change_Beahavior_Exo = GetRandom(10,15)
	SetVarValue(GetTimerID("Timer_Camp2_Exo"),"Duration",_nTiming_Change_Beahavior_Exo)

end

-- IA EXO PORTAL 2
-- random de comportement
-- si le joueur n'est pas sur les ramparts exo ne tire que sur le portal
function IA_Exo_Second_Portal ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Camp2_C_00")then 
		--_nBehavior_Exo_Type = GetRandom(1,3)
		_nBehavior_Exo_Type = 1
		if 	_nBehavior_Exo_Type == 1 then -- Attack  player
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_03"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_3_Force_Attack_Player"))	
		elseif _nBehavior_Exo_Type == 2 then -- Attack portal
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_03"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_3_Force_Attack_Portal2"))	
		else -- Attack all
			SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_03"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_3_Force_Attack_All"))
		end
	else 
		SetVarValue(GetCharacterID("Char_UAN_Camp2_Pilote_EXO_03"),"ExoskeletonOrderList",GetAI_Order_ListID("AI_O_List_Exo_3_Force_Attack_Portal2"))
	end 
	_nTiming_Change_Beahavior_Exo = GetRandom(10,15)
	SetVarValue(GetTimerID("Timer_Camp2_Exo2"),"Duration",_nTiming_Change_Beahavior_Exo)
end


-- IA EXOARMOR BATTLEFIELD
-- random de comportement
-- si le joueur n'est pas sur les ramparts exo ne tire que sur le portal
function IA_ExoArmor_Battlefield ()
	if IsEntityInBox(_idPlayer,"Sector_Event_Camp1_C_01")then 

		--_nBehavior_Exo_Type = GetRandom(1,3)
		_nBehavior_Exo_Type = 1
		if 	_nBehavior_Exo_Type == 1 then -- Attack  player
			SetVarValue(GetCharacterID("Char_UAN_Camp2_08_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Player"))	
			SetVarValue(GetCharacterID("Char_UAN_Camp2_06_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Player"))
		elseif _nBehavior_Exo_Type == 2 then -- Attack portal
			SetVarValue(GetCharacterID("Char_UAN_Camp2_08_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Portal"))
			SetVarValue(GetCharacterID("Char_UAN_Camp2_06_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Portal"))	
		else -- Attack all
			SetVarValue(GetCharacterID("Char_UAN_Camp2_08_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_All"))
			SetVarValue(GetCharacterID("Char_UAN_Camp2_06_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_All"))	
		end
	
	else 
		SetVarValue(GetCharacterID("Char_UAN_Camp2_08_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Portal"))
		SetVarValue(GetCharacterID("Char_UAN_Camp2_06_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_ExoArmor_Force_Attack_Portal"))
	end 

	_nTiming_Change_Beahavior_Exo = GetRandom(10,15)
	SetVarValue(GetTimerID("Timer_Camp2_ExoArmor"),"Duration",_nTiming_Change_Beahavior_Exo)

end



-- La mort de tous les exos lance la suite
function Death_All_Exo ()
	if	((GetVarValue(GetExoskeletonID("Exo_01"),"Health") <= 0 )
	and	(GetVarValue(GetExoskeletonID("Exo_02"),"Health") <= 0 )
	and	(GetVarValue(GetExoskeletonID("Exo_03"),"Health") <= 0 )
	and	(GetVarValue(GetExoskeletonID("Exo_04"),"Health") <= 0 )
	and (GetVarValue(GetCharacterID("Char_UAN_Camp2_06_2"),"Health") <= 0 )
	and (_bDeath_All_Exo == 0)) then
		_bDeath_All_Exo = 1
		SetVarValue(GetTimerID("Timer_Camp2_Exo"),"Active",false)
		SetVarValue(GetTimerID("Timer_Camp2_Exo2"),"Active",false)
		SetVarValue(GetTimerID("Timer_Camp2_ExoArmor"),"Active",false)
		SetVarValue(GetTimerID("Timer_Camp2_03"),"Active",true)
	end
end

function Death_All_Exo_2 ()
	Objectif_1_Done ()
end

