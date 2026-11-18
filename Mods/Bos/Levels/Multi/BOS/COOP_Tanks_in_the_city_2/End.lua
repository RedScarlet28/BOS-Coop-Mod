function UpdateLevel_End ()
	ExoChangeBeahavior()
end



function OnEnter_Sector_Event_End_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_End_A_00 == 0) then
			FreezeAll(GetGroupID("Group_End_UAN_A"),false)
			Freeze(_idExo,false)
			_bOnEnter_Sector_Event_End_A_00 = 1
		end
	end
end


-- 
function ExoChangeBeahavior()
	if (_bExoChangeBeahavior == 0) then
		if CharacterCanSee(GetCharacterID("Char_Sewer_UAN_C_05"),_idPlayer)then
			SetVarValue(GetCharacterID("Char_Sewer_UAN_C_05"),"ExoskeletonOrderList",GetAI_Order_ListID ("AI_O_List_Force_Attack_Player_HIGH"))
			_bExoChangeBeahavior = 1
		end
	end
end


function OnEnter_Sector_Event_End_B_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_End_B_00 == 0) then
			FreezeAll(GetGroupID("Group_End_UAN_B"),false)
			_bOnEnter_Sector_Event_End_B_00 = 1
		end
	end
end

function OnEnter_Sector_Event_End_C_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_End_C_00 == 0) then
			FreezeAll(GetGroupID("Group_End_UAN_C"),false)
			_bOnEnter_Sector_Event_End_C_00 = 1
		end
	end
end

function OnEnter_Sector_Event_End_D_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		EndOfLevel()
	end
end
