--[[ Défrise les soldats du musée 1 --]]

function OnEnter_Sector_Event_Museum_1(id)
	if (id == _idPlayer) then
		for i=1,6,1 do
			Freeze(GetCharacterID("Char_UAN_Museum_00_" .. i), false)
		end
		for i=1,3,1 do
			Freeze(GetCharacterID("Char_UAN_Garden_00_" .. i), false)
		end
		for i=1,3,1 do
			Freeze(GetCharacterID("Char_UAN_Mainstreet_00_" .. i), false)
		end
		Freeze(GetCharacterID("Char_UAN_Sniper_Museum_1"), false)
		SetVarValue(GetCharacterID("Char_UAN_Sniper_Museum_1"),"CurrentSlot","OneHanded")
	end
end

--[[ Défrise les soldats du musée 2 --]]

function OnEnter_Sector_Event_Museum_2(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Museum_01"), false)
	end
end

--[[ Défrise les soldats du musée 3 --]]

function OnEnter_Sector_Event_Museum_3(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Museum_02"), false)
	end
end


--[[ Défrise les soldats du musée 4 --]]

function OnEnter_Sector_Event_Museum_4(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Museum_03"), false)
		FreezeAll(GetGroupID("Grp_UAN_Museum_02"), false)
		SetVarValue(GetGroupID("Grp_UAN_Museum_02"),"GroupAIOrderList",GetAI_Order_ListID("AIO_List_Grp_UAN_Museum_02b"))
	end
end

