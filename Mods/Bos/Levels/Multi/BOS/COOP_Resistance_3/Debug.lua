
-------------------------------------------------------------
-- :::: MERCS DE DEBUG ::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

function Debug_GetSelectedMercenaries()
 
    return "Char_Merc_0" , "Char_Merc_1";
 
end

function Debug_GetSelectedMercenariesName()

    return "Mercenary_Colonel_Huber", "Mercenary_Martin_Lenoir"

end



function OnEnter_DEBUG()
	BaldingRulez()
	_bCtrlSE_Roof_Trigger_1 = true
end