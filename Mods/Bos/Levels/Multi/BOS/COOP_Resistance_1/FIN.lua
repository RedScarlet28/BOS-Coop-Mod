function UpdateLevel_FIN()
end
--------------------------------------------------
--------------------------------------------------
function Exo_Destroyed()

	if(_bExo_Destroyed==0)then
		if(_nHealth_EXO_D==0)and(_bOnDeath_Tank_SYND_01==0)then
			RadioMessage("DIA_SPE_NIV_L_GENERAL_RADIO_09",true,100,0.0,"")
			MissionFailed ("HUD_MISSION_FAILED_REASON_04")
			_bExo_Destroyed=1
		end
	end
end
--------------------------------------------------

---------------------------------------------------------

-------------------------------------------------------------------------
















































