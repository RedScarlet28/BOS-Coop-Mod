
--[[ :::: DEBUG :::: Kill le Player s'il joue au con :-P 

function OnEnter_Sector_Event_Sanction_1(id)
	if (id == _idPlayer) then
		SetVarValue(_idPlayer, "Health",0)
	end
end
--]]

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0" , "Char_Merc_1"
 
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_Miguel_Ibanez", "Mercenary_Michel_Sabran"


end


-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()

--	return "Champion_Raymundo_Vargas", "Champion_Giusepe_Vito"
--	return "Champion_Yong_Sook_Yoon", "Champion_Giusepe_Vito"
--return "Champion_Le_Templier_rouge", "Champion_Giusepe_Vito"
return "Champion_Le_Templier_rouge", "Champion_Simon_Ice"
--return "Champion_Le_Templier_rouge", "Champion_Xavier_Maracas_Estrada"
--return "Champion_Le_Templier_rouge", "Champion_Giusepe_Vito"



end



function ActiveBots()
	_nActiveBots = GetTotalActiveCharacterCount()
	_strPrintActiveBots = "Il y'a actuellement " .. _nActiveBots .. " actifs"
--	Dialogue(true,4,_strPrintActiveBots)
end

