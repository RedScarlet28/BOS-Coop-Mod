function UpdateLevel_Court ()
	Defreeze_Group_Court_UAN_B ()
	Defreeze_Group_Court_UAN_C ()
	Defreeze_BOS_01 ()
end


function OnEnter_Sector_Event_Court_A_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_Sector_Event_Court_A_00 == 0) then
			FreezeAll(GetGroupID("Group_Court_UAN_A"),false)
			StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
			_bOnEnter_Sector_Event_Court_A_00 = 1
		end
	end
end


function Defreeze_Group_Court_UAN_B ()
	if	(AliveMembersCount(GetGroupID("Group_Court_UAN_B"))<= 1)
	or IsEntityInBox(_idPlayer,"Sector_Event_Court_B_00")
	or IsEntityInBox(_idPlayer,"Sector_Event_Court_B_01") then
		if (_bDefreeze_Group_Court_UAN_B == 0) then
			FreezeAll(GetGroupID("Group_Court_UAN_B"),false)
			_bDefreeze_Group_Court_UAN_B = 1
		end
	end
end

function Defreeze_Group_Court_UAN_C ()
	if	((AliveMembersCount(GetGroupID("Group_Court_UAN_B"))<= 1)
	and IsEntityInBox(_idPlayer,"Sector_Event_Court_C_00"))
	or IsEntityInBox(_idPlayer,"Sector_Event_Court_C_01")then
		if (_bDefreeze_Group_Court_UAN_C == 0) then
			FreezeAll(GetGroupID("Group_Court_UAN_C"),false)
			_bDefreeze_Group_Court_UAN_C = 1
		end
	end
end

-- fermeture portasse
function OnEnter_Sector_Event_Court_D_00 (_idCharInBox)
	if (_idCharInBox == _idPlayer) then
		if (_bOnEnter_OnEnter_Sector_Event_Court_D_00 == 0) then
			CloseDoor(GetDoorID("Door_01"))
			Freeze(_idChampion_0, false)
			EnableCharacterCommand(_idChampion_0, false)
			_bOnEnter_OnEnter_Sector_Event_Court_D_00 = 1
		end
	end
end


-- Launch BoS
function Defreeze_BOS_01 ()
	if (_bDefreeze_Defreeze_BOS == 0) then
		if CharacterCanSee(_idPlayer,_idChampion_0)then
	--	and (AliveMembersCount(GetGroupID("Group_Court_UAN_C"))<= 0)then
			LaunchBOS(0,"Champion_0_Setup","Champion_0_WarmUp","Champion_0_Combat", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut", "Champion_0_OnTimeOut")
			_bDefreeze_Defreeze_BOS = 1
			g_bBoSEnCours = true 
		end
	end
end



function Champion_0_Setup()
	Teletransportation("Char_Champion_0_Repere_Player",_idPlayer)
	if (_idMerc[0] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc1",_idMerc[0])
		EnableCharacterCommand(_idMerc[0], false)
		Freeze(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		Teletransportation("Char_Champion_0_Repere_Merc2",_idMerc[1])
		EnableCharacterCommand(_idMerc[1], false)
		Freeze(_idMerc[1],true)
	end
end

function Champion_0_WarmUp()
	EnableCharacterCommand(_idChampion_0, false)
	EnableCharacterFire(_idPlayer, false)
end


function Champion_0_Combat()
	EnableCharacterCommand(_idChampion_0, true)
	EnableCharacterFire(_idPlayer, true)
end

function Champion_0_OnTimeOut()
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0], true)
		Freeze(_idMerc[0],false)
	end
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1], true)
		Freeze(_idMerc[1],false)
	end
	Freeze(_idChampion_0,true)
	OpenDoor(GetDoorID("Door_01"))
	_bBoS_Done = 1
	g_bBoSEnCours = false
end