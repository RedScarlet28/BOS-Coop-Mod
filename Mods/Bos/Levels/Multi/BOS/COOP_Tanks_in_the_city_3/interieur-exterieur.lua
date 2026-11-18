--[[ Nolan sort des égoûts --]]

--[[function OnEnter_Sector_Event_Exterieur_1(id)
	if (id == _idPlayer and _bTestSortiePlayer == false) then
		_bTestPlayerExterieur = false
	end
end--]]

--[[ Nolan entre dans les égoûts --]]

--[[function OnEnter_Sector_Event_Interieur_1(id)
	if (id == _idPlayer and _bTestSortiePlayer == false) then
		_bTestPlayerExterieur = true
	end
end--]]

--[[ gestion du fog --]]

--[[function FogChange()
	if (_bTestPlayerExterieur == true) then
		SetVarValue(GetFog_ClientID("Fog_Client_Interieur"), "Weakness", 0.9)
		SetVarValue(GetFog_ClientID("Fog_Client_Exterieur"), "Weakness",1)
	else
		SetVarValue(GetFog_ClientID("Fog_Client_Interieur"), "Weakness",1)
		SetVarValue(GetFog_ClientID("Fog_Client_Exterieur"), "Weakness",0.9)
	end
end--]]



