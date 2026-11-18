

function OnEnter_Sector_Event_Cloitre_Tele(id)

	if (id == _idMerc[0]) then
		--Teletransportation("Char_Repere_Huber",_idMerc[0])
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_HeliHuber_1"))
	end
--[[
	if (id == _idPlayer) then
		Teletransportation("Char_Repere_Merc",_idMerc[1])

	end

	_idRenfort1 = GetCharacterID("Char_Resist_Renfort_1")
	if (id == _idRenfort1) then
		Teletransportation("Char_Repere_Merc",_idRenfort1)
	end	

	_idRenfort2 = GetCharacterID("Char_Resist_Renfort_2")
	if (id == _idRenfort1) then
		Teletransportation("Char_Repere_Huber",_idRenfort2)
	end
--]]
end