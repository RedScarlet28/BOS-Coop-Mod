--[[ Fin Loading --]]

function OnEnter_Sector_Event_End_Of_Level(id)

	if (id == _idPlayer) then

		EndOfLevel()

	end

end