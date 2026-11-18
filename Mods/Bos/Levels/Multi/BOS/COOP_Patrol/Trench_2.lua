function InitLevel_Trench_2()
		_bRalliement2=false
		_bCassos=false
end

function UpdateLevel_Trench_2()
		Ralliement()
		PassTrench_2()
		ExpTrench_2()
		Bercail()

		_bWRF3_Trench2=Perimeter_Player(_idPlayer, _idChar_WRF_Trench_2_03_3,30)

		if _bWRF3_Trench2 and not _bTrench2P_20 and IsAlive(_idChar_WRF_Trench_2_03_3) then
				MakeCharacterSpeak(_idChar_WRF_Trench_2_03_3,_idPlayer,"DIA_SPE_NIV_D_WRF_B_03",true,110,2,1,"",100)
				_bTrench2P_20=true
		end

		_bWRF41_Trench2=Perimeter_Player(_idPlayer, _idChar_WRF_Trench_2_03_1,25)
		_bWRF42_Trench2=Perimeter_Player(_idPlayer, _idChar_WRF_Trench_2_03_2,25)

		if (_bWRF41_Trench2 or _bWRF42_Trench2) and not _bTrench2_4_20 and _bRalliement then
				if IsAlive(_idChar_WRF_Trench_2_03_1) then
						MakeCharacterSpeak(_idChar_WRF_Trench_2_03_1,_idPlayer,"DIA_SPE_NIV_D_WRF_B_04",true,110,2,1,"",100)
				elseif IsAlive(_idChar_WRF_Trench_2_03_2) then
						MakeCharacterSpeak(_idChar_WRF_Trench_2_03_2,_idPlayer,"DIA_SPE_NIV_D_WRF_B_04",true,110,2,1,"",100)
				end			
				_bTrench2_4_20=true
		end

		_bWRF4_Trench2=Perimeter_Player(_idPlayer, _idChar_WRF_Trench_2_04_1,25)

		if _bWRF4_Trench2 and not _bWRFNear and _bRalliement2 and IsAlive(_idChar_WRF_Trench_2_04_1) then
				MakeCharacterSpeak(_idChar_WRF_Trench_2_04_1,_idPlayer,"DIA_SPE_NIV_D_WRF_F_02",true,110,2,1,"",100)			
				_bWRFNear=true
		end
end

------------------ Fonctions relatives au Sector Events ------------------


--function OnEnter_SE_Trench_2_O_01(_idSE_Trench_2_O_01)
function PickUpExplosifs()
	--	if (_idSE_Trench_2_O_01==_idPlayer) and not _bDejaRecup then
--				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,"DIA_SPE_NIV_D_GENERAL_RADIO_01",true,2)
				--MakeCharacterSpeak(_idPlayer,_idPlayer,"DIA_SPE_NIV_D_GENERAL_RADIO_01",true,110,1,1,"",100)
				RadioMessage("DIA_SPE_NIV_D_GENERAL_RADIO_01",true,100,2,"")
--				DisplayObjective ( "HUD_OBJ_DONE", GetObjectiveID("Objective_Patrol_1_2"), 3, 5 )	
				SetVarValue(GetObjectiveID("Obj_B_2"),"Active",false)
--				SetVarValue(GetObjectiveID("Objective_Patrol_1_2"),"Completed",true)
--				SetVarValue(GetTimerID("Timer_Objective_2"),"Active",true)
				ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_B", "Obj_C", "Obj_C_1" )
				_bDejaRecup=true
				StartMusic("Sounds//Music//BoS - Big Boy theme.wav",true)	
	--	end

end


function OnEnter_SE_Trench_2_S_01(_idSE_Trench_2_S_01)

		if (_idSE_Trench_2_S_01==_idPlayer) and not _bDejaS then
--				MakeCharacterSpeak(_idChar_UAN_Trench_2_01_3,"DIA_SPE_NIV_D_UAN_A_01",true,2)
				FreezeAll(_idGrp_UAN_Trench_2_1,false)
				MakeCharacterSpeak(_idChar_UAN_Trench_2_01_3,GetInvalidEntityID(),"DIA_SPE_NIV_D_UAN_A_01",true,110,1,1,"",100)
				_bDejaS=true
				SetVarValue(_idTimer_Trench_2_01,"Active",true)
		end

end


function OnEnter_SE_Trench_2_B_01(_idSE_Trench_2_B_01)
		if (_idSE_Trench_2_B_01==_idPlayer) and not _bDejaB then
				FreezeAll(_idGrp_WRF_Trench_2_2,false)
				FreezeAll(_idGrp_UAN_Trench_2_2,false)
				FreezeAll(_idGrp_UAN_Trench_2_8,false)
				_bDejaB=true
		end
end


function OnEnter_SE_Trench_2_B_02(_idSE_Trench_2_B_02)
		if (not _bDejaB2) and (_idSE_Trench_2_B_02==_idPlayer)then
				FreezeAll(_idGrp_UAN_Trench_2_5,false)
				FreezeAll(_idGrp_UAN_Trench_2_6,false)
				_bDejaB2=true
		end
end

function OnEnter_SE_Trench_2_B_03(_idSE_Trench_2_B_03)
		if (not _bDejaB3) and (_idSE_Trench_2_B_03==_idPlayer) then
				FreezeAll(_idGrp_WRF_Trench_2_4,false)
				_bDejaB3=true
		end
end


function OnEnter_SE_Trench_2_O_02(_idSE_Trench_2_O_02)
		if (_idSE_Trench_2_O_02==_idPlayer) and not _bDejaRecup2 then

				if AreAllFrozen(_idGrp_WRF_Trench_2_3) then 
--						MakeCharacterSpeak(_idChar_WRF_Trench_2_03_3,"DIA_SPE_NIV_D_WRF_B_05",true,2)
						FreezeAll(_idGrp_WRF_Trench_2_3,false)
						if IsAlive(_idChar_WRF_Trench_2_03_3) then
								MakeCharacterSpeak(_idChar_WRF_Trench_2_03_3,_idPlayer,"DIA_SPE_NIV_D_WRF_B_05",true,110,2,1,"",100)
						end
				end	
--				DisplaySubtitle("C'est la merde! Tirons nous d'ici!!",2,3)

				if not _bDejaB10 then
						Freeze(_idChar_WRF_Trench_2_2,false)
				end
				FreezeAll(_idGrp_WRF_Trench_2_4,true)				
				_bDejaRecup2=true
		end
end


function OnEnter_SE_Trench_2_O_03(_idSE_Trench_2_O_03)
		if ((_idSE_Trench_2_O_03==_idChar_WRF_Trench_2_03_1) or (_idSE_Trench_2_O_03==_idChar_WRF_Trench_2_03_2)
		or (_idSE_Trench_2_O_03==_idChar_WRF_Trench_2_03_3)) and not _bSE_Trench_2_O_03 then	
--				DisplaySubtitle("Putain! C'est un cul de sac!",1,2)
				MakeCharacterSpeak(_idSE_Trench_2_O_03,GetInvalidEntityID(),"DIA_SPE_NIV_D_WRF_B_06",true,110,2,1,"",100)
				SetVarValue(_idSE_Trench_2_O_03,"Health",10)
				_bSE_Trench_2_O_03=true
		end
end


function OnEnter_SE_Trench_2_B_06(_idSE_Trench_2_B_06)
		if (_idSE_Trench_2_B_06==_idPlayer) and not _bSE_Trench_2_B_06 then
				--FreezeAll(_idGrp_UAN_Trench_2_9,false)	
			--	_bSE_Trench_2_B_06=true
		end
		if (not _bDejaB4) and (_idSE_Trench_2_B_06==_idPlayer) then
				FreezeAll(_idGrp_UAN_Trench_2_7,false)
				_bDejaB4=true
		end
		if (_idSE_Trench_2_B_06==_idPlayer) then
				if not _bDejaB10 then
						Freeze(_idChar_WRF_Trench_2_2,false)
				end
				FreezeAll(_idGrp_WRF_Trench_2_4,false)
		end
end


function OnEnter_SE_Trench_2_B_07(_idSE_Trench_2_B_07)
		if (_idSE_Trench_2_B_07==_idPlayer) and not _bSE_Trench_2_B_06 then
				FreezeAll(_idGrp_UAN_Trench_2_9,false)
				if not _bRalliement2 then 
						FreezeAll(_idGrp_WRF_Trench_2_4,true)	
				end
				_bSE_Trench_2_B_06=true
		end
end


function OnEnter_SE_Trench_2_B_08(_idSE_Trench_2_B_08)
		if (_idSE_Trench_2_B_08==_idPlayer) and not _bSE_Trench_2_B_08 then
				Freeze(_idChar_UAN_Trench_2_1,false)	
--				DisplaySubtitle("C'est donc ça que tu cherches...",2,6)
--				DisplayObjective ( "HUD_OBJ_DONE", GetObjectiveID("Objective_Patrol_1_1"), 3, 5 )
				NewSubObjective ( "Obj_B_1", "Obj_B_2")
--				SetVarValue(GetObjectiveID("Objective_Patrol_1_1"),"Active",false)
--				SetVarValue(GetObjectiveID("Objective_Patrol_1_1"),"Completed",true)
--				SetVarValue(GetTimerID("Timer_Objective_1_2"),"Active",true)
				_bSE_Trench_2_B_08=true
		end
end


function OnEnter_SE_Trench_2_B_09(_idSE_Trench_2_B_09)
		if (_idSE_Trench_2_B_09==_idPlayer) and not _bSE_Trench_2_B_09 then
		--		Freeze(_idChar_UAN_Trench_2_2,false)	
				_bSE_Trench_2_B_09=true
		end
end


function OnEnter_SE_Trench_2_O_04(_idSE_Trench_2_O_04)
		if (_idSE_Trench_2_O_04==_idPlayer) and not _bSE_Trench_2_O_04 then
				FreezeAll(_idGrp_UAN_Trench_2_3,false)
				FreezeAll(_idGrp_UAN_Trench_2_4,false)	
				_bSE_Trench_2_O_04=true
		end
		if (_idSE_Trench_2_O_04==_idPlayer) then
--				Freeze(_idChar_WRF_Trench_2_2,true)		
		end
end


function OnEnter_SE_Trench_2_O_05(_idSE_Trench_2_O_05)
		if (_idSE_Trench_2_O_05==_idPlayer) and not _bSE_Trench_2_O_05 then
				FreezeAll(_idGrp_UAN_Trench_2_10,false)		
				_bSE_Trench_2_O_05=true
		end
end


function OnEnter_SE_Trench_2_B_04(_idSE_Trench_2_B_04)
		if (not _bDejaB4) and (_idSE_Trench_2_B_04==_idPlayer) then
				FreezeAll(_idGrp_UAN_Trench_2_7,false)
				_bDejaB4=true
		end
		if (_idSE_Trench_2_B_04==_idPlayer) then
				FreezeAll(_idGrp_WRF_Trench_2_4,false)
		end
end


function OnEnter_SE_Trench_2_B_10(_idSE_Trench_2_B_10)
		if _idSE_Trench_2_B_10==_idPlayer then
				_bDejaB10=true
		end
end


function OnEnter_SE_Trench_2_B_11(_idSE_Trench_2_B_11)
		if _idSE_Trench_2_B_11==_idPlayer then
				FreezeAll(_idGrp_UAN_Trench_2_6,false)
		end
end


function OnExit_SE_Trench_2_B_11(_idSE_Trench_2_B_11)
		if _idSE_Trench_2_B_11==_idPlayer then
				FreezeAll(_idGrp_UAN_Trench_2_6,true)
		end
end


function OnEnter_SE_Trench_2_B_12(_idSE_Trench_2_B_12)
		if (_idSE_Trench_2_B_12==_idPlayer) then
				FreezeAll(_idGrp_WRF_Trench_2_4,true)
		end
end


function OnEnter_SE_Trench_2_B_13(_idSE_Trench_2_B_13)
		if (_idSE_Trench_2_B_13==_idPlayer) then
				FreezeAll(_idGrp_WRF_Trench_2_4,true)
		end
end


function OnEnter_SE_Trench_2_B_14(_idSE_Trench_2_B_14)
		if (_idSE_Trench_2_B_14==_idPlayer) then
				AvertissementTrench_2()
		end
end


function OnEnter_SE_Trench_2_FZ_01(_idSE_Trench_2_FZ_01)
		if (_idSE_Trench_2_FZ_01~=_idPlayer) then
--				SetVarValue(_idSE_Trench_2_FZ_01,"Health",2)	
		end
end


function OnEnter_SE_Trench_2_B_05(_idSE_Trench_2_B_05)
		if (not _bDejaB5) and (_idSE_Trench_2_B_05==_idPlayer)then
				Freeze(_idChar_WRF_Trench_2_1,false)
				_bDejaB5=true
		end
end


function OnEnter_SE_Trench_2_B_15(_idSE_Trench_2_B_15)
		if (not _bCassos) and (_idSE_Trench_2_B_15==_idPlayer) and IsAlive(_idChar_WRF_Trench_2_04_1) then
--				DisplaySubtitle("Direction, la base principale...",2,3)
				MakeCharacterSpeak(_idChar_WRF_Trench_2_04_1,_idPlayer,"DIA_SPE_NIV_D_WRF_F_01",true,110,2,1,"",100)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_WRF_Trench_2_2a"),"PriorityTorso",80)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_WRF_Trench_2_2a"),"PriorityLegs",80)
				_bCassos=true
		end

end



function OnEnter_SE_Trench_2_B_16(_idSE_Trench_2_B_16)

		if (_idSE_Trench_2_B_16==_idPlayer) and AreAllFrozen(_idGrp_WRF_Trench_2_3) then
					MakeCharacterSpeak(_idChar_WRF_Trench_2_03_3,GetInvalidEntityID(),"DIA_SPE_NIV_D_WRF_B_05",true,110,2,1,"",100)	
					FreezeAll(_idGrp_WRF_Trench_2_3,false)
		end	

end



function OnEnter_SE_Trench_2_F_01(_idSE_Trench_2_F_01)

		if (_idSE_Trench_2_F_01==_idChar_WRF_Trench_2_04_1) and not _bAliveCharWRF41 then
					_bAliveCharWRF41=true
		end

end



function OnStay_SE_EoL(_idSE_EoL)

		if (_idSE_EoL==_idPlayer) and IsEntityInBox(_idChar_WRF_Trench_2_04_1,"SE_Trench_2_S_02") and _bDejaRecup and not _bEndPatrol1 then
				_nHelmetCharWRF41=GetVarValue(_idChar_WRF_Trench_2_04_1,"HelmetHitPoints")
				_nBodyCharWRF41=GetVarValue(_idChar_WRF_Trench_2_04_1,"BodyHitPoints")
				_nLegsCharWRF41=GetVarValue(_idChar_WRF_Trench_2_04_1,"LegsHitPoints")
				_nShieldCharWRF41=GetVarValue(_idChar_WRF_Trench_2_04_1,"ShieldHitPoints")
				if not _bReturnTotrench then
						MakeCharacterSpeak(_idChar_WRF_Trench_2_04_1,_idPlayer,"DIA_SPE_NIV_D_WRF_F_04",true,110,1,1,"",100)
				else
						MakeCharacterSpeak(_idChar_WRF_Trench_2_04_1,_idPlayer,"DIA_SPE_NIV_D_WRF_F_05",true,110,1,1,"",100)
				end
-- Anim d'ouverture de porte...
				SetVarValue(_idTimer_Trench_2_EoF,"Active",true)
				_bEndPatrol1=true
		end

		if (_idSE_EoL==_idPlayer) and IsEntityInBox(_idChar_WRF_Trench_2_04_1,"SE_Trench_2_S_02") and not _bDejaRecup and not _bReturnTotrench then
				MakeCharacterSpeak(_idChar_WRF_Trench_2_04_1,_idPlayer,"DIA_SPE_NIV_D_WRF_F_03",true,110,1,1,"",100)
				_bReturnTotrench=true
		end


end

--------------------- Fonctions d'expiration d'ordres --------------------

function ExpForce_Attack_Player_02()
		if AliveMembersCount(_idGrp_UAN_Trench_2_1)<=1 then
				return true
		end
		return false
end


function ExpLZ_Trench2_04()
		if _bRalliement2 then
				return true
		end
		return false
end


function ExpCassos()
		if _bCassos  then
				return true
		end
		return false
end


function ExpFollowWRF_Tr2()
		if _bWRFNear  then
				return true
		end
		return false
end


function ExpFollowWRF_Tr3()
		if _bTrench2P_20  then
				return true
		end
		return false
end

-------------------------- Fonctions diverses ----------------------------

function PassTrench_2()
		if AliveMembersCount(_idGrp_UAN_Trench_2_1)<=2 and not _bSE_Trench_2_B_09 then
		--		Freeze(_idChar_UAN_Trench_2_2,false)	
				_bSE_Trench_2_B_09=true					
		end
end



------------------------------------------------------------------------------------------------------
--[[																	Ralliement()

Fonction appelée dans l'Update Level qui, lorsque les groupes UAN 2 et 8 seront éliminés; fera se 
ralier au joueur, s'ils sont encore vivants, le groupe WRF 3.
--]]
------------------------------------------------------------------------------------------------------

function Ralliement()

		if (AliveMembersCountPct(_idGrp_UAN_Trench_2_3)==0) and (AliveMembersCountPct(_idGrp_UAN_Trench_2_4)==0)
		and not _bRalliement then
				SetVarValue(_idChar_WRF_Trench_2_03_1,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Char_Merc1"))
				SetVarValue(_idChar_WRF_Trench_2_03_2,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Grp_WRF_Trench_2_3b"))
				SetVarValue(_idChar_WRF_Trench_2_03_3,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Char_Merc1"))
				_bRalliement=true
		end
		if (AliveMembersCountPct(_idGrp_UAN_Trench_2_7)==0) and not _bRalliement2 then
				if (AliveMembersCountPct(_idGrp_WRF_Trench_2_3)~=0) then
						SetVarValue(_idGrp_WRF_Trench_2_3,"GroupAIOrderList",GetAI_Order_ListID("AI_O_List_Grp_WRF_Trench_2_3b"))
				end
				_bRalliement2=true
		end


end


function ExpTrench_2()
		if _bDejaB10 and not _bExpT2 then
				_idExplosionT2 = CreateExplosion()
				SetVarValue(_idExplosionT2,"Position",_vPosition_Exp)
				SetVarValue(_idExplosionT2,"Type","Explosion_Rocket_Bombardement")
				SetVarValue(_idParticleFX_Client_Bombone,"FxState","Fx Started")
				_bExpT2=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	Bercail()

Fonction appelée dans l'Update Level qui, lorsque les groupes UAN 2 et 8 seront éliminés; fera se 
barrer, s'ils sont encore vivants, le grôupe WRF 2 et le bot 1.
--]]
------------------------------------------------------------------------------------------------------

function Bercail()

		if (AliveMembersCountPct(_idGrp_UAN_Trench_2_2)==0) and (AliveMembersCountPct(_idGrp_UAN_Trench_2_8)==0) 
		and ((AliveMembersCountPct(_idGrp_WRF_Trench_2_2)~=0) or IsAlive(_idChar_WRF_Trench_2_1)) and not _bBercail then

				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_WRF_Trench_2_2"),"PriorityTorso",80)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_WRF_Trench_2_2"),"PriorityLegs",80)

				if IsAlive(_idChar_WRF_Trench_2_02_1)	then	
						MakeCharacterSpeak(_idChar_WRF_Trench_2_02_1,GetInvalidEntityID(),"DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1",true,110,2,1,"",100)
				elseif IsAlive(_idChar_WRF_Trench_2_02_2)	then
						MakeCharacterSpeak(_idChar_WRF_Trench_2_02_2,GetInvalidEntityID(),"DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1",true,110,2,1,"",100)
				else 
						MakeCharacterSpeak(_idChar_WRF_Trench_2_1,GetInvalidEntityID(),"DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1",true,110,2,1,"",100)
				end		
				
				_bBercail=true

		end

end


function AvertissementTrench_2()
		if not _bAvertissement then
				--DisplaySubtitle("Nolan! Grouillez-vous! Le campement allié est attaqué!",2,4)
--				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,"DIA_SPE_NIV_D_GENERAL_RADIO_05",true,2)
	--			MakeCharacterSpeak(_idPlayer,_idPlayer,"DIA_SPE_NIV_D_GENERAL_RADIO_05",true,110,2,1,"",100)
					RadioMessage("DIA_SPE_NIV_D_GENERAL_RADIO_05",true,100,2,"")
				_bAvertissement=true
		end
end



function EndOfPatrol_1()

		EndOfLevel()	

end



function Update_ObjPatrol_1_2()

		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_1_2"), 3, 5 )		

end



function Update_ObjPatrol_2()

		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_2"), 3, 5 )		

end
