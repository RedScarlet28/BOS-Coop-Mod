-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0" , "Char_Merc_7" 
 
end

-- Name merc debug
function Debug_GetSelectedMercenariesName()
 
 return "Mercenary_Pilaf_Olsen", "Mercenary_Steven_Galahan"

end



-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()


--	return "Champion_Tao_Ren" , "Champion_Kangaroo_James"
--return "Champion_Nikos_Iliadis" , "Champion_Kangaroo_James"
--return "Champion_David_Dack" , "Champion_Kangaroo_James"

--	return "Champion_Tao_Ren" , "Champion_Yucheng_Qin"
--	return "Champion_Tao_Ren" , "Champion_Kangaroo_James"
	return "Champion_Tao_Ren" , "Champion_Sidi_N_Goma"



end




-------------------------------------------------------------
-- :::: DIVERS :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
function Debug_TELEPORT_1 ()
	if IsEntityInBox(_idPlayer,"Sector_Event_DEBUG_01")then
	--	Teletransportation("Char_DEBUG_Repere_01",_idPlayer)
	end
	if IsEntityInBox(_idPlayer,"Sector_Event_DEBUG_02") or IsEntityInBox(_idPlayer,"Sector_Event_DEBUG_03") then
	--	Teletransportation("Char_DEBUG_Repere_02",_idPlayer)
	end
end




