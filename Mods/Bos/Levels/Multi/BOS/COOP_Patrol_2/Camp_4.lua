--[[

function InitLevel_Camp_4()

		_nPhrases=0
		_nDBotWRF=5
		_nDBotUAN=5
		_nShootExo=0
		_bEndFirstLine=false

end

function UpdateLevel_Camp_4()
		RenfortUANCamp_4()
		Renfort2UANCamp_4()
		Renfort2WRFCamp_4()
		--Renfort3WRFCamp_4()
		RenfortCamp_4()
		Grp_WRF_Freezadin()
		LastFight()
		if _nPhrases==1 and not _bEndDIA then
				SetVarValue(_idTimer_Camp_4_Assaut_02,"Loop", false)
				SetVarValue(_idTimer_Camp_4_Assaut_02,"DestroyOnExpire", true)
				_bEndDIA=true
		end
		if AliveMembersCount(_idGrp_UAN_Camp_4_2)==0 and not _bRenfort3 then 
				SetVarValue(_idTimer_Camp_4_Assaut_03,"Active",true)				
				_bRenfort3=true
		end

		if (AliveMembersCount(_idGrp_WRF_Camp_4_1)+AliveMembersCount(_idGrp_WRF_Camp_4_2)+AliveMembersCount(_idGrp_WRF_Camp_4_6)+AliveMembersCount(_idGrp_WRF_Camp_4_7))<=2 
		and _bRenfort3WRFCamp_4 and not _bEndFirstLine then
				_bEndFirstLine=true
		end

end

------------------ Fonctions relatives au Sector Events ------------------

function OnStay_SE_Camp_4_LZ_01(_idSE_Camp_4_LZ_01)

		if (GetVarValue(_idSE_Camp_4_LZ_01,"Team")=="UAN") and IsAlive(_idChar_WRF_Camp_4_02_3) and not IsFrozen(_idChar_WRF_Camp_4_02_3) and not _bSeeAssaut then 
				MakeCharacterSpeak(_idChar_WRF_Camp_4_02_3,_idPlayer,"DIA_GEN_SEE_ENNEMY_TEAM_A_VOICE_A_1",true,110,2,1,"",100)
				_bSeeAssaut=true
		end

end



function OnEnter_SE_Camp_4_LZ_01(_idSE_Camp_4_LZ_01)

		if (_idSE_Camp_4_LZ_01==_idPlayer) and (not _bSE_Camp_4_LZ_01) then 
				_bSE_Camp_4_LZ_01=true
		end

end



function OnEnter_SE_Camp_4_LZ_02(_idSE_Camp_4_LZ_02)
		if (_idSE_Camp_4_LZ_02==_idPlayer) and (not _bRetraite01) then 
				SetGodMode(_idChar_WRF_Camp_4_01_1,false)
				SetVarValue(_idTimer_Camp_4_Assaut_01,"Active", true)
				SetVarValue(_idTimer_Camp_4_Assaut_02,"Active", true)


				NewSubObjective ( "Obj_C_1", "Obj_C_2")

				SetVarValue(GetTimerID("Timer_Objective_2_2"),"Active", true)
				SetVarValue(GetTimerID("Timer_Retraite"),"Active", true)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Merc_0"),"PriorityTorso", 20)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Merc_0"),"PriorityLegs", 60)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Merc_1"),"PriorityTorso", 20)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_Merc_1"),"PriorityLegs", 60)
				_bRetraite01=true
		end
end




function OnEnter_SE_Camp_4_LZ_04(_idSE_Camp_4_LZ_04)

		if (_idSE_Camp_4_LZ_04==_idPlayer) and not _bSE_Camp_4_LZ_04 then 
				RadioMessage("DIA_SPE_NIV_D_GENERAL_RADIO_02", true, 130, 1, "")
				_bSE_Camp_4_LZ_04=true
		end

end



function OnEnter_SE_Camp_4_LZ_05(_idSE_Camp_4_LZ_05)
		if (_idSE_Camp_4_LZ_05==_idPlayer) and not _bSE_Camp_4_LZ_05 then 

				FreezeAll(_idGrp_WRF_Camp_4_8,false)
				_bSE_Camp_4_LZ_05=true
		end
end



function OnEnter_SE_Camp_4_F_01(_idSE_Camp_4_F_01)
		if  (_idSE_Camp_4_F_01==_idPlayer) and not _bSE_Camp_4_F_01 then 
				FreezeAll(_idGrp_WRF_Camp_4_2,false)
				FreezeAll(_idGrp_UAN_Camp_4_Snip_01,true)
				_bSE_Camp_4_F_01=true
		end
end


function OnEnter_SE_Camp_4_F_02(_idSE_Camp_4_F_02)
		if (_idSE_Camp_4_F_02==_idPlayer) and not _bSE_Camp_4_F_02 then
				SetVarValue(_idExo_UAN_Camp_4, "Freeze", false)
				_bSE_Camp_4_F_02=true
		end
end


function OnEnter_SE_Camp_4_F_03(_idSE_Camp_4_F_03)
		if (_idSE_Camp_4_F_03==_idPlayer) then 
				FreezeAll(_idGrp_UAN_Camp_4_5,false)
				FreezeAll(_idGrp_UAN_Camp_4_6,false)
				if _bUANCp7 then
						FreezeAll(_idGrp_UAN_Camp_4_7,false)
				end
				FreezeAll(_idGrp_WRF_Camp_4_3,false)
				FreezeAll(_idGrp_WRF_Camp_4_4,false)
				SetVarValue(_idTimer_Camp_4_Exo,"Active", true)
		end
end


function OnEnter_SE_Camp_4_F_04(_idSE_Camp_4_F_04)
		if (_idSE_Camp_4_F_04==_idPlayer) and not _bSE_Camp_4_F_04 then 
				FreezeAll(_idGrp_UAN_Camp_4_4,false)
				_bSE_Camp_4_F_04=true
		end
end


function OnEnter_SE_Camp_4_F_05(_idSE_Camp_4_F_05)
		if (_idSE_Camp_4_F_05==_idPlayer) then 
				FreezeAll(_idGrp_UAN_Camp_4_5,true)
				FreezeAll(_idGrp_UAN_Camp_4_6,true)
				FreezeAll(_idGrp_UAN_Camp_4_7,true)
				FreezeAll(_idGrp_WRF_Camp_4_3,true)
				FreezeAll(_idGrp_WRF_Camp_4_4,true)
				FreezeAll(_idGrp_WRF_Camp_4_5,true)
				FreezeAll(_idGrp_UAN_Camp_4_Snip_01,false)
				SetVarValue(_idTimer_Camp_4_Exo,"Active", false)
				_bCouverture=true
		end
end


function OnEnter_SE_Camp_4_B_01(_idSE_Camp_4_B_01)
		if  (_idSE_Camp_4_B_01==_idPlayer) and not _bSE_Camp_4_B_01 then 
				_bSE_Camp_4_B_01=true
		end
end


function OnEnter_SE_Camp_4_B_05(_idSE_Camp_4_B_05)
		if  (_idSE_Camp_4_B_05==_idPlayer) then 
				FreezeAll(_idGrp_UAN_Camp_4_Snip_01,true)
		end
end


function OnEnter_SE_Camp_4_B_07(_idSE_Camp_4_B_07)
		if  (_idSE_Camp_4_B_07==_idPlayer) then 
				FreezeAll(_idGrp_UAN_Camp_4_Snip_02,true)
		end

end


function OnEnter_SE_Camp_4_O_01(_idSE_Camp_4_O_01)
		if (_idSE_Camp_4_O_01==_idPlayer and not _bSE_Camp_4_O_01) then
				EnableCharacterCommand(_idChar_WRF_Camp_4_Doodson, true)
				EnableCharacterCommand(_idPlayer, false)
				LaunchCameraTransition(GetCamTransitionID("CamTransition_End_Patrol"))
				SetVarValue(GetObjectiveID("Obj_C_3"),"Active",false)
				SetVarValue(GetTimerID("Timer_Objective_2"), "Active", true)
				_bSE_Camp_4_O_01=true
		end

end


function OnEnter_SE_Camp_4_T_01(_idSE_Camp_4_T_01)

		if  (_idSE_Camp_4_T_01==_idPlayer) and not _bSE_Camp_4_T_01 then 
				RadioMessage("DIA_SPE_NIV_D_GENERAL_RADIO_03", true, 130, 1, "")
				SetVarValue(GetTimerID("Timer_Objective_2_1"),"Active", true)
				_bSE_Camp_4_T_01=true
		end

end
--]]
--------------------- Fonctions d'expiration d'ordres --------------------

function ExpLimit_Zone_Grp_WRF_Camp_4_1()
	--[[	if  _bSE_Camp_4_LZ_01 or _bCouverture then


				-- Si le 1er membre de la liste correspond à une entité valide
				FreezeAll(_idGrp_UAN_Camp_4_R1,false)

				if (_idMerc[0] ~= nil) and IsAlive(_idMerc[0]) and not _bMercCover then 
						MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_D_MERCE_A_02",true,110,2,1,"",100)
						_bMercCover=true
						return true
				elseif (_idMerc[1] ~= nil) and IsAlive(_idMerc[1]) and not _bMercCover then
						MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_SPE_NIV_D_MERCE_A_02",true,110,2,1,"",100)
						_bMercCover=true
						return true
				end

		end
		return false
--]]
end


function ExpLimit_Zone_Grp_WRF_Camp_4_2(idChar)
--[[
		if _bEndFirstLine then
				return true
		end
		return false
--]]
end


function ExpGoto_Waypoint_Grp_UAN_Camp_4_3()
--[[
		if _bEndFirstLine then
				return true
		end
		return false
--]]
end



function ExpGoto_Waypoint_Grp_UAN_Camp_4_01_5()
--[[
		if _bRevers then
				return true
		end
		return false
--]]
end



function ExpAssaut_UAN()
--[[
		if _bRenfort16UANCamp_4 then
			
				return true
		end
		return false
--]]
end



function ExpGoto_Waypoint_Grp_UAN_Camp_4_ExoA()
--[[
		if  IsEntityInBox(GetCharacterID("Char_UAN_Camp_4_15_3"),"SE_Camp_4_F_01") and _bEndFirstLine then
				return true
		end
		return false
--]]
end
--[[

-------------------------- Fonctions diverses ----------------------------


RenfortUANCamp_4

Cette fonction envoie un renfort de bots ennemis, une fois qu'on a éliminé une certaine
partie de ce qui étaient présents à l'arrivée dans la base. Ce renfort est bien sur
envoyé seulement s'il n'y a pas trop de bots à l'écran.
function RenfortUANCamp_4()

 Tests: S'il ne reste que 3 bots ennemis, 8 persos actifs maximum et si on a déjà pas appelé la fonction 
		if AliveMembersCount(_idGrp_UAN_Camp_4_1)<=3 and _nBotActive<=8 and not _bRenfortUANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_2,false)
				_bRenfortUANCamp_4=true
		end
		if AliveMembersCount(_idGrp_UAN_Camp_4_6)<=2 and not _bUANCp7 then 
				FreezeAll(_idGrp_UAN_Camp_4_7,false)
				_bUANCp7=true
		end
		if AliveMembersCount(_idGrp_UAN_Camp_4_R1)<=2 and not _bUANCpR1 then 
				FreezeAll(_idGrp_UAN_Camp_4_R2,false)
				_bUANCpR1=true
		end
		if (AliveMembersCount(_idGrp_UAN_Camp_4_R2)+AliveMembersCount(_idGrp_UAN_Camp_4_R1))<=2 and not _bUANCpR2 then 
				FreezeAll(_idGrp_UAN_Camp_4_R3,false)
				_bUANCpR2=true
		end
		if AliveMembersCount(_idGrp_UAN_Camp_4_15)<=2 and not _bUANCp15 then 
				FreezeAll(_idGrp_UAN_Camp_4_16,false)
				_bUANCp15=true
		end

end



Renfort2UANCamp_4

Cette fonction gère l'assaut de l'UAN en 2 types de renfort:
	1: Des vagues
	2: Des bots postés
On a ainsi toujours les deux types en même temps.
Il y a 7 vagues.

function Renfort2UANCamp_4()

 On teste d'abord que l'assaut a bien eu lieu, si oui, on lance les renfort.
	if _bAssaut then

 1. Renfort en vagues.
 On calcul les bots UAN vivants selon les vagues envoyées.
		_nVague_1=AliveMembersCount(_idGrp_UAN_Camp_4_3)
		_nVague_2=_nVague_1+AliveMembersCount(_idGrp_UAN_Camp_4_8)
		_nVague_3=_nVague_2+AliveMembersCount(_idGrp_UAN_Camp_4_9)
		_nVague_4=_nVague_3+AliveMembersCount(_idGrp_UAN_Camp_4_10)
		_nVague_5=_nVague_4+AliveMembersCount(_idGrp_UAN_Camp_4_11)
		_nVague_6=_nVague_5+AliveMembersCount(_idGrp_UAN_Camp_4_12)
		_nVague_All=_nVague_6+AliveMembersCount(_idGrp_UAN_Camp_4_13)+AliveMembersCount(_idGrp_UAN_Camp_4_15)+AliveMembersCount(_idGrp_UAN_Camp_4_16)

 On teste plusieurs choses:
	1: S'il ne reste plus qu'un bot UAN, même si le nombre total à l'écran est trop grand, pour ne pas couper l'assaut.
		 C'est un cas extrème.
	2: Pour entrenir l'assaut, on vérifie s'il n'y a pas de trop de bot à l'écran, et en fonction du nombre de bots vivants,
		 on envoie la vague suivante.
	3: On teste si on ne l'a pas déjà envoyé.
	4: On teste que la vague précédente a eu lieu.
		if ((_nVague_6<=1) or ((_nBotActive<=10) and (_nVague_6<=6))) and not _bRenfort15UANCamp_4 and _bRenfort14UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_13,false)
				_bRenfort15UANCamp_4=true
		end
		if ((_nVague_5<=1) or  ((_nBotActive<=10) and (_nVague_5<=6))) and not _bRenfort14UANCamp_4 and _bRenfort5UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_12,false)
				_bRenfort14UANCamp_4=true
		end
		if ((_nVague_4<=1) or ((_nBotActive<=10) and (_nVague_4<=6)))	and not _bRenfort5UANCamp_4 and _bRenfort4UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_11,false)
				_bRenfort5UANCamp_4=true
		end
		if ((_nVague_3<=1) or ((_nBotActive<=10) and (_nVague_3<=6))) and not _bRenfort4UANCamp_4 and _bRenfort3UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_10,false)
				_bRenfort4UANCamp_4=true
		end
		if ((_nVague_2<=1) or ((_nBotActive<=10) and (_nVague_2<=4))) and not _bRenfort3UANCamp_4 and _bRenfort2UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_9,false)
				_bRenfort3UANCamp_4=true
		end
		if ((_nVague_1<=1) or ((_nBotActive<=10) and (_nVague_1<=3))) and not _bRenfort2UANCamp_4 then
				FreezeAll(_idGrp_UAN_Camp_4_8,false)
				_bRenfort2UANCamp_4=true
		end

 Une fois la totalité de l'assaut effectué, s'il reste seulement 2 bots UAN vivants, ils fuient, et c'est la fin de l'assaut et
 de l'objectif.
		if (_nVague_All<=1) and not _bRenfort16UANCamp_4 then
------------------- Fuite------------------------------------------
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_UAN_Fuite"),"PriorityLegs",70)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_UAN_Fuite"),"PriorityTorso",70)

				MakeCharacterSpeak(_idChar_WRF_Camp_4_06_3,_idPlayer,"DIA_SPE_NIV_D_WRF_E_01",true,110,2,1,"",100)

				NewSubObjective ( "Obj_C_2", "Obj_C_3")
				SetVarValue(GetTimerID("Timer_Porte"),"Active", true)
				_bRenfort16UANCamp_4=true
		end

 2. Renfort en tireurs postés.
 Ces bots ont des ordres particuliers, ils se postent à différents endroits de la ligne ennemie.

 Même principe, on teste en premier le nombre de bots actifs.	
		if _nBotActive<=10 then

 Pour n'envoyer qu'un bot à la fois, on utilise un booléen _bBotUAN. 
				_bBotUAN=false

 On teste donc en premier lieu si on n'a pas déjà défreezé un bot, ensuite si son prédeccesseur a été déjà defreezé et qu'il est mort
 et enfin, que l'on a déjà pas envoyer le renfort.
				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_03_4) and not IsAlive(_idChar_UAN_Camp_4_03_4) and not _bRenfort6UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_1,false)
						_bRenfort6UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_03_6) and not IsAlive(_idChar_UAN_Camp_4_03_6) and not _bRenfort7UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_2,false)
						_bRenfort7UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_03_7) and not IsAlive(_idChar_UAN_Camp_4_03_7) and not _bRenfort8UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_3,false)
						_bRenfort8UANCamp_4=true
						_bBotUAN=true
				end	

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_03_8) and not IsAlive(_idChar_UAN_Camp_4_03_8) and not _bRenfort9UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_4,false)
						_bRenfort9UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_1) and not IsAlive(_idChar_UAN_Camp_4_1) and not _bRenfort10UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_5,false)
						_bRenfort10UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_2) and not IsAlive(_idChar_UAN_Camp_4_2) and not _bRenfort11UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_6,false)
						_bRenfort11UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_3) and not IsAlive(_idChar_UAN_Camp_4_3) and not _bRenfort12UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_7,false)
						_bRenfort12UANCamp_4=true
						_bBotUAN=true
				end

				if not _bBotUAN and not IsFrozen(_idChar_UAN_Camp_4_4) and not IsAlive(_idChar_UAN_Camp_4_4) and not _bRenfort13UANCamp_4 then
						Freeze(_idChar_UAN_Camp_4_8,false)
						_bRenfort13UANCamp_4=true
						_bBotUAN=true
				end
		end

	end

end



function Renfort2WRFCamp_4()

		if (_nBotActive<=10) or (AliveMembersCount(_idGrp_WRF_Camp_4_2)<=0) then
				if not AreAllFrozen(_idGrp_WRF_Camp_4_2) and AliveMembersCount(_idGrp_WRF_Camp_4_2)<=1 and not _bRenfort2WRFCamp_4 then
						FreezeAll(_idGrp_WRF_Camp_4_6,false)
						if IsAlive(_idChar_WRF_Camp_4_06_1) then
								MakeCharacterSpeak(_idChar_WRF_Camp_4_06_1,_idPlayer,"DIA_GEN_COOL_TO_STRESS_TEAM_A_VOICE_B_2",true,110,2,1,"",100)
						end
						_bRenfort2WRFCamp_4=true
				end
		end
		if not IsFrozen(_idChar_WRF_Camp_4_01_1) and not IsAlive(_idChar_WRF_Camp_4_01_1) then 
				SetVarValue(_idChar_WRF_Camp_4_06_1,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_1)
				_bPosCamp_4_02_1=true
		elseif not IsFrozen(_idChar_WRF_Camp_4_02_1) and not IsAlive(_idChar_WRF_Camp_4_02_1) then
				SetVarValue(_idChar_WRF_Camp_4_06_1,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_4)
				_bPosCamp_4_02_4=true
		end

		if not IsFrozen(_idChar_WRF_Camp_4_01_3) and not IsAlive(_idChar_WRF_Camp_4_01_3) then 
				SetVarValue(_idChar_WRF_Camp_4_06_2,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_3)
				_bPosCamp_4_02_3=true
		elseif not IsFrozen(_idChar_WRF_Camp_4_02_2) and not IsAlive(_idChar_WRF_Camp_4_02_2) then 
				SetVarValue(_idChar_WRF_Camp_4_06_2,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_2)
				_bPosCamp_4_02_2=true
		end

end



function Renfort3WRFCamp_4()
		if (_nBotActive<=9) or (AliveMembersCount(_idGrp_WRF_Camp_4_6)<=1) then
				if not AreAllFrozen(_idGrp_WRF_Camp_4_6) and AliveMembersCount(_idGrp_WRF_Camp_4_6)<=1 and not _bRenfort3WRFCamp_4 then
						FreezeAll(_idGrp_WRF_Camp_4_7,false)
						_bRenfort3WRFCamp_4=true
				end
		end

		if not IsAlive(_idChar_WRF_Camp_4_06_2) and _bPosCamp_4_02_3 then 
				SetVarValue(_idChar_WRF_Camp_4_07_2,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_3)
		else 
				SetVarValue(_idChar_WRF_Camp_4_07_2,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_2)
		end


		if not IsAlive(_idChar_WRF_Camp_4_06_1) and _bPosCamp_4_02_1 then 
				SetVarValue(_idChar_WRF_Camp_4_07_1,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_1)
		else
				SetVarValue(_idChar_WRF_Camp_4_07_1,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_4)
		end

end



function AssautUANCamp_4_01()

		FreezeAll(_idGrp_UAN_Camp_4_3,false)
		_bAssaut=true

end


function DIA_WRF_AssautCamp_4_01()

		if (_nPhrases==0) and IsAlive(_idChar_WRF_Camp_4_02_1) and IsAlive(_idChar_WRF_Camp_4_02_2) then
				MakeCharacterSpeak(_idChar_WRF_Camp_4_02_1,_idChar_WRF_Camp_4_02_2,"DIA_SPE_NIV_D_WRF_E_02",true,110,2,1,"",100)			
				SetVarValue(_idChar_WRF_Camp_4_02_1,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_4)	
				SetVarValue(_idChar_WRF_Camp_4_02_2,"CharacterOrderList",_idAI_O_List_Char_WRF_Camp_4_02_2)
				_nPhrases=_nPhrases+1
		elseif (_nPhrases==1) and IsAlive(_idChar_WRF_Camp_4_02_1) and IsAlive(_idChar_WRF_Camp_4_02_2) then
				MakeCharacterSpeak(_idChar_WRF_Camp_4_02_2,_idChar_WRF_Camp_4_02_1,"DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_A_1",true,110,2,1,"",100)					
		end		

end


function Renfort3UANCamp_4()

		RadioMessage("DIA_SPE_NIV_D_GENERAL_RADIO_04", true, 130, 1, "")

end


function RenfortCamp_4()
		if _nBotActive<=10 and _bAssaut then
				if AliveMembersCount(_idGrp_UAN_Camp_4_3)<=1 and not _bCp2_43 then
						FreezeAll(_idGrp_UAN_Camp_4_14,false)
						_bCp2_43=true
				end
		end
end


function Grp_WRF_Freezadin()

		if (IsWholeGroupInBox(_idGrp_WRF_Camp_4_1,"SE_Camp_4_B_06") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_1,"SE_Camp_4_B_07") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_1,"SE_Camp_4_B_08"))
		and (IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") or IsEntityInBox(_idPlayer,"SE_Camp_4_B_02")) 	and _bSE_Camp_4_F_02 then
				FreezeAll(_idGrp_WRF_Camp_4_1,true)				
		elseif AreAllFrozen(_idGrp_WRF_Camp_4_1) and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") 
		and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_02") and _bSE_Camp_4_F_02 then 
				FreezeAll(_idGrp_WRF_Camp_4_1,false)
		end

		if (IsWholeGroupInBox(_idGrp_WRF_Camp_4_6,"SE_Camp_4_B_06") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_6,"SE_Camp_4_B_07") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_6,"SE_Camp_4_B_08"))
		and (IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") or IsEntityInBox(_idPlayer,"SE_Camp_4_B_02")) and	_bRenfort2WRFCamp_4 then
				FreezeAll(_idGrp_WRF_Camp_4_6,true)				
		elseif AreAllFrozen(_idGrp_WRF_Camp_4_6) and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_02") and	_bRenfort2WRFCamp_4 then 
				FreezeAll(_idGrp_WRF_Camp_4_6,false)
		end

		if (IsWholeGroupInBox(_idGrp_WRF_Camp_4_7,"SE_Camp_4_B_06") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_7,"SE_Camp_4_B_07") or IsWholeGroupInBox(_idGrp_WRF_Camp_4_7,"SE_Camp_4_B_08"))
		and (IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") or IsEntityInBox(_idPlayer,"SE_Camp_4_B_02")) and	_bRenfort3WRFCamp_4 then
				FreezeAll(_idGrp_WRF_Camp_4_7,true)				
		elseif AreAllFrozen(_idGrp_WRF_Camp_4_7) and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_01") and not IsEntityInBox(_idPlayer,"SE_Camp_4_B_02") and	_bRenfort3WRFCamp_4 then 
				FreezeAll(_idGrp_WRF_Camp_4_7,false)
		end

end



function LastFight()

		if _bEndFirstLine and not _bRLL then
				FreezeAll(_idGrp_WRF_Camp_4_8,false)

				RadioMessage("DIA_GEN_SEE_EXOSOLDIER_TEAM_A_VOICE_A_1",true,130,2,"")
				RadioMessage("DIA_GEN_DO_RETREAT_TEAM_A_VOICE_A_1",true,130,2,"")
				SetVarValue(GetObjectiveID("Obj_C_2"),"Position",_vPosObj1)
				FreezeAll(_idGrp_UAN_Camp_4_15,false)
				Freeze(_idChar_WRF_Camp_4_2,false)

				LaunchCameraTransition(GetCamTransitionID("CamTransition_Retrait_1"))
				EnableCharacterCommand(_idPlayer, false)
				_bRLL=true
		end

end


function OuverturePorte()
		_bPorte=true
		
		Freeze(_idChar_WRF_Camp_4_Doodson, false)
		EnableCharacterCommand(_idChar_WRF_Camp_4_Doodson, false)
		if IsFrozen(_idGrp_WRF_Camp_4_8) then
				FreezeAll(_idGrp_WRF_Camp_4_8,false)
		end
end


function EndPatrol()

		EnableCharacterCommand(_idPlayer, true)

-----------------------------------------------------------------
-- ::::::::::::::::::::: Mission Succeed ::::::::::::::::::::: --
-----------------------------------------------------------------

			MissionSucceed()

end



function ShootExo()

		if _nShootExo==0 then
				SetVarValue(_idAI_O_Fire_At_Position_Exo_1,"PriorityTorso", 60)	
				SetVarValue(_idAI_O_Fire_At_Position_Exo_2,"PriorityTorso", 0)		
				_nShootExo=_nShootExo+1
		elseif _nShootExo==1 then
				SetVarValue(_idAI_O_Fire_At_Position_Exo_1,"PriorityTorso", 0)	
				SetVarValue(_idAI_O_Fire_At_Position_Exo_2,"PriorityTorso", 60)		
				_nShootExo=_nShootExo+1	
		elseif _nShootExo==2 then		
				SetVarValue(_idAI_O_Fire_At_Position_Exo_1,"PriorityTorso", 0)	
				SetVarValue(_idAI_O_Fire_At_Position_Exo_2,"PriorityTorso", 0)		
				_nShootExo=0	
		end

end



function Clear_Objectif2()

		MakeCharacterSpeak(_idChar_WRF_Camp_4_Doodson,_idPlayer,"DIA_SPE_NIV_D_GENERAL_B_01",true,130,1,2,"",100)

		_bPatrol_Obj2=true

end



function Add_Objectif2_1()

		_bPatrol_Obj2_1=true

end



function Add_Objectif2_2()

		_bPatrol_Obj2_2=true

end


function Add_Objectif2_3()

		_bPatrol_Obj2_3=true

end



function RetraiteAssautWRF()

		if not _bRenfort16UANCamp_4 then
				_bEndFirstLine=true
		end

end



function DialRetraite()

		RadioMessage("DIA_GEN_SEE_EXOSOLDIER_TEAM_A_VOICE_A_1",true,130,2,"")
		SetVarValue(GetObjectiveID("Obj_C_2"),"Position",_vPosObj1)

end



function Cin_Retraite()

		LaunchCameraTransition(GetCamTransitionID("CamTransition_Retrait_2"))

end


function Cin_Retraite1()

		EnableCharacterCommand(_idPlayer, true)
end--]]
