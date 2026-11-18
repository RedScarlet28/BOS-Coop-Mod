-------------------------------------------------------------
-- :::: BOTS ACTIFS :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function ActiveBots()
	_nActiveBots = GetTotalActiveCharacterCount()
	_strPrintActiveBots = "Il y'a actuellement " .. _nActiveBots .. " actifs"
	Dialogue(true,4,_strPrintActiveBots)
end

-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Resist_Huber", "Char_Merc_1"

end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_Colonel_Huber", "Mercenary_David_Julian"

end

function OnEnter_Sector_Event_Debug(id)
	if (id == _idPlayer) then

		Freeze(_idMerc[0],true)
	--	Freeze(_idMerc[1],true)
		Freeze(GetCharacterID("Char_Resist_Cloister_00_10"),true)
		CamHuber0()
			ShowCinematicBlackStripes(true)

			_nPlayerPasse = 11
			_nHuberPasse = 11

			DisableCharCmd()

			-- Télétransportation des Mercs en zone "sécurisée"
			Teletransportation("Repere_Cloister_Player",_idPlayer)

			if (_idMerc[1] ~= nil) then 

				-- Télétransportation des Mercs en zone "sécurisée"
				Teletransportation("Repere_Cloister_Merc",_idMerc[1])

				-- Attribue une Order_List à Huber
				SetVarValue(_idMerc[1], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc_Cinema_1"))
			end

			-- Refrise les soldats de la pièce du RDC et de la pièce du haut
			Freeze(GetCharacterID("Char_Resist_Cloister_00_6"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_7"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_8"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_9"),true)

			-- DIA_SPE_NIV_O_HUBER_D_24
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_24",true,100,2,0,"",28)

	end
end


