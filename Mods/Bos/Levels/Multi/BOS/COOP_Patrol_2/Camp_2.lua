function InitLevel_Camp_2()

		OpenDoor(GetDoorID("Door_Camp_2_1"))
		_bExp_Debut = false
end


function UpdateLevel_Camp_2()
		HelpCamp_2()
		RenfortUANCamp_2()
		Renfort2UANCamp_2()
--		KillCamp_2()
		KillSnipers()
		Dial1_Camp2()
		CloseDoorCp2()
end







function Exp_Debut()
	if (_bExp_Debut == true) then
		return true
	else
		return false
	end
end










------------------ Fonctions relatives au Sector Events ------------------

function OnEnter_SE_Camp_2_F_01(_idSE_Camp_2_F_01)
		if (_idSE_Camp_2_F_01==_idPlayer) then
				FreezeAll(_idGrp_UAN_Camp_2_1,false)
				FreezeAll(_idGrp_WRF_Camp_2_1,false)
				FreezeAll(_idGrp_WRF_Camp_2_2,false)
				SetGodMode(_idChar_UAN_Camp_2_01_4,true)

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
				StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()
		end
end


function OnEnter_SE_Camp_2_F_03(_idSE_Camp_2_F_03)
		if (_idSE_Camp_2_F_03==_idPlayer) and not _bCoverThem then
					_bCoverThem=true
					_bExp_Debut = true
				SetGodMode(_idChar_UAN_Camp_2_01_4,false)
		end
end


function OnEnter_SE_Camp_2_F_04(_idSE_Camp_2_F_04)
		if (_idSE_Camp_2_F_04==_idPlayer) and not _bSeePlayerCp2 then
				if not _bKillSnip and IsAlive(_idChar_WRF_Camp_2_02_3) then
						MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,_idPlayer,"DIA_GEN_SEE_SNIPERS_TEAM_A_VOICE_B_1",true,120,2,1,"",100)
				end

				_bSeePlayerCp2=true
		end
end


function OnEnter_SE_Camp_2_F_05(_idSE_Camp_2_F_05)
		if (_idSE_Camp_2_F_05==_idPlayer) then
				FreezeAll(_idGrp_WRF_Camp_2_1,true)
				FreezeAll(_idGrp_WRF_Camp_2_2,true)
		end
end


function OnEnter_SE_Camp_2_F_06(_idSE_Camp_2_F_06)
		if (_idSE_Camp_2_F_06==_idPlayer) then
				FreezeAll(_idGrp_UAN_Camp_2_3,false)
				FreezeAll(_idGrp_UAN_Camp_2_4,false)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()
		end
		if not _bRenfortUANCamp_2 and (_idSE_Camp_2_F_06==_idPlayer) then
				FreezeAll(_idGrp_UAN_Camp_2_2,false)
--				MakeCharacterSpeak(_idChar_UAN_Camp_2_02_2,"DIA_GEN_UAN_46",true,2)
				_bRenfortUANCamp_2=true
		end
end


function OnStay_SE_Camp_2_F_07(_idSE_Camp_2_F_07)
		if (_idSE_Camp_2_F_07~=_idPlayer) and (_idSE_Camp_2_F_07~=_idMerc[0]) and (_idSE_Camp_2_F_07~=_idMerc[1])
		and not IsEntityInBox (_idPlayer,"SE_Camp_2_F_08") then 
				Freeze(_idSE_Camp_2_F_07,true)
		end
end


function OnEnter_SE_Camp_2_F_09(_idSE_Camp_2_F_09)
		if (_idSE_Camp_2_F_09==_idPlayer) and not _bBoomSand then
				-- AssaultSandWich()
				FreezeAll(_idGrp_UAN_Camp_2_5,false)
				-- FreezeAll(_idGrp_UAN_Camp_2_6,false)
				--_bBoomSand=true
		end
end


function OnEnter_SE_Camp_2_F_10(_idSE_Camp_2_F_10)

		if (_idSE_Camp_2_F_10==_idPlayer) and not _bPlayerCome then
--[[				EnableCharacterCommand(_idPlayer, false)
				if (_idMerc[0] ~= nil) then 
						EnableCharacterCommand(_idMerc[0], false)
				end
				if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1], false)
				end
--]]
				_bPlayerCome=true
		end

end



function OnStay_SE_Camp_2_F_12(_idSE_Camp_2_F_12)

		if (_idSE_Camp_2_F_12==_idPlayer) and not _bPassDoor then
				if (_idMerc[0] ~= nil) and (_idMerc[1] ~= nil) then
						if IsAlive(_idMerc[0]) and IsAlive(_idMerc[1]) and IsEntityInBox(_idMerc[0],"SE_Camp_2_F_12") and IsEntityInBox(_idMerc[1],"SE_Camp_2_F_12") then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						elseif not IsAlive(_idMerc[1]) and IsAlive(_idMerc[0]) and IsEntityInBox(_idMerc[0],"SE_Camp_2_F_12") then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						elseif not IsAlive(_idMerc[0]) and IsAlive(_idMerc[1]) and IsEntityInBox(_idMerc[1],"SE_Camp_2_F_12") then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						elseif not IsAlive(_idMerc[0]) and not IsAlive(_idMerc[1]) then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						end
				end
				if (_idMerc[0] ~= nil) then
						if IsAlive(_idMerc[0]) and IsEntityInBox(_idMerc[0],"SE_Camp_2_F_12") then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true			
						elseif not IsAlive(_idMerc[0]) then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						end
				end
				if (_idMerc[1] ~= nil) then
						if IsAlive(_idMerc[1]) and IsEntityInBox(_idMerc[1],"SE_Camp_2_F_12") then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true			
						elseif not IsAlive(_idMerc[1]) then
								CloseDoor(GetDoorID("Door_Camp_2_1"))
								LockDoor(GetDoorID("Door_Camp_2_1"))	
								_bPassDoor=true	
						end
				end
		end

end


--------------------- Fonctions d'expiration d'ordres ------------------

function ExpGotoWaypoint_CharWRF_02_2()
		if _bKillSnip then
				return true
		end
		return false
end


function ExpGotoWaypoint_CharWRF_02_3a()
		if _bPlayerCome then
				return true
		end
		return false
end


function ExpGotoWaypoint_CharWRF_02_3b()
		if _bGoWithPlayer then
				return true
		end
		return false
end

--------------------- Fonctions diverses -------------------------------

function KillSnipers()

		if not IsFrozen(_idChar_UAN_Camp_2_01_4) and not IsAlive(_idChar_UAN_Camp_2_01_4) and not _bKillSnip then
--				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_2,"DIA_GEN_WRF_79",true,2)
				SetVarValue(GetTimerID("Timer_Camp_2_01"), "Active", true)
				SetVarValue(GetTimerID("Timer_Camp_2_03"), "Active", true)
		end

end


function HelpCamp_2()

		if IsAlive(_idChar_WRF_Camp_2_01_1) and (AliveMembersCount(_idGrp_UAN_Camp_2_1)==0) and IsEntityInBox(_idPlayer,"SE_Camp_2_F_08") 
		and IsEntityInBox(_idChar_WRF_Camp_2_01_1,"SE_Camp_2_F_08") and not _bHelpCamp_2 then
				MakeCharacterSpeak(_idChar_WRF_Camp_2_01_1,_idPlayer,"DIA_SPE_NIV_D_WRF_D_01",true,120,2,2,"",100)
				_bHelpCamp_2=true
		end

end


function RenfortUANCamp_2()

		if  AliveMembersCount(_idGrp_UAN_Camp_2_1)<=1 and not _bRenfortUANCamp_2 then
				FreezeAll(_idGrp_UAN_Camp_2_2,false)
--				MakeCharacterSpeak(_idChar_UAN_Camp_2_02_2,"DIA_GEN_UAN_46",true,2)
				_bRenfortUANCamp_2=true
		end

end



function Renfort2UANCamp_2()

		if  AliveMembersCount(_idGrp_UAN_Camp_2_2)<=1 and not _bRenfort2UANCamp_2 then
				FreezeAll(_idGrp_UAN_Camp_2_3,false)
				_bRenfort2UANCamp_2=true
		end

end



function KillCamp_2()

		if ((not IsAlive(_idChar_WRF_Camp_2_02_1)) or (not IsAlive(_idChar_WRF_Camp_2_02_2))) and (not _bKillCamp_2_1) then
--				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_1,"DIA_GEN_WRF_07",true,2)
				_bKillCamp_2_1=true
		end
		if (not IsAlive(_idChar_WRF_Camp_2_02_1)) and (not IsAlive(_idChar_WRF_Camp_2_02_2)) and (not _bKillCamp_2_2) then
				--DisplaySubtitle("DIA_GEN_WRF_02",2,4)
				_bKillCamp_2_2=true
		end
		if (not IsAlive(_idChar_UAN_Camp_2_01_1) or not IsAlive(_idChar_UAN_Camp_2_01_2) or not IsAlive(_idChar_UAN_Camp_2_01_3)) and (not _bKillCamp_2_3) then
--				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_2,"DIA_GEN_WRF_90",true,2)
				_bKillCamp_2_3=true
		end

end



function Camp_2_Dial_Snip()

		if IsAlive(_idChar_WRF_Camp_2_02_3) then
				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,_idPlayer,"DIA_SPE_NIV_D_WRF_C_01",true,120,2,2,"",100)
		end

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



function Dial1_Camp2()

		_bDial1_d=Perimeter_Player(_idPlayer, _idChar_WRF_Camp_2_02_3,30)
		if _bDial1_d and not _bDial1_Ok and  _bPlayerCome then
				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,_idPlayer,"DIA_SPE_NIV_D_WRF_C_02",true,130,2,2,"DeblockPlayer",100)
--				SetVarValue(GetTimerID("Timer_Camp_2_02"),"Active",true)				
				_bDial1_Ok=true
		end

end



function Dial2_Camp2()
--		MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,"DIA_GEN_WRF_51",true,2)
		--_bGoWithPlayer=true
end


function CounterStrike()

		_bKillSnip=true
		if IsAlive(_idChar_WRF_Camp_2_02_3) then
				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,GetInvalidEntityID(),"DIA_GEN_START_FIRE_TEAM_B_VOICE_B_1",true,120,2,1,"",100)
		end

end


function CloseDoorCp2()

		if IsEntityInBox(_idPlayer,"SE_Camp_2_F_11") and (IsEntityInBox(_idChar_WRF_Camp_2_02_1,"SE_Camp_2_F_11") 
		or IsEntityInBox(_idChar_WRF_Camp_2_02_2,"SE_Camp_2_F_11") or IsEntityInBox(_idChar_WRF_Camp_2_02_3,"SE_Camp_2_F_11"))
		and not _bCloseDoors then
				MakeCharacterSpeak(_idChar_WRF_Camp_2_02_3,_idPlayer,"DIA_SPE_NIV_D_WRF_C_03",true,120,2,2,"",100)
				_bCloseDoors=true
		end

end


--[[
function AssaultSandWich()

		_idExplosionCp2 = CreateExplosion()
		SetVarValue(_idExplosionCp2,"Position",Vector3D(-(3084.3),1488.5,18))
		SetVarValue(_idExplosionCp2,"Type","Explosion_Rocket_A")
		SetVarValue(GetSound_ClientID("Sound_Explosion_Camp_2_01"),"Playing",true)
		SetVarValue(GetParticleFX_ClientID("FX_Fire_Camp_2_01"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Fire_Camp_2_02"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Exp_Camp_2_01"),"FxState","Fx Started")
		SetVarValue(GetTimerID("Timer_Camp_2_04"),"Active",true)

end
--]]


function Dial_SandWich()

		if IsAlive(_idChar_UAN_Camp_2_06_1) then
				MakeCharacterSpeak(_idChar_UAN_Camp_2_06_1,GetInvalidEntityID(),"DIA_GEN_START_FIRE_TEAM_B_VOICE_A_1",true,120,2,1,"",100)
		end

end


function DeblockPlayer()

				_bGoWithPlayer=true
				EnableCharacterCommand(_idPlayer, true)
				if (_idMerc[0] ~= nil) then 
						EnableCharacterCommand(_idMerc[0], true)
				end
				if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1], true)
				end

end