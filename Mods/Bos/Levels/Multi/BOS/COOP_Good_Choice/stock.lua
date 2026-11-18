--[[ 
	if (_bPlayerLocation == 2) then

		vWaypoint1 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_1"), "Position")
		vWaypoint2 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_2"), "Position")
		vWaypoint3 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_3"), "Position")
		vWaypoint4 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_4"), "Position")
		vWaypoint5 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_5"), "Position")

		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "Position", vWaypoint1)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "Position", vWaypoint2)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "Position", vWaypoint3)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "Position", vWaypoint4)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_5"), "Position", vWaypoint5)

		local vRotation1 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_1"), "Rotation")
		local vRotation2 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_2"), "Rotation")
		local vRotation3 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_3"), "Rotation")
		local vRotation4 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_4"), "Rotation")
		local vRotation5 = GetVarValue(GetWaypointID("Waypoint_Syndic_Soldats_01_5"), "Rotation")

		local vGetRotZ1 =vRotation1:GetZ()
		local vGetRotZ2 =vRotation2:GetZ() 
		local vGetRotZ3 =vRotation3:GetZ() 
		local vGetRotZ4 =vRotation4:GetZ() 
		local vGetRotZ5 =vRotation5:GetZ() 

		vRotation1:SetZ(vGetRotZ1-1,5)
		vRotation2:SetZ(vGetRotZ2-1,5)
		vRotation3:SetZ(vGetRotZ3-1,5)
		vRotation4:SetZ(vGetRotZ4-1,5)
		vRotation5:SetZ(vGetRotZ5-1,5)

		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_1"), "Rotation", vRotation1)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_2"), "Rotation", vRotation2)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_3"), "Rotation", vRotation3)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_4"), "Rotation", vRotation4)
		SetVarValue(GetCharacterID("Char_Syndic_Soldats_01_5"), "Rotation", vRotation5)
	end
end

--]]
