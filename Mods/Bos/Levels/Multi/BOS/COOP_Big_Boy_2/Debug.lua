-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0" , "Char_Merc_1"
 
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_Chris_Halirott", "Mercenary_Sunny_Mayers"

end
-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()

--	return "Champion_Panzer_Kruger"
return "Champion_Havock_Jimmy"
--return "Champion_Z"

end

--GetBetChampionFromArea failed because the area 1 doesn't exist
--(Not enough champion declared in function "Debug_GetSelectedChampions").It must be included between 0 and 1


--[[ Télétransportation du joueur pour le B.O.S ]]--

function Teletransportation(nomRepere,nomPersos)
		_vRepere = GetVarValue(GetCharacterID(nomRepere), "Position")
		SetVarValue(nomPersos, "Position", _vRepere)
		_vRotation = GetVarValue(GetCharacterID(nomRepere), "Rotation")	
		SetVarValue(nomPersos, "Rotation", _vRotation)
end


