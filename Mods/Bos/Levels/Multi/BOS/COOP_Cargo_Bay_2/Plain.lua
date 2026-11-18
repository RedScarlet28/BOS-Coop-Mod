
function InitLevel_Plain()
	_bCtrlTank1KO = false
	_bCtrlTank2KO = false
	_bCtrlTank3KO = false
	_bCtrlSE_Plain_F_10 = false
	_bTankIsDestroyed = false
	DebugSnipersTransition()
	SetSnipersTransition()
end

function UpdateLevel_Plain()
		RenfortPlace()		
		RenfortFin()
		TankKO()
end

function DebugSnipersTransition()

end

function SetSnipersTransition()
	if (g_bSnipersTransition == true) then
		if (g_nHealthChar_UAN_Plain_14_1 >=1) then 
			Freeze(_idChar_UAN_Plain_14_1,false)
		end	
		if (g_nHealthChar_UAN_Plain_14_2 >=1) then 
			Freeze(_idChar_UAN_Plain_14_2,false)
		end	
		if (g_nHealthChar_UAN_Plain_14_3 >=1) then 
			Freeze(_idChar_UAN_Plain_14_3,false)
		end
	end
end

function OnEnter_Sector_Event_0(id)
	if (id == _idPlayer) then
		FreezeAll(GetGroupID("Grp_UAN_Plain_21"),false)
	end
end






------------------ Fonctions relatives au Sector Events ------------------

function OnEnter_SE_Plain_F_02(_idSE_Plain_F_02)		
		if (_idSE_Plain_F_02==_idPlayer) and (_bPontZone2 or _bPontZone3 or _bPontZone4) and  (not _bPontE0) then
					FreezeAll(_idGrp_UAN_Plain_03,false)			
					FreezeAll(_idGrp_UAN_Plain_04,false)					
					_bPontE0=true
		elseif (_idSE_Plain_F_02==_idPlayer) and (not _bPontE1) and not AreAllFrozen(_idGrp_UAN_Plain_02) then
-- Le joueur avance, les bots reculent:
					-- 1. On va utiliser ce bouléen pour casser l'ordre.
					_bPontE1=true
		end
end


function OnEnter_SE_Plain_F_03(_idSE_Plain_F_03)
		if (_idSE_Plain_F_03==_idPlayer) and (_bPontZone3 or _bPontZone4) and  (not _bPontE2) then			
					FreezeAll(_idGrp_UAN_Plain_04,false)					
					_bPontE2=true
		elseif (_idSE_Plain_F_03==_idPlayer) and (not _bPontE3) and not AreAllFrozen(_idGrp_UAN_Plain_03) then
-- Le joueur avance, les bots reculent:
					-- 1. On va utiliser ce bouléen pour casser l'ordre.
					_bPontE3=true
		end
end


function OnEnter_SE_Plain_F_04(_idSE_Plain_F_04)
		if (_idSE_Plain_F_04==_idPlayer) and (_bPontZone4) and  (not _bPontE4) then			
					FreezeAll(_idGrp_UAN_Plain_04,false)					
					_bPontE4=true
		elseif (_idSE_Plain_F_04==_idPlayer) and (not _bPontE5) and not AreAllFrozen(_idGrp_UAN_Plain_04) then
-- Le joueur avance, les bots reculent:
					-- 1. On va utiliser ce bouléen pour casser l'ordre.
					_bPontE5=true
		end
end


function OnEnter_SE_Plain_F_05(_idSE_Plain_F_05)
		if (_idSE_Plain_F_05==_idPlayer) and (not _bPontE6) and _bPontZone1 then
				FreezeAll(_idGrp_UAN_Plain_02,false)
				_bPontE6=true
		end
end


function OnEnter_SE_Plain_F_06(_idSE_Plain_F_06)
		if (_idSE_Plain_F_06==_idPlayer) and (not _bPontE7) then
				FreezeAll(_idGrp_UAN_Plain_09,false)
				_bPontE7=true
		end
end


function OnEnter_SE_Plain_F_01(_idSE_Plain_F_01)
		if (_idPlayer==_idSE_Plain_F_01) then
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_1"),"PriorityLegs",0)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_2"),"PriorityLegs",0)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_1"),"PriorityTorso",0)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_2"),"PriorityTorso",0)
					Freeze(GetCharacterID("Char_UAN_Hangar_01_5"),false)
					FreezeAll(_idGrp_UAN_Hangar_03,false)
					FreezeAll(_idGrp_UAN_Hangar_04,false)
					FreezeAll(_idGrp_UAN_Hangar_05,false)
					FreezeAll(_idGrp_UAN_Hangar_06,false)
					FreezeAll(_idGrp_UAN_Hangar_09,false)

					FreezeAll(_idGrp_UAN_Plain_01,true)
					FreezeAll(_idGrp_UAN_Island_01,true)
					_bEndHang=false
		end
end


function OnEnter_SE_Plain_F_07(_idSE_Plain_F_07)
		if (_idPlayer==_idSE_Plain_F_07) then
					FreezeAll(_idGrp_UAN_Plain_01,false)
					FreezeAll(_idGrp_UAN_Island_01,false)

					if _nBotActive<=8 then
							FreezeAll(_idGrp_UAN_Plain_10,false)
					end

					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_1"),"PriorityLegs",100)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_2"),"PriorityLegs",100)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_1"),"PriorityTorso",100)
					SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Hangar_2"),"PriorityTorso",100)
					Freeze(GetCharacterID("Char_UAN_Hangar_01_5"),true)
					FreezeAll(_idGrp_UAN_Hangar_03,true)
					FreezeAll(_idGrp_UAN_Hangar_04,true)
					FreezeAll(_idGrp_UAN_Hangar_05,true)
					FreezeAll(_idGrp_UAN_Hangar_06,true)
					FreezeAll(_idGrp_UAN_Hangar_09,true)
					_bEndHang=true
		end
end


function OnEnter_SE_Plain_P_02(_idSE_Plain_P_02)
		if (_idSE_Plain_P_02==_idPlayer) then
				FreezeAll(_idGrp_UAN_Plain_15,false)
				_bPontRenfort=true
		end
end


function OnEnter_SE_island_LZ_03(_idSE_island_LZ_03)
		if (_idSE_island_LZ_03==_idPlayer) and (not _bPlace) and _bBOS2 then
				FreezeAll(_idGrp_UAN_Plain_08,false)
				FreezeAll(_idGrp_UAN_Plain_02,false)
				_bPlace=true
		end
end



function OnEnter_SE_Plain_FZ_2(_idSE_Plain_FZ_2)
		if (_idSE_Plain_FZ_2~=_idPlayer)  then
					Freeze(_idSE_Plain_FZ_2,true)		
		end
end



function OnEnter_SE_Plain_LZ_01(_idSE_Plain_LZ_01)
		if (_idSE_Plain_LZ_01==_idPlayer)  then
					SetVarValue(GetCharacterID("Char_UAN_Plain_01_1"),"CurrentSlot","OneHanded")
					SetVarValue(GetCharacterID("Char_UAN_Plain_01_2"),"CurrentSlot","OneHanded")	
		end
end


function OnStay_SE_Plain_LZ_01(_idSE_Plain_LZ_01)
		if (_idSE_Plain_LZ_01~=_idPlayer) and _bPlain09 then
				Freeze(_idSE_Plain_LZ_01,true)	
		end
end


function OnEnter_SE_Plain_F_08(_idSE_Plain_F_08)
		if TankA() and (_idSE_Plain_F_08==_idPlayer) and (not _bPlainTank) then
			FreezeAll(_idGrp_UAN_Plain_11,false)		
			_bPlainTank=true
		end
end


function OnEnter_SE_Plain_F_09(_idSE_Plain_F_09)
		if (_idSE_Plain_F_09 == _idPlayer)  then
				FreezeAll(_idGrp_UAN_Plain_10,false)			
				FreezeAll(_idGrp_UAN_Island_03,true)
				FreezeAll(_idGrp_UAN_Island_04,true)
				FreezeAll(_idGrp_UAN_Island_05,true)
				FreezeAll(_idGrp_UAN_Island_06,true)
				FreezeAll(_idGrp_UAN_Island_07,true)					
				_bPlain09 = false
		end
end


function OnEnter_SE_Plain_F_10(_idSE_Plain_F_10)
		if (_idSE_Plain_F_10==_idPlayer) and (_bCtrlSE_Plain_F_10 == false) then		
				FreezeAll(_idGrp_UAN_Plain_12,false)
				MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_10",true,110,1,1,"",100)
				_bPlainTank2=true
				_bSE_Plain_F_10=true
				_bCtrlSE_Plain_F_10 = true
		end
end

--------------------- Fonctions d'expiration d'ordres --------------------

function ExpLimit_Distance_Plain_09(idCharacter1)
    if AliveMembersCount(_idGrp_UAN_Plain_09)==2 then
				return true
    end
 
    return false
end


function ExpAI_O_Goto_Waypoint_Grp_UAN_Plain_2()
    if _bPontE1 or _bPontE3 or _bPontE5 then
				return true
    end
 
    return false
end


function ExpAI_O_Goto_Waypoint_Grp_UAN_Plain_3()
    if _bPontE3 or _bPontE5 then
				return true
    end
 
    return false
end


function ExpAI_O_Goto_Waypoint_Grp_UAN_Plain_4_5_6()
    if _bPontE5 then
				return true
    end
 
    return false
end

--------------------- Fonctions diverses -------------------------------

_bGrpUAN_08=false

function RenfortPlace()
--		if _bPontRenfort and _nBotActive<=7 and not _bGrpUAN_08 and not _bSE_Plain_F_10 then
--				FreezeAll(_idGrp_UAN_Plain_08,false)				
--				_bGrpUAN_08=true
--		end
		if _bPontRenfort and _nBotActive<=7 and not _bGrpUAN_07 then --[[and _bGrpUAN_08--]]
			--	FreezeAll(_idGrp_UAN_Plain_07,false)				
				_bGrpUAN_07=true
		end
end


function RenfortFin()
		if not _bPlainTank3 and _nBotActive<=6  and _bPlainTank2 then
				FreezeAll(_idGrp_UAN_Plain_13,false)				
				_bPlainTank3=true
		end
		if not _bPlainTank2 and _nBotActive<=6  and _bPlainTank and AliveMembersCountPct(_idGrp_UAN_Plain_11)<=90 then
				FreezeAll(_idGrp_UAN_Plain_12,false)				
				_bPlainTank2=true
		end
end


-- Retourne si le TankA est détruit
function TankA()
		_nHealthTank_1 = GetVarValue(GetTankID("Tank_1"),"Health")
		_nHealthTank_2 = GetVarValue(GetTankID("Tank_2"),"Health")

		if (_nHealthTank_1 == 0) and (_nHealthTank_2 == 0) then
					return true
		else
					return false
		end
end


function TankKO()
		_nHealthTank_1 = GetVarValue(GetTankID("Tank_1"),"Health")
		_nHealthTank_2 = GetVarValue(GetTankID("Tank_2"),"Health")

		if ((_nHealthTank_1 == 0) and (_bCtrlTank1KO == false)) then
			MiniMapTrack(GetTankID("Tank_1"),2,false)
			_bCtrlTank1KO = true
		end
		if ((_nHealthTank_2 == 0) and (_bCtrlTank2KO == false)) then
			MiniMapTrack(GetTankID("Tank_2"),2,false)
			_bCtrlTank2KO = true
		end
		if ((_nHealthTank_1 == 0) and (_nHealthTank_2 == 0) and (_bCtrlTank3KO == false)) then
	--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
 -- 	PauseMusic()
 		StopMusic()
 	--	StartMusic()
			ObjectiveDoneNewObjectiveNewSubObjective("Obj_D", "Obj_E", "Obj_E_1" )
			SetVarValue(GetObjectiveID("Obj_E_2"),"Active",true)
			_bTankIsDestroyed = true
			_bCtrlTank3KO = true
		end
end


function OnEnter_SE_Tanks_Death(id)
	if (id==_idPlayer) then
		if (_bTankIsDestroyed == false) then
			DamageCharacter(_idPlayer,10000)
		end
	end
end