--
function InitLevel_Heliport()

end


--
function UpdateLevel_Heliport()

end


-- Defreeze d'un exoarmor sur l'héliport
function OnEnter_Sector_Heliport_1(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bOnEnter_Sector_Heliport_1 == 0) then
			FreezeAll(GetGroupID("Grp_UAN_Heliport_4"),false)
			_bOnEnter_Sector_Heliport_1 = 1
		end
	end
end


-- Defreeze d'un groupe sur l'héliport
function OnEnter_Sector_Heliport_2(idEntrant)
	if (idEntrant==_idPlayer) then
		if (_bOnEnter_Sector_Heliport_2 == 0) then
			FreezeAll(GetGroupID("Grp_UAN_Heliport_1"),false)
			FreezeAll(GetGroupID("Grp_UAN_Heliport_3"),false)
			_bOnEnter_Sector_Heliport_2 = 1
		end
	end
end


-- IA SNIPER
function OnEnter_Sector_Heliport_Global(idEntrant)
	if (idEntrant==_idPlayer) then
 		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_1"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Force_Attack_Player"))
		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_2"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Force_Attack_Player"))
 		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_3"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Force_Attack_Player"))
 		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_4"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Force_Attack_Player"))
	end
end

-- IA SNIPER
function OnExit_Sector_Heliport_Global(idEntrant)
	if (idEntrant==_idPlayer) then
		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_1"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Heliport_7"))
		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_2"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Heliport_1"))
 		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_3"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Heliport_4"))
 		SetVarValue(GetCharacterID("Char_UAN_Heliport_3_4"),"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Heliport_5"))
	end
end