--[[ Teste si Huber est encore en vie
function VieHuber()
	_nVieHuber = GetHealth(_idMerc[0])
	if ((_nVieHuber <= 0) and (_bCtrlVieHuber == false)) then
--		Dialogue(true,3,":::: GAME OVER ::::")
--		RadioMessage("DIA_SPE_NIV_O_INGENIEUR_01", true, 100, 0,"")
--		DisableCharCmd()
		MissionFailed ("HUD_MISSION_FAILED_REASON_07")

		_bCtrlVieHuber = true
	end
end
 --]]

--[[ Teste si Huber est au RDC --]]

function OnEnter_Sector_Event_RDC(id)
	if ((id == _idMerc[0]) and (_PathHuberActiv == true)) then
		_bHuberEtage = false
	end
end

--[[ Teste si Huber est à l'étage --]]

function OnEnter_Sector_Event_ETAGE(id)
	if ((id == _idMerc[0]) and (_PathHuberActiv == true)) then
		_bHuberEtage = true
	end
end