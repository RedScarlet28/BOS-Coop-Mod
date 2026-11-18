function UpdateLevel_Game()

end

---------------------------------------------

----------------------------------------
function OnEnter_Sector_Event_TANK_1(id)

	if(_bOnEnter_Sector_Event_TANK_1==0)then
		if(GetLocalCharacterID("Player")==id)then
			TankTargetEntity(_idTank_2,_idPlayer)
		_bOnEnter_Sector_Event_TANK_1=1
		end
	end
end
-----------------------------------------------
function OnExit_Sector_Event_Ouverture(id)


	if(_bOnExit_Sector_Event_Ouverture==0)then	
		if(GetLocalCharacterID("Player")==id)then
		FreezeAll(_idGroup_UAN_Barricades_01,false)
		RadioMessage("DIA_SPE_NIV_L_GENERAL_RADIO_08",true,100,0.0,"")
		_bOnExit_Sector_Event_Ouverture=1
		end
	end
end




-----------------------------------------------------------

----------------------------------------------------------------------
function Pre_bet()

_bAlive_idGroup_EXEC_01=IsAlive(_idGroup_EXEC_01)

	if(_bPre_bet==0)then
		--if(_bAlive_idGroup_EXEC_01==false)then
				if IsEntityInBox(_idPlayer,"Sector_Event_Igor")then
					CreationTimer(true,true,false,"Cine_Igor",1.0)				
					_bPre_bet=1
				end
	--	end
	end
end



function Cine_Igor()
	StopMusic()
	if (_idMerc[0] ~= nil) then 
		Freeze(_idMerc[0], true)
	end
	if (_idMerc[1] ~= nil) then 
		Freeze(_idMerc[1], true)
	end
	Teletransportation("Char_UAN_Infanterie_00_18",_idChampion)
	Teletransportation("Char_WRF_exec_01_6",_idPlayer)
	CharacterPlaySpecialAction(_idPlayer, "STAND COMPLETE WAIT W_NONE COOL",true,false)
	Freeze(_idChampion,false)
	EnableCharacterFire(_idPlayer,false)
	SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Cine_Igor"))
	ShowCinematicBlackStripes(true)	
	LaunchCameraTransition(GetCamTransitionID("CamTransition_A"))
end


function Cine_Igor_b()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_B"))
end



---------------------------------
function Launch()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idChampion,false)
	CharacterStopSpecialAction(_idPlayer)
	Teletransportation("Char_UAN_Infanterie_00_20",_idChampion)
	SetVarValue(_idChampion,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion"))	
	LaunchBOS(0,"OnSetUp","OnWarmUp","OnCombat","OnWon","OnLost","OnTimeOut")
	g_bBoSEnCours = true
	Freeze(_idEXO_PLAYER,true)
end
-------------------------------------------------
function OnSetUp()



				
end
------------------------------------------------------------
function OnWarmUp()
	EnableCharacterCommand(_idPlayer,true)
	SetVarValue(_idChampion,"CharacterAI",GetCharacter_AIID("Char_AI_IGOR_FIGHT"))
	CharacterPlaySpecialAction(_idChampion,"STAND COMPLETE WAIT W_NONE COOL",true,false)
	SetVarValue(GetPlug_MagneticShieldID("Plug_MShield_Champion_0_1"),"Active",true)
end
----------------------------------------------------------------------
function OnCombat()
	SetGodMode(_idChampion,false)
	CharacterStopSpecialAction(_idChampion)
	EnableCharacterCommand(_idChampion,true)
	EnableCharacterFire(_idPlayer,true)
	SetVarValue(_idChampion,"CharacterAI",GetCharacter_AIID("Char_AI_IGOR_FIGHT"))
	CreationTimer(true,true,false,"IGOR_Change_Ai_List",8.0)
end

-------------------------------------------------------------------------
function OnWon()
	CreationTimer(true,true,false,"IgorOnWon",5.0)	
	Freeze(_idChampion,true)
	g_bBoSEnCours = false
end
---------------------------------------------------
function OnLost()
--	MissionFailed("HUD_MISSION_FAILED_REASON_01")
	Freeze(_idChampion,true)
	g_bBoSEnCours = false
end
-------------------------------------------------------
function OnTimeOut()
	CreationTimer(true,true,false,"IgorTimeOut",5.0)				
	Freeze(_idChampion,true)
	g_bBoSEnCours = false	
end
--------------------------------------------------------------
function OnEnter_Sector_Event_SECURE_tank_exo(id)

	if(_bOnEnter_Sector_Event_SECURE_tank_exo==0)then
		if(IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer)))and(_bObj_3_clear==0)then
				SetVarValue(idTank_2,"Rotation Speed",25)
				SetVarValue(idTank_2,"Shoot Delay",0.5)
			_bOnEnter_Sector_Event_SECURE_tank_exo=1
		end
	end
end



----------------
--IGOR SAUTE DE LA TERRASSE

function IGOR_Change_Ai_List ()
--	SetVarValue(_idChampion,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion_SUITE"))
end




---------

function IgorOnWon()
	MissionSucceed ()
end

function IgorTimeOut()
	MissionFailed("HUD_MISSION_FAILED_REASON_15")
end



