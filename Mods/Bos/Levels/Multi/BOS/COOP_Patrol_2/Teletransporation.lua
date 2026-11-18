--[[ Télétransportation du joueur pour le B.O.S ]]--

function Teletransportation(nomRepere,nomPersos)
		_vRepere = GetVarValue(GetCharacterID(nomRepere), "Position")
		SetVarValue(nomPersos, "Position", _vRepere)
		_vRotation = GetVarValue(GetCharacterID(nomRepere), "Rotation")	
		SetVarValue(nomPersos, "Rotation", _vRotation)
end

-- Teletransportation("Char_Champion_0_Repere_Player","Player")