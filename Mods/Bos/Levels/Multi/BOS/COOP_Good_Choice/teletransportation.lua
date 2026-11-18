--[[ Télétransportation des persos défreezés vers l'ascenseur 1 ou l'ascenseur 2 ]]--

function TeletransportationAsc1ou2(nbPersos,nomRepere1,nomRepere2,nomPersos)
	-- déplacement des persos vers les waypoints de pooint de spawn n°2
	if (_bPlayerLocation == 2) then
		vRepere = {}
		vRotation = {}
		vRotation = {}
		-- boucle de déplacement des persos
		for i=1,nbPersos,1 do
			vRepere[i] = GetVarValue(GetCharacterID(nomRepere1 .. i), "Position")
			SetVarValue(GetCharacterID(nomPersos .. i), "Position", vRepere[i])
			vRotation[i] = GetVarValue(GetCharacterID(nomRepere1 .. i), "Rotation")	
			SetVarValue(GetCharacterID(nomPersos .. i), "Rotation", vRotation[i])
		end
	else
		vRepere = {}
		vRotation = {}
		vGetRotZ = {}
		vRotation = {}
		-- boucle de déplacement des persos
		for i=1,nbPersos,1 do
			vRepere[i] = GetVarValue(GetCharacterID(nomRepere2 .. i), "Position")
			SetVarValue(GetCharacterID(nomPersos .. i), "Position", vRepere[i])
			vRotation[i] = GetVarValue(GetCharacterID(nomRepere2 .. i), "Rotation")	
			SetVarValue(GetCharacterID(nomPersos .. i), "Rotation", vRotation[i])
		end
	end
end

--[[ Télétransportation des persos défreezés vers l'ascenseur 1 ]]--

function TeletransportationAsc1(nbPersos,nomRepere1,nomPersos)
	-- déplacement des persos vers l'asc 1
	vRepere = {}
	vRotation = {}
	vRotation = {}
	-- boucle de déplacement des persos
	for i=1,nbPersos,1 do
		vRepere[i] = GetVarValue(GetCharacterID(nomRepere1 .. i), "Position")
		SetVarValue(GetCharacterID(nomPersos .. i), "Position", vRepere[i])
		vRotation[i] = GetVarValue(GetCharacterID(nomRepere1 .. i), "Rotation")	
		SetVarValue(GetCharacterID(nomPersos .. i), "Rotation", vRotation[i])
	end
end

--[[ Télétransportation des persos défreezés vers l'ascenseur 2 ]]--

function TeletransportationAsc2(nbPersos,nomRepere2,nomPersos)
	-- déplacement des persos vers l'asc 2
	vRepere = {}
	vRotation = {}
	vRotation = {}
	-- boucle de déplacement des persos
	for i=1,nbPersos,1 do
		vRepere[i] = GetVarValue(GetCharacterID(nomRepere2 .. i), "Position")
		SetVarValue(GetCharacterID(nomPersos .. i), "Position", vRepere[i])
		vRotation[i] = GetVarValue(GetWaypointID(nomRepere2 .. i), "Rotation")	
		SetVarValue(GetCharacterID(nomPersos .. i), "Rotation", vRotation[i])
	end
end