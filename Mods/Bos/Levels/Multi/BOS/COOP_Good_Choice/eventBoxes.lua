--[[ Teste si le player est dans la moitié 1 --]]

function OnEnter_Sector_Event_MoitieArene1(id)
	if (id == _idPlayer) then
		_bPlayerLocation = 1
	end
end

--[[ Teste si le player est dans la moitié 2 --]]

function OnEnter_Sector_Event_MoitieArene2(id)
	if (id == _idPlayer) then
		_bPlayerLocation = 2
	end
end

function OnEnter_Sector_Event_MonteCharge_1(id)
	if ((id == _idPlayer) and (_bTestPassagePlayer == false)) then
		EnableCmdMisterFive()
		_bTestPassagePlayer = true
	end
	if ((id == _idMerc[0]) and (_bTestPassageIGOR == false)) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_IGOR"),"Active",true)
		_bTestPassageIGOR = true
	end
end

