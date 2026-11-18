-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
   -- return "Char_Merc_0" , "Char_Merc_5"
 
end

-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()

	--return "Champion_Horacio_Ortega"
--return "Champion_Roskovitch_The_Butcher_of_Moscow"
	return "Champion_Sergei_Ternetchev"



end






--[[ Télétransportation du joueur pour le B.O.S ]]--

function Teletransportation(nomRepere,nomPersos)
		_vRepere = GetVarValue(GetCharacterID(nomRepere), "Position")
		SetVarValue(nomPersos, "Position", _vRepere)
		_vRotation = GetVarValue(GetCharacterID(nomRepere), "Rotation")	
		SetVarValue(nomPersos, "Rotation", _vRotation)
end


