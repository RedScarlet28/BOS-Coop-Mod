function UpdateLevel_VOnDerBroome()
end
---------------------------------------------
function OnStay_Sector_Event_KILL_KILL(id)

	if(_bOnStay_Sector_Event_KILL_KILL==0)then
		if(id==_idPlayer)and(_idHPBodyPlayer==100)and not(IsAlive(_idChar_UAN_Gd_bat_lvl2_room2_02_4))and IsEntityInBox(_idMerc[0],"Sector_Event_hack_2")then
			--	PauseMusic()
				CreationTimer(true,true,false,"KILL",2.0)	
			_bOnStay_Sector_Event_KILL_KILL=1
		end
	end
end
--------------------------------------------------
function KILL()

	_idSound_Client_tuer=GetSound_ClientID("Sound_Client_tuer")
	SetVarValue(_idSound_Client_tuer,"Playing",true)
	CreationTimer(true,true,false,"Start_Music_after_kill",41.0)	
end
----------------------------------------------------
function Start_Music_after_kill()

--StartMusic("Bos - War theme.wav",true)

end
