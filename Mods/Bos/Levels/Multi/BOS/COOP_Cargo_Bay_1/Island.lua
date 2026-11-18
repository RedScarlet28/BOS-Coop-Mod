
function InitLevel_Island()
		_nNbGrp3_UAN_Plain=1
		_nNbGrp4_UAN_Plain=1
		_nNbGrp5_UAN_Plain=2
		_bCtrlSE_island_Dca_6 = true
		_bCtrlSE_island_Dca_7 = false
		_bDCA1_1CineA = false
		_bDCA1_1CineB = false
		_bCtrlSE_island_Dca_6a = false
		_bIsDestroyedDCA1 = false
		_bCtrlXplDCA1 = false
		_bCtrlCamTransDCA1_1 = false
		_bCtrlAI_O_List_Ingenieur = false
	--	UnLockDoor(GetDoorID("Door_Ponton_1"))
	--	OpenDoor(GetDoorID("Door_Ponton_1"))
	--	UnLockDoor(GetDoorID("Door_BoS_Island1"))
	--	UnLockDoor(GetDoorID("Door_BoS_Island2"))
	--	OpenDoor(GetDoorID("Door_BoS_Island1"))
	--	OpenDoor(GetDoorID("Door_BoS_Island2"))
	_bCtrlBoSEnCoursB = false
	_bCtrlDejaJoue1B = false
	_bExoInBox = false
end

function UpdateLevel_Island()

		CleanUpDca1()
		RenfortPont()
--    BOS2()
		HelpDca2()
		IslandFollowPlayer()
		--IngeDca()
		SafeIsland()
		Pression()
		TrackingCamTransDCA1_6()
--		TrackingCamTransDCA1_7()
		TestXplDCA1()
		TestPlayerExoDuringBoSIsland()
end


------------------------------ Fonctions relatives au Sector Events ----------------------------------


------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_01

Déclenche les hostilités sur la place de l'"île" en défreezant les groupes 3,4 et 5. L'ingénieur se
stoppe en attendant que la place soit hors de danger. Le mercenaire, lui descend de l'exo pour vous aider
à faire le ménage.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_01(_idSE_island_F_01)

		if (_idPlayer==_idSE_island_F_01) and not _bIsland1 then
				FreezeAll(GetGroupID("Grp_UAN_Island_03"),false)
				FreezeAll(GetGroupID("Grp_UAN_Island_04"),false)
				FreezeAll(GetGroupID("Grp_UAN_Island_05"),false)
				_bIsland1=true
		end

end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_02

--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_02(_idSE_island_F_02)

		if ((_idChar_Ingenieur ~= nil) and (_idSE_island_F_02==_idPlayer) and (_bCtrlAI_O_List_Ingenieur == false)) then
				SetVarValue(_idChar_Ingenieur,"CharacterOrderList",_idAI_O_List_Ingenieur)
				_bCtrlAI_O_List_Ingenieur = true
		end

end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_03

--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_03(_idSE_island_F_03)
		if (_idPlayer==_idSE_island_F_03) and not _bIsland3 then		
				_bIsland3=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_04

On freeze les groupes qui ne sont plus à porter de vue, et on augmente la priorité de l'ordre
"AI_O_Goto_Waypoint_UAN_Plain_1" pour ensuite freezés les bots qui auront accédé au waypoint
(Waypoint_Plain_1).
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_04(_idSE_island_F_04)
		if (_idPlayer==_idSE_island_F_04) then
--				FreezeAll(GetGroupID("Grp_UAN_Bunker_01"),true)	
--				FreezeAll(_idGrp_UAN_Plain_01,true)
--				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Plain_1"),"PriorityLegs",100)
--				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_UAN_Plain_1"),"PriorityTorso",100)
				_bPlain09=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_05

Déclenche les hostilités sur la place de la première DCA en défreezant le groupes 6, dans le cas où le
joueur ou l'ingénieur pénètre dans l'event box. 
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_05(_idSE_island_F_05)
		if (_idChar_Ingenieur==_idSE_island_F_05) or (_idPlayer==_idSE_island_F_05) and not _bIsland6 then		
				FreezeAll(_idGrp_UAN_Island_06,false)
				_bIsland6=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_06

Défreeze seulement le groupe 2 situé dans la montée à la DCA.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_06(_idSE_island_F_06)
		if (_idPlayer==_idSE_island_F_06) and not _bPont then		
				FreezeAll(GetGroupID("Grp_UAN_Island_02"),false)	
				_bPont=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_F_07

Défreeze les bots du groupe 7 situé dans partie opposée à l'arrivée du joueur par la montée. Freeze
du même coup les bots croisés dans la montée de l'ile s'ils n'ont pas été éliminés par le PJ. 
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_F_07(_idSE_island_F_07)
		if (_idPlayer==_idSE_island_F_07) and not _bBunker2 then		
				FreezeAll(_idGrp_UAN_Island_07,false)
				FreezeAll(_idGrp_UAN_Island_01,true)
				_bBunker2=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_Dca_1
C'est la zone dans laquelle il va poser ses charges. Cela déclenche un timer correspondant au temps de 
pause de l'ingénieur. Une fois les charges posées, il se casse.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_Dca_1(_idSE_island_Dca_1)
		if (_idChar_Ingenieur==_idSE_island_Dca_1) and not _bIsland5 then
		-- Timer correspondant au temps mis par l'ingénieur pour poser les charges explosives.		
				SetVarValue(GetTimerID("Timer_Island_Ingenieur"),"Active",true)
				_bIsland5=true
			--	CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE EXPLOSIV_FRONT W_NONE",false,false)
		--		CreationTimer(true, true, false, "PlantBomb",3)	
		end
end

function TimerPlantBomb()
				CreationTimer(true, true, false, "PlantBomb",3)	
end

function PlantBomb()
	PlantExplosive(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"))
end

function OnEnter_SE_island_Dca_6(id)
	if ((id == _idMerc[0]) and (_bCtrlSE_island_Dca_6 == false)) then
		BoomDca1()
--		SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"), "Active",false)
		_bCtrlSE_island_Dca_6 = true
	end

	if ((id == _idMerc[0]) and (_bCtrlSE_island_Dca_6a == false)) then
		CamTransDCA1_5() 
		_bCtrlSE_island_Dca_6a = true
	end
end

function OnEnter_SE_island_Dca_7(id)
	if ((id == _idMerc[0]) and (_bCtrlSE_island_Dca_7 == false)) then
		CamTransDCA1_3()
		_bCtrlSE_island_Dca_7 = true
	end
end

------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_Dca_2

Cette zone sert surtout à l'ordre forbid zone "AI_O_Forbid_Zone_Dca1" lorsque le compte à rebours
de l'explosion de la DCA sera en marche. Elle permet aussi de défreezé les snipers de l'autre coté du
pont (Grp_UAN_Plain_14).
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_Dca_2(_idSE_island_Dca_2)
		if (_idSE_island_Dca_2==_idPlayer) and not _bDca_2 then
		--		FreezeAll(_idGrp_UAN_Plain_14,false)		
				_bDca_2=true	
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_Dca_3

Défreeze un bot ingénieur ennemi, qui demande à avoir la vie sauve.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_Dca_3(_idSE_island_Dca_3)
		if (_idPlayer==_idSE_island_Dca_3) and not _bDca3 then
				--Freeze(GetCharacterID("Char_UAN_Island_2"),false)
				_bDca3=true
		end
end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_Dca_4

L'ingénieur a quitté la zone de la Dca aprés avoir posé ses charges (_bFuite), on lui attibut une 
nouvelle order list pour qu'il resuive le joueur.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_Dca_4(_idSE_island_Dca_4)
		if (_idPlayer == _idSE_island_Dca_4) then
			_bCall=true
		end
		if (_idChar_Ingenieur==_idSE_island_Dca_4) and not _bDca4 and _bFuite then
-- L'ingénieur reprend son ancien Order List pour resuivre le joueur.
			--	SetVarValue(_idChar_Ingenieur,"CharacterOrderList",_idAI_O_List_Ingenieur)
	--	SetVarValue(_idMerc[0], "CharacterOrderList", GetInvalidEntityID())
				_bDca4=true
		end

end



------------------------------------------------------------------------------------------------------
--[[																	OnEnter_SE_island_Dca_5

L'ingénieur s'est dirigé seul vers la place de la DCA, il demande maintenant l'aide du joueur 
avant de débarquer sur la place où l'attendent de gentils bots UAN.
--]]
------------------------------------------------------------------------------------------------------

function OnEnter_SE_island_Dca_5(_idSE_island_Dca_5)
		if (_idPlayer==_idSE_island_Dca_5) and not _bIsland3 then				
				_bIsland3=true
		end
		if (_idChar_Ingenieur ~= nil) and (_idChar_Ingenieur==_idSE_island_Dca_5) and not _bCall then				
			--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_14",true,110,2,2,"",2)
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_14",true,110,4,"")		
		_bCall=true
		end
end



function OnStay_SE_island_BOS_01(_idSE_island_BOS_01)
		if (_idSE_island_BOS_01==_idPlayer) and _bDCA1_Safe and not _bIslandBOS then
--				DefreezeChp_Island()
				_bIslandBOS=true
		end
end



function LaunchBoSIsland()
				if (_idChampion_1 ~= nil) then
						DefreezeChp_Island()
						Teletransportation("Repere_Player1",_idPlayer)
						EnableCharacterCommand(_idPlayer,false)
						if (_idMerc[0] ~= nil) then
								EnableCharacterCommand(_idMerc[0],false)
								Teletransportation("Repere_Merc2",_idMerc[0])
						end
						LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_6"))
		StopMusic()
		StartMusic("Sounds//Music//Bos - War theme.wav", true)
 -- 	PauseMusic()
 --		StopMusic()
 	--	StartMusic()
				end
		_bIslandBOS2=true
end

function TestXplDCA1()
	_bIsDestroyedDCA1 = GetVarValue(GetDestructible_ObjectID("Destructible_Object_DCA_1"),"Destroyed")
	if((_bIsDestroyedDCA1 == true) and (_bCtrlXplDCA1 == false)) then
		CreationTimer(true, true, false, "LaunchBoSIsland",2)
		_bCtrlXplDCA1 = true
	end
end
---------------------------------- Fonctions d'expiration d'ordres -----------------------------------


function ExpirationGotoBOSWarningIsland(idCharacter1)

    if BetIsInCombat() then		
				return true
		end
		return false

end


------------------------------------------------------------------------------------------------------
--[[																	ExpirationFollowPlayer

Fonction qui romp l'ordre du Follow Player pour que l'ingénieur aille
poser les charges explosives de lui même. Evite que le joueur aie à revenir
dans le coin parce qu'il a oublié une Dca.
--]]
-----------------------------------------------------------------------------------------------------

function ExpirationFollowPlayer(idCharacter1)
    if  (( idCharacter1 == _idChar_Ingenieur ) and _bIsland3 and (not _bBoom) and (not _bDca_01)) then
    		_bDca_01=true			
				return true
		end
		
		if  (( idCharacter1 == _idChar_Ingenieur ) and _bExoDca and (not _bBoom2) and (not _bDca_02)) then
	    	_bDca_02=true
				return true
    end
 
    return false
end



------------------------------------------------------------------------------------------------------
--[[																	ExpirationForbidZone

Lors du compte à rebours de l'explosion, la Forbid Zone SE_island_Dca_2 devient
active, et tous les bots fuient donc l'imminente explosion. Une fois les charges
explosées, l'Order Forbid-Zone est annulé.
--]]
------------------------------------------------------------------------------------------------------

function ExpirationForbidZone(idCharacter2)
    if _bBoom then
        return true
    end
 
    return false
end



function ExpirationGotoBOSIsland(idCharacter2)
    if _bStartBoSIsland then
        return true
    end
 
    return false
end



function ExpirationLimitZone(idCharacter3)
    if (AliveMembersCount(_idGrp_UAN_Island_06)<=2) and ((idCharacter3==GetCharacterID("Char_UAN_Island_06_5")) or (idCharacter3==GetCharacterID("Char_UAN_Island_06_3"))) then
        return true
    end
 
    return false
end



------------------------------------------------------------------------------------------------------
--[[													ExpAI_O_Goto_Waypoint_Char_Ingenieur_1_Island_1

Signifie que le joueur a nettoyé la zone de la Dca n°1, et donc que l'ingénieur
peut aller poser les charges en toute tranquilité.
--]]
------------------------------------------------------------------------------------------------------

function ExpAI_O_Goto_Waypoint_Char_Ingenieur_1_Island_1()
    if (_idChar_Ingenieur ~= nil) and _bIsland6 and (AliveMembersCount(_idGrp_UAN_Island_06)==0) and not IsAlive(_idChar_UAN_Island_1) then	
--				SetVarValue(GetTimerID("Timer_Objective_Cargo_Bay_2_2"),"Active",true)
		--		NewSubObjective ( "Obj_A_2", "Obj_A_4")
				if (_bCtrlCamTransDCA1_1 == false) then
					CreationTimer(true, true, false, "CamTransDCA1_1",3)
				--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_15",true,110,2,2,"",2)
					RadioMessage("DIA_SPE_NIV_H_INGENIEUR_15",true,110,2,"")
					_bDCA1_Safe=true
					_bCtrlCamTransDCA1_1 = true
				end

        return true
    end
 
    return false
end

-------------------------------------- Fonctions diverses -------------------------------------------



------------------------------------------------------------------------------------------------------
--[[																			FollowPlayer

Compte à rebours de l'explosion, tous le monde fuient la zone, du à l'activation
de l'Order_Forbid_Zone_Dca1.
--]]
------------------------------------------------------------------------------------------------------

function FollowPlayer()

		_bFuite=true
		if (_idChar_Ingenieur ~= nil) then
				CharacterStopSpecialAction(_idMerc[0])
			--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_16",true,110,2,2,"",2)
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_16",true,110,2,"")
		end


-- Activation de l'Order_Forbid_Zone_Dca1.		
		SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Dca1"),"PriorityLegs",100)
-- Activation du compte à rebours retranscrit par le Timer_Island_Dca1.

		SetVarValue(_idMerc[0], "CharacterOrderList",GetAI_Order_ListID("AIOL_DCA1_Inge_fuite"))
		_bCtrlSE_island_Dca_6 = false
end



------------------------------------------------------------------------------------------------------
--[[																			BoomDca1

Explosion de la première Dca.
--]]
------------------------------------------------------------------------------------------------------

function BoomDca1()
		_bBoom=true  -- Indique que l'explosion a eu lieu

-- Explosions

		SetVarValue(GetSound_ClientID("Sound_Client_Dca_Island"),"Playing",true)
		SetVarValue(_idMerc[0], "CharacterOrderList", GetInvalidEntityID())
		SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"),"Explosion Delay",0)
		SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"),"Active",false)
		CreationTimer(true, true, false, "Destroy_DCA1",0)
		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_DCA_Xpl1"),"FxState","Fx Started")

		SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_dca1"),"FxState","Fx Started")
		SetVarValue(GetSound_ClientID("Sound_Client-490"),"Playing",true)
		CameraShake(1.0, 0.7, 0.7, 0.7)
end

function Destroy_DCA1()
		SetVarValue(GetDestructible_ObjectID("Destructible_Object_DCA_1"),"Destroyed",true)

end


function CleanUpDca1()
		if _bIsland3 and not _bDcaNotClean then		
				SetVarValue(GetTimerID("Timer_Island_Help"),"Active",true)	
				Freeze(_idChar_UAN_Island_1,false)
				_bDcaNotClean=true			
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



function HelpDca1()
		if (_idChar_Ingenieur ~= nil) and ((AliveMembersCount(_idGrp_UAN_Island_06)>0) or IsAlive(_idChar_UAN_Island_1)) and _bIsland3 and not _bHelp then
			--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_17",true,110,2,2,"",2)	
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_17",true,110,2,"")
				_bHelp=true			
		end

end



function HelpDca2()

		if (_idChar_Ingenieur ~= nil) and CharacterCanFeelDamage(_idChar_Ingenieur,_idChar_UAN_Island_1) and not _bHelp2 then
				MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_18",true,110,2,2,"",2)		
				_bHelp2=true			
		end
end




function RenfortPont()
		if _bBOS2 and not _bRenfort then	-- Signifie que le BOS a déjà eu lieu	
				if _bPontZone4 then	

				elseif _bPontZone3 then
				elseif _bPontZone2 then
						FreezeAll(_idGrp_UAN_Plain_04,false)
				elseif _bPontZone1 then			

				elseif _bPontLibre then

				end

		_bRenfort=true		
		end
end


function DefreezeChp_Island()
-- Mode B.O.S
--		Freeze(GetCharacterID(_stChp_Island),false)

		if not _bChp_Island_defreeze then
------------------ B.O.S ----------------------------
--				DisplaySubtitle ("B.o.S n°2", 2, 4 )
				if (_idChampion_1 ~= nil) then 

-- Défrise le Champion sélectionné
							Freeze(_idChampion_1, false)
	--	SetVarValue(GetExposive_Plant_SiteID("Exposive_Plant_Site-15"),"Active",false)


-- Déclare que le Champion est défrisé
							_bChp_Island_defreeze = true
				end
		end

end



------------------------------------------------------------------------------------------------------
--[[																	BOS2()

Fonction appelée aprés le BOS. Récupère la dernière position du Player pour défreezer en fonction les bots.
Ne sera peut être pas necessaire à la fin.
--]]
------------------------------------------------------------------------------------------------------

function BOS2()

		if not _bBOS2 then

		UnLockDoor(GetDoorID("Door_Ponton_1"))
		OpenDoor(GetDoorID("Door_Ponton_1"))
		Freeze(_idChampion_1,true)
		g_bBoSEnCours = false
		_bCtrlBoSEnCoursB = false

			if (_idChar_Merc ~= nil) then
					EnableCharacterCommand(_idChar_Merc,true)
			end
			if (_idChar_Ingenieur ~= nil) then
					EnableCharacterCommand(_idChar_Ingenieur,true)
			end
			EnableCharacterCommand(GetCharacterID("Char_UAN_Plain_14_1"),true)
			EnableCharacterCommand(GetCharacterID("Char_UAN_Plain_14_2"),true)

			_bBOS2=true  -- Le BOS est terminé

			SetVarValue(GetTimerID("Timer_Island_Dca2"),"Active",true)
			SetVarValue(GetTimerID("Timer_Island_Pression"),"Active",true)

-- On récupère la dernière position du Player.	
			if IsEntityInBox(_idPlayer,"SE_Plain_P_01") then
					_bPontZone1=true

			elseif IsEntityInBox(_idPlayer,"SE_Plain_P_02") then
					_bPontZone2=true
	
			elseif IsEntityInBox(_idPlayer,"SE_Plain_P_03") then
					_bPontZone3=true

			elseif IsEntityInBox(_idPlayer,"SE_island_LZ_03") then
					_bPontZone4=true

			else 
					_bPontLibre=true
			end
				FreezeAll(_idGrp_UAN_Plain_14,false)	
		end

		ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_C", "Obj_C_1" )
		SetVarValue(GetObjectiveID("Obj_C_3"),"Active",true)
end




------------------------------------------------------------------------------------------------------
--[[																	IslandFollowPlayer()

Redonne une nouvelle order list à l'ingénieur pour qu'il suive à nouveau le joueur jusqu'à la seconde
DCA. Ceci une fois que la première DCA est explosée (_bBoom).
Tourne en permanence dans l'UpdateLevel. 
--]]
------------------------------------------------------------------------------------------------------

function IslandFollowPlayer()

		if (_idChar_Ingenieur ~= nil) and _bBoom and not _bDca4 then	
				_bDca4=true
		end

end



------------------------------------------------------------------------------------------------------
--[[																	Bunker()

Tourne en permanence dans l'UpdateLevel. 
--]]
------------------------------------------------------------------------------------------------------

function Bunker()

		if _nBotActive<=6 and _bBunker2 then
--				FreezeAll(_idGrp_UAN_Island_08,false)				
		end
end



function DialMercDca1()
		if (_idChar_Ingenieur ~= nil) then
			--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_04",true,110,2,2,"",2)
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_04",true,110,4,"")
		end
end

function DialMercDca3()
		if (_idChar_Ingenieur ~= nil) then
			--	MakeCharacterSpeak(_idChar_Ingenieur,_idPlayer,"DIA_SPE_NIV_H_INGENIEUR_30",true,110,2,2,"",2)
				RadioMessage("DIA_SPE_NIV_H_INGENIEUR_30",true,110,4,"")
		end
end

function IngeDca()

		-- _bPP_30: Booléen qui renvoie true si le joueur et Char_UAN_Island_1 sont à 3m l'un de l'autre.
		_bPlayer_Island_30=Perimeter_Player(_idPlayer, _idChar_UAN_Island_2,30)
		if (_idChar_Ingenieur ~= nil) then
				_bInge_Island_30=Perimeter_Player(_idChar_Ingenieur, _idChar_UAN_Island_2,30)
		end
		if (_idChar_Merc ~= nil) then
				_bMerc_Island_30=Perimeter_Player(_idChar_Merc, _idChar_UAN_Island_2,30)
		end
		if not IsFrozen(_idChar_UAN_Island_2) and (_bPlayer_Island_30 or _bInge_Island_30 or _bMerc_Island_30) then
				MakeCharacterSpeak(_idChar_UAN_Island_2,GetInvalidEntityID(),"DIA_SPE_NIV_H_UAN_G_01",true,110,2,1,"",2)
		end 	

end



-----------------------------------------------------------------------------------------------------
--[[																		SafeIsland()

Teste si la zone Island est sécurisée. On baisse certaines priorité pour que l'ingénieur rejoigne le
Player.
Tourne en permanence dans l'UpdateLevel. 
--]]
-----------------------------------------------------------------------------------------------------

function SafeIsland()

		if (AliveMembersCount(_idGrp_UAN_Island_05) + AliveMembersCount(_idGrp_UAN_Island_04) + AliveMembersCount(_idGrp_UAN_Island_03) + AliveMembersCount(_idGrp_UAN_Island_02))<=1 
		and not _bSafeIsland then
				SetVarValue(_idAI_O_GW_Char_Ingenieur_Island_3,	"PriorityTorso", 0)
				SetVarValue(_idAI_O_GW_Char_Ingenieur_Island_3,	"PriorityLegs", 0)

				_bSafeIsland=true
		end

end



-----------------------------------------------------------------------------------------------------
--[[																		Pression()

Va faire spawner, presque à l'infini, des bots UAN pour forcer le joueur à traverser le pont 
rapidement sans vouloir trop les shooter de loin.
Tourne en permanence dans l'UpdateLevel. 
--]]
-----------------------------------------------------------------------------------------------------

function Pression()

		if not _bPlace then

		end

end



-----------------------------------------------------------------------------------------------------
--[[																		PressionExo()

Va faire spawner des Exos UAN pour forcer le joueur à traverser le pont rapidement et lui mettre la 
pression. 
--]]
-----------------------------------------------------------------------------------------------------

function PressionExo()
		
end



-----------------------------------------------------------------------------------------------------
--[[																		LaunchBOSIsland()

Lance la séquence d'introduction du B.O.S sur Island.
--]]
-----------------------------------------------------------------------------------------------------

function LaunchBOSIsland()
	-- Lance la séquence d'introduction du B.O.S

		StopMusic()
		LaunchBOS(1,"SetUp", "WarmUp","Combat","BOS2", "BoS_Lost", "BOS2")
		CineDCA1_End()
		_bStartBoSIsland=true	
		SetGodMode(_idChampion_1,true)
end

function SetUp()
--		CloseDoor(GetDoorID("Door_BoS_Island1"))
--		CloseDoor(GetDoorID("Door_BoS_Island2"))
--		LockDoor(GetDoorID("Door_BoS_Island1"))
--		LockDoor(GetDoorID("Door_BoS_Island2"))
--		LockDoor(GetDoorID("Door_Ponton_1"))
--		CloseDoor(GetDoorID("Door_Ponton_1"))
end

function WarmUp()
	_bCtrlBoSEnCoursB = true
	EnableCharacterCommand(_idPlayer,true)
	EnableCharacterFire(_idPlayer,false)
	EnableCharacterFire(_idChampion_1,false)
	EnableCharacterCommand(_idChampion_1,false)
	if (_idChampion_1 == GetCharacterID("Char_Champion_1_1")) then
		SetVarValue(_idChampion_1,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_1_1"))
	end
	if (_idChampion_1 == GetCharacterID("Char_Champion_1_2")) then
		SetVarValue(_idChampion_1,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_1_2"))
	end
	if (_idChampion_1 == GetCharacterID("Char_Champion_1_3")) then
		SetVarValue(_idChampion_1,"CharacterAI",GetCharacter_AIID("Patrol_Char_AI_Champion_1_3"))
	end
end

function Combat()
	g_bBoSEnCours = true
	SetGodMode(_idChampion_1,false)
	EnableCharacterFire(_idPlayer,true)
	EnableCharacterFire(_idChampion_1,true)
	EnableCharacterCommand(_idChampion_1,true)
end

function BoS_Lost()
	if (g_bBoSEnCours == true) then
		MissionFailed("HUD_MISSION_FAILED_REASON_01")
	end
end


function TestPlayerExoDuringBoSIsland()
		_bIsPlayerInExoB = IsAValidID(GetCharacterCurrentExoskeleton(_idPlayer))

	if (_bCtrlBoSEnCoursB == true) then

		if ((_bIsPlayerInExoB == true) and (_bCtrlDejaJoue1B == false)) then
			SetVarValue(_idChampion_1, "CharacterOrderList", GetAI_Order_ListID("AIOL_Path_BOS_Island"))
			EnableCharacterCommand(_idChampion_1,true)
			
			_bCtrlDejaJoue1B = true
		elseif ((_bIsPlayerInExoB == false) and (_bCtrlDejaJoue1B == true)) then
			if (_idChampion_1 == GetCharacterID("Char_Champion_1_2")) then
				SetVarValue(_idChampion_1, "CharacterOrderList", GetAI_Order_ListID("AI_O_List_Char_Champion_1_2"))
			end

			if (_idChampion_1 == GetCharacterID("Char_Champion_1_1")) then
				SetVarValue(_idChampion_1, "CharacterOrderList", GetAI_Order_ListID("AI_O_List_Char_Champion_1_1"))
			end

			if (_idChampion_1 == GetCharacterID("Char_Champion_1_3")) then
				SetVarValue(_idChampion_1, "CharacterOrderList", GetAI_Order_ListID("AI_O_List_Char_Champion_1_3"))
			end
			_bCtrlDejaJoue1B = false
		end		
	end
end

function OnEnter_SE_island_Security_Exo(id)
	if (id == _idPlayer) and (_bIsPlayerInExoB == true) then
			_bExoInBox = true
	end
end

function OnExit_SE_island_Security_Exo(id)
	if (id == _idPlayer) and (_bIsPlayerInExoB == true) then
			_bExoInBox = false
	end
end

-----------------------------------------------------------------------------------------------------
--[[																		Objective_Cargo_Bay_2_2_Active()

Affiche que les objectifs sont updatés aprés que le joueur aie néttoyé la Dca.
Lancée par le timer du même nom.
--]]
-----------------------------------------------------------------------------------------------------

function Objective_Cargo_Bay_2_2_Active()

--		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Cargo_Bay_2_2"), 4, 5 )

end



-----------------------------------------------------------------------------------------------------
--[[																		Objective_Cargo_Bay_3_1_Active()

Lancée par le timer du même nom.
--]]
-----------------------------------------------------------------------------------------------------

function Objective_Cargo_Bay_3_1_Active()

--		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Cargo_Bay_3_1"), 4, 5 )

end


-----------------------------------------------------------
--[[ Cinématiques --]]

function CamTransDCA1_1()
		if (_bExoInBox == true) then
		--	_vPosExo = GetVarValue(GetExoskeletonID("Repere_Exo"), "Position")
			SetVarValue(GetExoskeletonID("Exo_Camp2"), "Position",Vector3D(2130.0,-3117.0,232.0))
		--	_vRotExo = GetVarValue(GetExoskeletonID("Repere_Exo"), "Rotation")	
			SetVarValue(GetExoskeletonID("Exo_Camp2"), "Rotation",Vector3D(0.0,1.8,-2.9))
		end

		Teletransportation("Repere_Player2",_idPlayer)
		if (_idMerc[1] ~= nil) then
				EnableCharacterCommand(_idMerc[1],false)
				Teletransportation("Repere_Merc3",_idMerc[1])
		end
		if (_idMerc[0] ~= nil) then
		--		EnableCharacterCommand(_idMerc[0],false)
				Teletransportation("Repere_Merc6",_idMerc[0])
		end

		ShowCinematicBlackStripes(true)
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_1"))
end

function CamTransDCA1_2()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_2"))
end

function CamTransDCA1_3()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_3"))
end

function CamTransDCA1_4()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_4"))
end

function CamTransDCA1_5()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_5"))
		_bDCA1_1CineA = true
end

function CamTransDCA1_7()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_DCA1_7"))
		_bDCA1_1CineB = true
end
function CamTrans_Island_BOS_1()
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Island_BOS_1"))
		CreationTimer(true, true, false, "ActiveShieldBoSIsland",2)
		_bDCA1_1CineA = false
end

function ActiveShieldBoSIsland()
	if (_idChampion_1 == GetCharacterID("Char_Champion_1_1")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_1_1"),"Active",true)
	end
	if (_idChampion_1 == GetCharacterID("Char_Champion_1_3")) then
		SetVarValue(GetPlug_MagneticShieldID("Plug_MagneticShield_Champion_1_3"),"Active",true)
		SetVarValue(GetPlug_PulseID("Plug_Pulse_Champion_1_3"),"Active",true)
	end
end

function TrackingCamTransDCA1_6()
	if (_bDCA1_1CineA == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_DCA1_6"),_idChampion_1)
	end
end

function TrackingCamTransDCA1_7()
	if (_bDCA1_1CineB == true) then
		CamPointTargetCharacter(GetCamPointID("CamPoint_Island_BOS_1"),_idChampion_1)
	end
end

function CineDCA1_End()
	ShowCinematicBlackStripes(false)
	_bDCA1_1CineB = false
end
