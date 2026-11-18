--[[ Défrise les soldats du garden non défrisés plus tôt --]]

function OnEnter_Sector_Event_Garden_1(id)
	if (id == _idPlayer) then
		for i=1,3,1 do
			Freeze(GetCharacterID("Char_UAN_Sniper_Garden_" .. i), false)
		end
		for i=1,2,1 do
			Freeze(GetCharacterID("Char_UAN_Sniper_Mainstreet_" .. i), false)
		end
		Freeze(GetCharacterID("Char_UAN_Artilleur_Garden_1"), false)
	end
end

function OnEnter_Sector_Event_Garden_2(id)
	if (id == _idPlayer) then
		for i=1,3,1 do
			Freeze(GetCharacterID("Char_UAN_Sniper_Garden_" .. i), false)
		end
		for i=1,2,1 do
			Freeze(GetCharacterID("Char_UAN_Sniper_Mainstreet_" .. i), false)
		end
		Freeze(GetCharacterID("Char_UAN_Artilleur_Garden_1"), false)
		FreezeAll(GetGroupID("Grp_UAN_Museum_02"), false)
		SetVarValue(GetGroupID("Grp_UAN_Museum_02"),"GroupAIOrderList",GetAI_Order_ListID("AIO_List_Grp_UAN_Museum_02c"))
	end
end

--[[ Défrise les soldats des égouts du garden 1 --]]

function OnEnter_Sector_Event_Garden_3(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Garden_01"), false)
	end
end

--[[ Défrise les soldats des égouts du garden 2 --]]

function OnEnter_Sector_Event_Garden_4(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Garden_02"), false)
	end
end

--[[ Défrise les soldats des égouts du garden 3 --]]

function OnEnter_Sector_Event_Garden_5(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Garden_03"), false)
	end
end