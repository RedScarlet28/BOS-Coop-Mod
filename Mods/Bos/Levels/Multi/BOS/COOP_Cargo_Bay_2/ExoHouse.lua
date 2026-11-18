
function InitLevel_ExoHouse()
	_bCtrlSE_ExoHouse_Dca_05 = false
	_bCtrlTestPlayerExo = false
	_bCtrlBoomDca2 = false
	_bCtrlSE_ExoHouse_F_03 = false
	_bCtrlSE_Exo_Tips = false
end

function UpdateLevel_ExoHouse()
		Renfort_ExoHouse()
		Renfort_ExoHouse_Bat()
--		Dca2ChampLibre()
		AlerteExoHouse()
		SeeExo()
		Rescue_WRF()
		TestPlayerExo()
end

------------------ Fonctions relatives au Sector Events ------------------

function OnEnter_SE_ExoHouse_LZ_01(_idSE_ExoHouse_LZ_01)
		if (_idSE_ExoHouse_LZ_01==_idPlayer) and (not _bExoLZ_01) then
				FreezeAll(_idGrp_UAN_ExoHouse_06,false)
				_bExoLZ_01=true
		end
end


function OnEnter_SE_ExoHouse_F_01(_idSE_ExoHouse_F_01)
		if (_idSE_ExoHouse_F_01==_idPlayer) and (not _bExo1) then
					FreezeAll(_idGrp_UAN_ExoHouse_02,false)
					FreezeAll(_idGrp_UAN_ExoHouse_03,false)
					FreezeAll(_idGrp_UAN_ExoHouse_20,false)
					SetVarValue(GetTimerID("Timer_ExoHouse_Alarm"),"Active",true)
					SetVarValue(_idAI_O_Use_Exo_UAN_ExoHouse_1,"PriorityTorso", 90)
					SetVarValue(_idAI_O_Use_Exo_UAN_ExoHouse_1,"PriorityLegs", 90)
					_bExo1=true
		end
		if (_idSE_ExoHouse_F_01==_idPlayer) and _bExo1 then
					FreezeAll(_idGrp_UAN_ExoHouse_02,false)
					FreezeAll(_idGrp_UAN_ExoHouse_03,false)
					_bExoFlee1=true
		end
		if (_idSE_ExoHouse_F_01==_idPlayer) and not _bfreezeIsland then

					_bfreezeIsland=true
		end
		if (_idSE_ExoHouse_F_01==_idPlayer)  then

		end

end


function OnEnter_SE_ExoHouse_F_02(_idSE_ExoHouse_F_02)
		if (_idSE_ExoHouse_F_02==_idPlayer) and (not _bExo2) then
				FreezeAll(_idGrp_UAN_ExoHouse_07,false)
				if _nBotActive<=8 then
						FreezeAll(_idGrp_UAN_ExoHouse_05,false)
				end
				_bExo2=true
		end
end


function OnEnter_SE_ExoHouse_F_03(_idSE_ExoHouse_F_03)

		if ((_idSE_ExoHouse_F_03==_idPlayer) and (_bCtrlSE_ExoHouse_F_03 == false)) then
				Freeze(_idChar_UAN_ExoHouse_4,false)
				FreezeAll(_idGrp_UAN_ExoHouse_01,true)
				FreezeAll(_idGrp_UAN_ExoHouse_02,true)
				FreezeAll(_idGrp_UAN_ExoHouse_03,true)
				FreezeAll(_idGrp_UAN_ExoHouse_04,true)
				FreezeAll(_idGrp_UAN_ExoHouse_05,true)
				FreezeAll(_idGrp_UAN_ExoHouse_06,true)
				FreezeAll(_idGrp_UAN_ExoHouse_07,true)
				FreezeAll(_idGrp_UAN_ExoHouse_08,true)
				FreezeAll(_idGrp_UAN_ExoHouse_10,true)
				FreezeAll(_idGrp_UAN_ExoHouse_11,true)
				FreezeAll(_idGrp_UAN_ExoHouse_12,true)
				FreezeAll(_idGrp_UAN_ExoHouse_13,true)
				FreezeAll(_idGrp_UAN_ExoHouse_14,true)
				FreezeAll(_idGrp_UAN_ExoHouse_15,true)
				FreezeAll(_idGrp_UAN_ExoHouse_17,true)
				FreezeAll(_idGrp_UAN_ExoHouse_18,true)
				FreezeAll(_idGrp_UAN_ExoHouse_19,true)
				FreezeAll(_idGrp_UAN_ExoHouse_20,true)
				FreezeAll(_idGrp_UAN_ExoHouse_21,true)
				FreezeAll(_idGrp_UAN_ExoHouse_22,true)
				FreezeAll(_idGrp_UAN_ExoHouse_24,true)
				FreezeAll(_idGrp_UAN_ExoHouse_01,false)	
				Freeze(GetExoskeletonID("Exo_UAN_ExoHouse_1"),false)
		StopMusic()
		StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
 -- 	PauseMusic()
 --		StopMusic()
 	--	StartMusic()
		_bCtrlSE_ExoHouse_F_03 = true
		end

end


function OnEnter_SE_ExoHouse_F_04(_idSE_ExoHouse_F_04)
		if (_idSE_ExoHouse_F_04==_idPlayer) and (not _bExo4) then
				FreezeAll(_idGrp_UAN_ExoHouse_08,false)
				_bExo4=true
		end
end


function OnEnter_SE_ExoHouse_F_05(_idSE_ExoHouse_F_05)
		if (_idSE_ExoHouse_F_05==_idPlayer) and (not _bExo5) then
				FreezeAll(_idGrp_UAN_ExoHouse_13,false)
				_bExo5=true
		end
end


function OnEnter_SE_ExoHouse_F_06(_idSE_ExoHouse_F_06)
		if (_idSE_ExoHouse_F_06==_idPlayer) and (not _bExoB) then
				FreezeAll(_idGrp_UAN_ExoHouse_11,false)					
				FreezeAll(_idGrp_UAN_ExoHouse_13,false)
				_bExoB=true
		end
end


function OnEnter_SE_ExoHouse_F_07(_idSE_ExoHouse_F_07)
		if (_idSE_ExoHouse_F_07==_idPlayer) and (not _bExoB) then
				_bExoB=true
		end
end


function OnEnter_SE_ExoHouse_F_08(_idSE_ExoHouse_F_08)
		if (_idSE_ExoHouse_F_08==_idPlayer) and (not _bExo8) then
				FreezeAll(_idGrp_UAN_ExoHouse_11,false)
				_bExo8=true
		end
end


function OnEnter_SE_ExoHouse_F_09(_idSE_ExoHouse_F_09)
		if (_idSE_ExoHouse_F_09==_idPlayer) and (not _bExo9) then
				FreezeAll(_idGrp_UAN_ExoHouse_14,false)

				_bExo9=true
		end
end


function OnEnter_SE_ExoHouse_F_10(_idSE_ExoHouse_F_10)
		if (_idSE_ExoHouse_F_10==_idPlayer) and (not _bExo10) then			
				Freeze(_idChar_UAN_ExoHouse_1,false)
				FreezeAll(_idGrp_UAN_ExoHouse_11,false)
				FreezeAll(_idGrp_UAN_ExoHouse_13,false)				
				_bExo10=true
		end
end


function OnStay_SE_ExoHouse_F_21(_idSE_ExoHouse_F_21)
		if (_idSE_ExoHouse_F_21==_idPlayer) and (not _bExo21) and  _nBotActive<=8 then 
				FreezeAll(_idGrp_UAN_ExoHouse_15,false)
				_bExo21=true
		end

end


function OnStay_SE_ExoHouse_F_11(_idSE_ExoHouse_F_11)
		if (_idSE_ExoHouse_F_11==_idPlayer) and  _nBotActive<=8 and not _bGrpExoHouse_10 and _bExo4 then
					FreezeAll(_idGrp_UAN_ExoHouse_10,false)
					_bGrpExoHouse_10=true
		end
end


function OnEnter_SE_ExoHouse_F_12(_idSE_ExoHouse_F_12)
		if (_idSE_ExoHouse_F_12==_idPlayer) and (not _bExo12) then
				if IsAValidID(_idChar_UAN_ExoHouse_24_1) then
						Freeze(_idChar_UAN_ExoHouse_24_1,false)
				end
				if not _bExo25 then
						FreezeAll(_idGrp_UAN_ExoHouse_17,false)
						_bExo25=true
				end
				_bExo12=true
		end
end


function OnEnter_SE_ExoHouse_F_13(_idSE_ExoHouse_F_13)
		if (_idSE_ExoHouse_F_13==_idPlayer) and (not _bExo13) then
				FreezeAll(_idGrp_UAN_ExoHouse_21,false)

				FreezeAll(_idGrp_UAN_ExoHouse_17,true)
				_bExo13=true
		end
end


function OnEnter_SE_ExoHouse_F_14(_idSE_ExoHouse_F_14)
		if (_idSE_ExoHouse_F_14==_idPlayer) and (not _bExo14) then
				FreezeAll(GetGroupID("Grp_UAN_Exohouse_25"),false)
				_bExo14=true
		end
end


function OnEnter_SE_ExoHouse_F_15(_idSE_ExoHouse_F_15)
		if (_idSE_ExoHouse_F_15==_idPlayer) and (not _bExo15) then
				--Obj_D_1_Done()
				FreezeAll(_idGrp_UAN_ExoHouse_22,false)
				_bExo15=true
		end
end


function OnEnter_SE_ExoHouse_F_16(_idSE_ExoHouse_F_16)
		if (_idSE_ExoHouse_F_16==_idPlayer) and (not _bExo16) then
				FreezeAll(GetGroupID("Grp_UAN_Exohouse_26"),false)
				_bExo16=true
				UnLockDoor(GetDoorID("Door_Hangar_Big3A"))
			--	OpenDoor(GetDoorID("Door_Hangar_Big3A"))
				UnLockDoor(GetDoorID("Door_Hangar_Big3B"))
			--	OpenDoor(GetDoorID("Door_Hangar_Big3B"))
		end
end


function OnEnter_SE_ExoHouse_F_17(_idSE_ExoHouse_F_17)
		if (_idSE_ExoHouse_F_17==_idPlayer) and (not _bExo17) then
				FreezeAll(_idGrp_UAN_ExoHouse_15,false)
--				FreezeAll(_idGrp_UAN_ExoHouse_16,false)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_UAN_ExoHouse_15_2"),"PriorityTorso",20)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_UAN_ExoHouse_15_3"),"PriorityTorso",20)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_UAN_ExoHouse_15_2"),"PriorityLegs",60)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_UAN_ExoHouse_15_3"),"PriorityLegs",60)
				_bExo17=true
		end
end


function OnEnter_SE_ExoHouse_F_18(_idSE_ExoHouse_F_18)
		if (_idSE_ExoHouse_F_18==_idPlayer) and  _bExo16 and not _bExoSktn then
				SetVarValue(GetExoskeletonID("Exo_UAN_ExoHouse_2"),"Freeze",false)
				Freeze(_idExo_UAN_ExoHouse_2,false)
				_bExoSktn=true
		end
		if (_idSE_ExoHouse_F_18==_idChar_UAN_ExoHouse_20_1) or (_idSE_ExoHouse_F_18==_idChar_UAN_ExoHouse_20_2) then
				Freeze(_idSE_ExoHouse_F_18,true)
		end
end


function OnEnter_SE_ExoHouse_F_19(_idSE_ExoHouse_F_19)
		if (_idSE_ExoHouse_F_19==_idPlayer) and (not _bExo19) then
				FreezeAll(_idGrp_UAN_ExoHouse_04,false)
				_bExo19=true
		end
end


function OnStay_SE_ExoHouse_F_22(_idSE_ExoHouse_F_22)
		if (_idSE_ExoHouse_F_22==_idPlayer) and (not _bExo22) and  _nBotActive<=8 then
				FreezeAll(_idGrp_UAN_ExoHouse_24,false)
				_bExo22=true
		end
end


function OnEnter_SE_ExoHouse_F_23(_idSE_ExoHouse_F_23)

		if (_idSE_ExoHouse_F_23==_idPlayer) then
				FreezeAll(_idGrp_UAN_ExoHouse_15,true)
		end

end


function OnEnter_SE_ExoHouse_F_24(_idSE_ExoHouse_F_24)

		if (_idSE_ExoHouse_F_24==_idPlayer) and not _bSE_ExoHouse_F_24 then
				MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_06",true,110,1,1,"",100)
			--	Freeze(_idChar_UAN_ExoHouse_5,true)
				Freeze(GetExoskeletonID("Exo_UAN_ExoHouse_1"),true)
			--	Freeze(GetExoskeletonID("Exo_UAN_ExoHouse_3"),true)
				_bSE_ExoHouse_F_24=true
		end

end


function OnEnter_SE_ExoHouse_F_25(_idSE_ExoHouse_F_25)
		if (_idSE_ExoHouse_F_25==_idPlayer) and (not _bExo25) then
				FreezeAll(_idGrp_UAN_ExoHouse_17,false)
				_bExo25=true
		end
end



function OnEnter_SE_ExoHouse_F_26(_idSE_ExoHouse_F_16)
		if (_idSE_ExoHouse_F_16==_idPlayer) and _bExo16 and not _bExoSee then
				_bExoSee=true
		end
end



function OnEnter_SE_ExoHouse_F_27(_idSE_ExoHouse_F_27)
		if (_idSE_ExoHouse_F_27==_idPlayer) and not _bExo27 then
					Freeze(_idChar_UAN_ExoHouse_07_2,false)
			--		Freeze(GetCharacterID("Char_WRF_ExoHouse_1"),false)
					_bExo27=true
		end
end




function OnEnter_SE_ExoHouse_F_28(_idSE_ExoHouse_F_28)
		if (_idSE_ExoHouse_F_28==_idPlayer) and not _bExo28 then
					_bExo28=true
		end
end



function OnEnter_SE_ExoHouse_T_01(_idSE_ExoHouse_T_01)

		if _idSE_ExoHouse_T_01==_idPlayer then
				UnLockDoor(GetDoorID("Door_Hangar_Big2A"))
				OpenDoor(GetDoorID("Door_Hangar_Big2A"))
				UnLockDoor(GetDoorID("Door_Hangar_Big2B"))
				OpenDoor(GetDoorID("Door_Hangar_Big2B"))

				Freeze(GetCharacterID("Char_UAN_ExoHouse_19_4"),false)
		end

end



function OnEnter_SE_ExoHouse_T_02(_idSE_ExoHouse_T_02)
		if _idSE_ExoHouse_T_02==_idPlayer then
				FreezeAll(_idGrp_UAN_ExoHouse_01,true)
				FreezeAll(_idGrp_UAN_ExoHouse_02,true)
				FreezeAll(_idGrp_UAN_ExoHouse_03,true)
				FreezeAll(_idGrp_UAN_ExoHouse_04,true)
				FreezeAll(_idGrp_UAN_ExoHouse_05,true)
				FreezeAll(_idGrp_UAN_ExoHouse_06,true)
				FreezeAll(_idGrp_UAN_ExoHouse_08,true)
				FreezeAll(_idGrp_UAN_ExoHouse_10,true)
				FreezeAll(_idGrp_UAN_ExoHouse_11,true)
				FreezeAll(_idGrp_UAN_ExoHouse_12,true)
				FreezeAll(_idGrp_UAN_ExoHouse_13,true)
				FreezeAll(_idGrp_UAN_ExoHouse_14,true)
				FreezeAll(_idGrp_UAN_ExoHouse_15,true)
				Freeze(_idChar_UAN_ExoHouse_1,true)
				Freeze(_idChar_UAN_ExoHouse_2,true)
				Freeze(_idChar_UAN_ExoHouse_3,true)
				Freeze(_idChar_UAN_ExoHouse_4,true)
		end

		if _idSE_ExoHouse_T_02==_idPlayer and not _bDejaDca then
				Freeze(_idChar_UAN_ExoHouse_3,false)

				_bDejaDca=true
		end
end



function OnEnter_SE_ExoHouse_Dca_02(_idSE_ExoHouse_Dca_02)
		if (_idPlayer==_idSE_ExoHouse_Dca_02) and not _bExoDca2 then
				FreezeAll(_idGrp_UAN_ExoHouse_18,false)
				MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_19",true,110,2,1,"",100)	
				SetVarValue(_idChar_Ingenieur,"CharacterOrderList",_idAI_O_List_Ingenieur1)
				NewSubObjective ( "Obj_C_1", "Obj_C_2")
				_bExoDca2=true
		end
end




function OnEnter_SE_ExoHouse_Dca_03(_idSE_ExoHouse_Dca_03)
		if (_idChar_Ingenieur==_idSE_ExoHouse_Dca_03) and not _bExoDca3 then
				SetVarValue(GetTimerID("Timer_ExoHouse_Ingenieur"),"Active",true)
				_bExoDca3=true
		end
end


--------------------- Fonctions d'expiration d'ordres --------------------

function ExpirationGotoWaypointExo3()

    if _bExoDca2 then
				return true
    end
    return false

end



function ExpirationGotoWaypointExoHouse(idCharacter1)

    if  _bExo2 then
				return true
    end
    return false

end


--[[
Lors du compte à rebours de l'explosion, la Forbid Zone SE_ExoHouse_Dca_02 devient
active, et tous les bots fuient donc l'imminente explosion. Une fois les charges
explosées, l'Order Forbid-Zone est annulé.
--]]
function ExpirationForbidZone2(idCharacter2)
    if _bBoom2 then
        return true
    end
 
    return false
end


function FleeExoHouse(_idFuyard)
		if _bExoFlee1 then
				return true
		end

		return false
end


function ExpirationLimitZone_ExoHouse(idCharacter2)
    if (CharacterCanSee(_idChar_UAN_ExoHouse_06_1,_idPlayer) or CharacterCanFeelDamage(_idChar_UAN_ExoHouse_06_1,_idPlayer))
		or (CharacterCanSee(_idChar_UAN_ExoHouse_06_2,_idPlayer) or CharacterCanFeelDamage(_idChar_UAN_ExoHouse_06_2,_idPlayer)) then
        return true
    end
 
    return false
end


function ExpirationLimitZone_ExoHouse2(idCharacter)
    if ExoB or Exo10 then
        return true
    end
 
    return false
end


function FleeExohangar()
		if _bFuiteExo then
				return true
		end
		return false
end


function Exp_AttackExo()
		if _bExoSee and not _bTimerExo then
				SetVarValue(_idTimer_ExoHouse_02,"Active",true)
				_bTimerExo=true
				return true
		end
		return false
end



function ExpirationGotoWaypointWRF(idCharacter1)

    if not IsAlive(_idChar_UAN_ExoHouse_07_2) then
				return true
    end
    return false

end


-------------------------- Fonctions diverses ----------------------------

function Renfort_ExoHouse()
		if AliveMembersCount(_idGrp_UAN_ExoHouse_18)<=2 and not _bRenfortExo2 then
				FreezeAll(_idGrp_UAN_ExoHouse_19,false)	
				_bRenfortExo2=true			
		end
end


function Renfort_ExoHouse_Bat()
		if (AliveMembersCount(_idGrp_UAN_ExoHouse_11)<=1 or ExoB) and (not _bRenfortExo_Bat1) then
				Freeze(_idChar_UAN_ExoHouse_1,false)				
				FreezeAll(_idGrp_UAN_ExoHouse_12,false)	
				_bRenfortExo_Bat1=true			
		end
end


function BoomDca2()
	if (_bCtrlBoomDca2 == false) then
		_bBoom2=true  -- Indique que l'explosion a eu lieu
		SetVarValue(GetTimerID("Timer_Merc_Dca2"),"Active",true)	
-- Explosions
--[[
		_idExplosionDca1=CreateExplosion()
		SetVarValue(_idExplosionDca1,"Type","Explosion_Test")
		SetVarValue(_idExplosionDca1,"Position",Vector3D(120,-3046,289))

		_idExplosionDca2=CreateExplosion()
		SetVarValue(_idExplosionDca2,"Type","Explosion_Test")
		SetVarValue(_idExplosionDca2,"Position",Vector3D(103,-3097,271))

		_idExplosionDca3=CreateExplosion()
		SetVarValue(_idExplosionDca3,"Type","Explosion_Test")
		SetVarValue(_idExplosionDca3,"Position",Vector3D(147,-3059,272))

		_idExplosionDca4=CreateExplosion()
		SetVarValue(_idExplosionDca4,"Type","Explosion_Test")
		SetVarValue(_idExplosionDca4,"Position",Vector3D(120,-3092,231))

		_idExplosionDca5=CreateExplosion()
		SetVarValue(_idExplosionDca5,"Type","Explosion_Test")
		SetVarValue(_idExplosionDca5,"Position",Vector3D(81,-3063,232))
--]]

		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_dca2"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_dca3"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_dca4"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_dca5"),"FxState","Fx Started")

		SetVarValue(GetDestructible_ObjectID("Destructible_Object_DCA_2"),"Destroyed",true)
		SetVarValue(_idMerc[0], "CharacterOrderList", GetInvalidEntityID())
		SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-16"),"Explosion Delay",0)
		SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-16"),"Active",false)

		CameraShake(1.0, 0.7, 0.7, 0.7)
		SetVarValue(GetSound_ClientID("Sound_Client-483"),"Playing",true)
		StopMusic()
		StartMusic("Sounds//Music//Bos - War theme.wav", true)
 -- 	PauseMusic()
 --		StopMusic()
 	--	StartMusic()
		_bCtrlBoomDca2 = true
	end
end


function AlerteExoHouse()
		if (CharacterCanSee(_idChar_UAN_ExoHouse_4,_idPlayer) or CharacterCanFeelDamage(_idChar_UAN_ExoHouse_4,_idPlayer)) and (not _bExo1) then
					FreezeAll(_idGrp_UAN_ExoHouse_02,false)
					FreezeAll(_idGrp_UAN_ExoHouse_03,false)
					FreezeAll(_idGrp_UAN_ExoHouse_20,false)
					SetVarValue(GetTimerID("Timer_ExoHouse_Alarm"),"Active",true)
					SetVarValue(_idAI_O_Use_Exo_UAN_ExoHouse_1,"PriorityTorso", 40)
					SetVarValue(_idAI_O_Use_Exo_UAN_ExoHouse_1,"PriorityLegs", 90)	
					_bExo1=true
		end 
end


--[[
Compte à rebours de l'explosion, tous le monde fuit la zone, dû à l'activation
de l'Order_Forbid_Zone_Dca2.
--]]
function FollowPlayer2()

SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Ingenieur1b"))
MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_16",true,110,1,1,"",4)

-- Activation de l'Order_Forbid_Zone_Dca1.		
		SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Dca2"),"PriorityLegs",100)
-- Activation du compte à rebours retranscrit par le Timer_Island_Dca1.
		SetVarValue(GetTimerID("Timer_ExoHouse_Dca2"),"Active",true)
		
end

function OnEnter_SE_ExoHouse_Dca_05(id)
	if ((id == _idMerc[0]) and (_bCtrlSE_ExoHouse_Dca_05 == false)) then
		BoomDca2()
		SetVarValue(GetObjectiveID("Obj_C_2"),"Active",false)	
		SetVarValue(GetObjectiveID("Obj_C_3"),"Active",false)
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_C", "Obj_D", "Obj_D_1" )
		SetVarValue(GetObjectiveID("Obj_D_3"),"Active",true)

		_bCtrlSE_ExoHouse_Dca_05 = true
	end
end

function FuiteExo()
		_bFuiteExo=true
end


function SeeExo()
	--	if CharacterCanSee(_idChar_UAN_ExoHouse_22_1,_idPlayer) and (not _bDejaSeeExo) then
		--		SetVarValue(_idTimer_ExoHouse_01,"Active",true)		
			--	_bDejaSeeExo=true
		--end
end



function DetectPlayer(idBot)
		if CharacterCanFeelDamage(idBot, _idPlayer) or CharacterCanSee(idBot, _idPlayer) then
				return true
		end
end


function DialMercDca2()

		MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_05",true,110,1,1,"",100)
end



function Boom_Reservoir()

				_idExp_ExoHouse_1 = CreateExplosion()
				SetVarValue(_idExp_ExoHouse_1,"Position",_vPos_FX_Combustion_ExoHouse_1)
				SetVarValue(_idExp_ExoHouse_1,"Type","Explosion_Rocket_Bombardement")
				SetVarValue(_idFX_Combustion_ExoHouse_1,"FxState","Fx Started")
				_idExp_ExoHouse_2 = CreateExplosion()
				SetVarValue(_idExp_ExoHouse_2,"Position",_vPos_FX_Combustion_ExoHouse_2)
				SetVarValue(_idExp_ExoHouse_2,"Type","Explosion_Rocket_Bombardement")
				SetVarValue(_idFX_Combustion_ExoHouse_2,"FxState","Fx Started")
				_idExp_ExoHouse_3 = CreateExplosion()
				SetVarValue(_idExp_ExoHouse_3,"Position",_vPos_FX_Combustion_ExoHouse_3)
				SetVarValue(_idExp_ExoHouse_3,"Type","Explosion_Rocket_Bombardement")
				SetVarValue(_idFX_Combustion_ExoHouse_3,"FxState","Fx Started")
				_idExp_ExoHouse_4 = CreateExplosion()
				SetVarValue(_idExp_ExoHouse_4,"Position",_vPos_FX_Combustion_ExoHouse_4)
				SetVarValue(_idExp_ExoHouse_4,"Type","Explosion_Rocket_Bombardement")
				SetVarValue(_idFX_Combustion_ExoHouse_4,"FxState","Fx Started")

				SetVarValue(_idFX_Combustion_ExoHouse_5,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_6,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_7,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_8,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_9,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_10,"FxState","Fx Started")
				SetVarValue(_idFX_Combustion_ExoHouse_11,"FxState","Fx Started")
end


function ExoAttack()
end


function Alarm_ExoHouse()

end



function Perimeter_Player(id1, id2,per)
		_vPos1=GetVarValue(id1,"Position")
		_vPos2=GetVarValue(id2,"Position")
		if (_vPos1:GetX())<=(_vPos2:GetX()+per) and (_vPos1:GetX())>=(_vPos2:GetX()-per) and (_vPos1:GetY())<=(_vPos2:GetY()+per) and (_vPos1:GetY())>=(_vPos2:GetY()-per) then
				return true
		else
				return false
		end
end


function Rescue_WRF()

end



function DeblockWRF()

end



-----------------------------------------------------------------------------------------------------
--[[																		Objective_Cargo_Bay_3_2_Active()

Lancée par le timer du même nom.
--]]
-----------------------------------------------------------------------------------------------------

function Objective_Cargo_Bay_3_2_Active()


end



-----------------------------------------------------------------------------------------------------
--[[																		Objective_Cargo_Bay_4_1_Active()

Lancée par le timer du même nom.
--]]
-----------------------------------------------------------------------------------------------------

function Objective_Cargo_Bay_4_1_Active()


end



function Objective_Cargo_Bay_4_2_Active()


end



function Obj_D_1_Done()

				NewSubObjective ( "Obj_D_1", "Obj_D_2")		
				SetVarValue(GetTankID("Tank_1"),"Max Distance",1000)
				SetVarValue(GetTankID("Tank_2"),"Max Distance",1000)
		MiniMapTrack(GetTankID("Tank_1"),2,true)
		MiniMapTrack(GetTankID("Tank_2"),2,true)
end

-----------------------------

function TimerPlantBomb2()
				CreationTimer(true, true, false, "PlantBomb2",3)	
end

function PlantBomb2()
	PlantExplosive(GetExposive_Plant_SiteID("Exposive_Plant_Site-16"))
end



function TestPlayerExo()
	_idExoPlayer = GetCharacterCurrentExoskeleton(_idPlayer)
	if (((_idExoPlayer == GetExoskeletonID("Exo_ExoHouse_1")) or (_idExoPlayer == GetExoskeletonID("Exo_ExoHouse_2"))) and (_bCtrlTestPlayerExo == false)) then
		Obj_D_1_Done()
		_bCtrlTestPlayerExo = true
	end
end


----------------------------------------------------------

----------------------------------------------------------

function OnEnter_SE_Exo_Tips(id)
	if (id == _idPlayer) then
		_idExoPlayer = GetCharacterCurrentExoskeleton(_idPlayer)
		if (((_idExoPlayer == GetExoskeletonID("Exo_ExoHouse_1")) or (_idExoPlayer == GetExoskeletonID("Exo_ExoHouse_2"))) and (_bCtrlSE_Exo_Tips == false)) then
			DisplayTips ("GUI_TIPS_SOLO_NIV_H_03")
			_bCtrlSE_Exo_Tips = true
		end
	end
end







