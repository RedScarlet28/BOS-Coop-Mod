function InitLevel_Trench_1()
end

_bFctScenarAppel_Trench_1 = false

function UpdateLevel_Trench_1()
	Change_Bot_behavior ("Char_UAN_Trench_1_05_1",90,60,"AIOL_FA_Player")
	Change_Bot_behavior ("Char_UAN_Trench_1_05_2",90,60,"AIOL_FA_Player")
	Defreeze_Grp_UAN_Trench_1_3()

-- si on a pas deja appellé la fct
		if ( _bFctScenarAppel_Trench_1 == false ) then
 		-- est que les 2 persos sont present dans la boite à cette frame
    		if  IsEntityInBox(_idPlayer, "SE_Trench_1_A_01") and (IsEntityInBox(_idChar_WRF_Camp_1_1, "SE_Trench_1_A_01") or IsEntityInBox(_idChar_WRF_Camp_1_Garde, "SE_Trench_1_A_01")) then
      		      FctScenar_Trench_1()         -- on appelle	
    		        _bFctScenarAppel_Trench_1 = true      -- on met le flag a true pour ne plus rappeller
  		  end
		end
end

------------------ Fonctions relatives au Sector Events ------------------


function OnEnter_SE_Trench_1_Survivant(_idSE_Trench_1_Survivant)
		if (_idSE_Trench_1_Survivant==_idPlayer) then

-- Freeze Camp_1---------------------------		
				FreezeAll(_idGrp_WRF_Camp_1_1,true)
				if IsAlive(_idChar_WRF_Camp_1_Garde) then
						Freeze(_idChar_WRF_Camp_1_Garde,false)
				end
				FreezeAll(_idGrp_WRF_Camp_1_2,true)
				FreezeAll(_idGrp_WRF_Camp_1_3,true)
				FreezeAll(_idGrp_WRF_Camp_1_4,true)
				FreezeAll(_idGrp_WRF_Camp_1_5,true)

				Freeze(_idChar_WRF_Camp_1_02_1,true)
				Freeze(_idChar_WRF_Camp_1_02_2,true)
				Freeze(_idChar_WRF_Camp_1_02_3,true)

-- DeFreeze Trench_1---------------------------	

		end
end


function OnEnter_SE_Trench_1_A_01(_idSE_Trench_1_A_01)
		if (_idSE_Trench_1_A_01==_idPlayer) and (not _bDejaSorti) then
			FreezeAll(_idGrp_UAN_Trench_1_2,false)
			_bDejaSorti=true
		end
end


function OnEnter_SE_Trench_1_B_02(_idSE_Trench_1_B_02)
		if (_idSE_Trench_1_B_02==_idPlayer) and not _bDeja_Defreeze3 then
				FreezeAll(_idGrp_UAN_Trench_1_3,false)
				_bDeja_Defreeze3=true
		end
		if (_idSE_Trench_1_B_02==_idPlayer) and not _bDefreezeWRF_1 then
				_bDefreezeWRF_1=true
		end
end


function OnEnter_SE_Trench_1_B_01(_idSE_Trench_1_B_01)
		if _idSE_Trench_1_B_01==_idPlayer and not _bDeja_Defreeze2 then
				FreezeAll(_idGrp_UAN_Trench_1_4,false)
				_bDeja_Defreeze2=true
		end
end


function OnEnter_SE_Trench_1_B_03(_idSE_Trench_1_B_03)
		if _idSE_Trench_1_B_03==_idPlayer and not _bDeja_Defreeze4 then
				FreezeAll(_idGrp_UAN_Trench_1_5,false)
				_bDeja_Defreeze4=true
		end
end


function OnEnter_SE_Trench_1_B_04(_idSE_Trench_1_B_04)
		if _idSE_Trench_1_B_04==_idPlayer and not _bDeja_Defreeze5 then
				FreezeAll(_idGrp_UAN_Trench_1_6,false)
				_bDeja_Defreeze5=true
		end
end


function OnEnter_SE_Trench_1_T_01(_idSE_Trench_1_T_01)
		if _idSE_Trench_1_T_01==_idPlayer and not _bDeja_Teleport then
--[[
				-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
				if (_idMerc[0] ~= nil) then 

						if (GetVarValue(_idMerc[0],"Health")~=0) then
								SetVarValue(_idMerc[0],"Position",GetVarValue(_idWaypoint_Trench_1_Teleportation1,"Position"))
						end
				end

				-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
				if (_idMerc[1] ~= nil) then 

						if (GetVarValue(_idMerc[1],"Health")~=0) then
								SetVarValue(_idMerc[1],"Position",GetVarValue(_idWaypoint_Trench_1_Teleportation2,"Position"))
						end
				end
--]]
				StopMusic()
				FreezeAll(_idGrp_UAN_Trench_1_1,true)
				FreezeAll(_idGrp_UAN_Trench_1_2,true)
				FreezeAll(_idGrp_UAN_Trench_1_3,true)
				FreezeAll(_idGrp_UAN_Trench_1_4,true)
				FreezeAll(_idGrp_UAN_Trench_1_5,true)
				FreezeAll(_idGrp_UAN_Trench_1_6,true)
				_bDeja_Teleport=true
		end
end


function OnStay_SE_Trench_1_F_01(_idSE_Trench_1_F_01)
		if (_idSE_Trench_1_F_01==_idChar_WRF_Trench_2_02_1 or _idSE_Trench_1_F_01==_idChar_WRF_Trench_2_02_2 or _idSE_Trench_1_F_01==_idChar_WRF_Trench_2_1
		or _idSE_Trench_1_F_01==_idChar_WRF_Trench_2_03_1 or _idSE_Trench_1_F_01==_idChar_WRF_Trench_2_03_2 or _idSE_Trench_1_F_01==_idChar_WRF_Trench_2_03_3)
 		and not IsEntityInBox(_idPlayer,"SE_Trench_1_F_02") then 
				Freeze(_idSE_Trench_1_F_01,true)
		end
end

--------------------- Fonctions d'expiration d'ordres --------------------

function ExpGotoTrench_1(idChar)
		if _bFctScenarAppel_Trench_1 then
				return true
		end
		return false
end

-------------------------- Fonctions diverses ----------------------------

function Defreeze_Grp_UAN_Trench_1_3()
		if AliveMembersCountPct(_idGrp_UAN_Trench_1_2)<=50 and not _bDeja_Defreeze3 then
				FreezeAll(_idGrp_UAN_Trench_1_3,false)
				_bDeja_Defreeze3=true
		end
end


function FctScenar_Trench_1()
--		DisplaySubtitle("DIA_GEN_WRF_69",2,5)
		if IsAlive(_idChar_WRF_Camp_1_1) or IsAlive(_idChar_WRF_Camp_1_Garde) then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Garde,_idPlayer,"DIA_GEN_DO_GO_GO_TEAM_A_VOICE_A_1",true,110,2,1,"",100)
		end

end

