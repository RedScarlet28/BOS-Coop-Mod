-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
   return "Char_Merc_0" , "Char_Merc_1"
end

-- Name merc debug
function Debug_GetSelectedMercenariesName()
   return "Mercenary_Ewan_Williams", "Mercenary_Steven_Galahan"
end

-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()


	--	return "Champion_Hanz_Waltz"
--	return "champion_Destruction_Harry"
	return "champion_Wolfgang_Eisernteufel_Heinrich"


end
--Hanz_Waltz
--Destruction_Harry
--Wolfgang_Eisernteufel_Heinrich

--function OnEnter_Sector_Event_Champion_DEBUG(id)
--	if (id == _idPlayer) then
	--	Freeze(_idChampion_0, false)
--	end
--end



--[[ Télétransportation du joueur pour le B.O.S ]]--

function Teletransportation(nomRepere,nomPersos)
		_vRepere = GetVarValue(GetCharacterID(nomRepere), "Position")
		SetVarValue(nomPersos, "Position", _vRepere)
		_vRotation = GetVarValue(GetCharacterID(nomRepere), "Rotation")	
		SetVarValue(nomPersos, "Rotation", _vRotation)
end


