--
function InitLevel_Corridor()
	InitScriptVariable_Corridor()
	
end


--
function UpdateLevel_Corridor()
	Update_Sector_Corridor_1()
end


-- 
function InitScriptVariable_Corridor()
	_bDialogueCorridor=false
	_bDialogueDebut=false
	_bExitFromCorridor=false
end


function Objectives_A ()
	NewObjectiveNewSubObjective ("Obj_A","Obj_A_1")
end

-- combat du tunnel
function OnEnter_Sector_Corridor_2(idEntrant)
	if (idEntrant==_idPlayer) then
		FreezeAll(GetGroupID("Grp_WRF_Corridor_1"),false)
		FreezeAll(GetGroupID("Grp_UAN_Corridor_1"),false)
	end
end

-- dialogue du premier soldat
function OnEnter_Sector_Corridor_Dialogue(idEntrant)
	if (idEntrant==_idPlayer and not _bDialogueCorridor) then
		_bDialogueCorridor=true
		MakeCharacterSpeak (GetCharacterID("Char_WRF_Corridor_2_2") ,_idPlayer,"DIA_SPE_NIV_K_USWE_H_01", true, 100,1,0.0,"",40)
		CreationTimer(true, true, false, "OnEnter_Sector_Corridor_Dialogue_Suite", 2.8)	
	end
end

function OnEnter_Sector_Corridor_Dialogue_Suite ()
	SetVarValue(GetCharacterID("Char_WRF_Corridor_2_2"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Corridor_3"))
end

-- SORTIE DU TUNNEL
function Update_Sector_Corridor_1()
	if  (_bExitFromCorridor == false) then
		if (IsEntityInBox(_idPlayer,"Sector_Corridor_1") or AliveMembersCount(GetGroupID("Grp_UAN_Corridor_1"))<=1) then
			StartMusic("Sounds//Music//Bos - War theme.wav",true)
			--FreezeAll(GetGroupID("Grp_UAN_Hide_1"),false)
			FreezeAll(GetGroupID("Grp_UAN_Corridor_3"),false)
			FreezeAll(GetGroupID("Grp_UAN_Hide_Sniper_1"),false)
			SetVarValue(GetGroupID("Grp_WRF_Corridor_1"),"GroupAIOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Hide_House_1"))
			SetVarValue(GetCharacterID("Char_WRF_Corridor_2_2"),"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Use_Path_Hide_A"))
			Freeze(GetCharacterID("Char_UAN_Hide_3_4"),false)
			Freeze(GetExoskeletonID("Exo_UAN_Hide_1"),false)
			_bExitFromCorridor=true
			MakeCharacterSpeak (GetCharacterID("Char_WRF_Corridor_2_2") ,_idPlayer,"DIA_SPE_NIV_K_INGENIEUR_15", true, 100,2,0.0,"",100)		
			CreationTimer(true, true, false, "OnEnter_Sector_Corridor_1_Suite", 2.5)	
		end
	end
end

function OnEnter_Sector_Corridor_1_Suite()
	MakeCharacterSpeak (GetCharacterID("Char_WRF_Corridor_2_2") ,_idPlayer,"DIA_SPE_NIV_K_USWE_H_02", true, 100,2,0.0,"",100)	
end

