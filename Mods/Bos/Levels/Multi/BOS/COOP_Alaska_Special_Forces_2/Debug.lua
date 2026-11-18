
-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0_Debug" , "Char_Merc_1_Debug";
 
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_David_Julian", "Mercenary_Martin_Lenoir"

end


-------------------------------------------------------------
-- :::: CHAMPION DE DEBUG :::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedChampions()

	return "Champion_Edouardo_Heartbreaker"
-- Champion_Edouardo_Heartbreaker ->	Char_Champion_0_1
-- Champion_Chan_Wan_Hang		    	->	Char_Champion_0_2
-- Champion_Le_Professeur					->	Char_Champion_0_3
end


-------------------------------------------------------------
-- :::: TESTS :::::::::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function OnEnter_SE_Debug(id)
	if (id == _idPlayer) then
	--	LancementBoS2()

	end
end