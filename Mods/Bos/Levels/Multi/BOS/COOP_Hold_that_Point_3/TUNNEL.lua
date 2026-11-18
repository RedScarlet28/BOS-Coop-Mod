function UpdateLevel_TUNNEL()
end
----------------------------------
----------------------------------
--La premiere boite du tunnel depuis le depart du joueur / 
--defreeze la première patrouille (execute un pathway)
--
function OnEnter_Sector_Event_TUNNEL_1(id) 

	if(_bOnEnter_Sector_Event_TUNNEL_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_PATROUILLE_A,false)
			SetVarValue(GetObjectiveID("Obj_A_a"),"Active",true)
			_bOnEnter_Sector_Event_TUNNEL_1=1
		end
	end
end
-------------------------------------------------------------
----------------------------------------------------------------
--La deuxieme boite du tunnel : si le joueur dns la boite et est dans l'EXO
--defreeze deux gardes d'une coursive à gauche, si la patrouille est vivante à ce moment là
--elle se poste à des pathways////
--Securité : si c'est le player ou l'exo qui traverse alors defreeze uniquement les gardes de gauche
function OnEnter_Sector_Event_TUNNEL_2(id) 


_bAlive_idGroup_PATROUILLE_A=IsAlive(_idGroup_PATROUILLE_A)

	if(_bOnEnter_Sector_Event_TUNNEL_2==0)then
		if(id == GetLocalCharacterID("Player"))and(_bIS_IN == 0)then
				FreezeAll(_idGroup_TUNNEL_02,false)
			if(_bAlive_idGroup_PATROUILLE_A==true)then
					SetVarValue(_idChar_UAN_TUNNEL_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_4"))	
					SetVarValue(_idChar_UAN_TUNNEL_01_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_5"))
					SetVarValue(_idChar_UAN_TUNNEL_01_4,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_tunnel_poste_6"))
					FreezeAll(_idGroup_PATROUILLE_C,false)
			end
			if(id == GetLocalCharacterID("Player"))or(id == _idExo_Player)then
				FreezeAll(_idGroup_TUNNEL_02,false)
			end
				_bOnEnter_Sector_Event_TUNNEL_2=1
		 end
	end
end
----------------------------------------------------
function Surprise()

	if(_bSurprise==0)then
		if(CharacterCanSee(_idChar_UAN_TUNNEL_01_1,_idPlayer)==true)then
			MakeCharacterSpeak(_idChar_UAN_TUNNEL_01_1,_idPlayer,"DIA_GEN_COOL_TO_STRESS_TEAM_B_VOICE_B_1",false,100,2,0.0,"",0)
			_bSurprise=1
		end	
	end
end
--------------------------------------------------
--la mort entraine le defreeze
function Renforts_Tunnel()

_bAlive_idGroup_PATROUILLE_A=IsAlive(_idGroup_PATROUILLE_A)

		if(_bAlive_idGroup_PATROUILLE_A==false)then
			FreezeAll(_idGroup_TUNNEL_03,false)
			FreezeAll(_idGroup_TUNNEL_02,false)
		end
end
--------------------------------------------
function Renforts_Tunnel_A()

_bAlive_idGroup_TUNNEL_02=IsAlive(_idGroup_TUNNEL_02)
		if(_bAlive_idGroup_TUNNEL_02==false)then
				FreezeAll(_idGroup_TUNNEL_05,false)
		end

end
--------------------------------------------
function Renforts_Tunnel_B()


_bAlive_idGroup_TUNNEL_04=IsAlive(_idGroup_TUNNEL_04)
		if(_bAlive_idGroup_TUNNEL_04==false)then
				FreezeAll(_idGroup_TUNNEL_05,false)
		end

end
--------------------------------------------
--Defreeze le premier groupe dehors + deux snipers 
function OnEnter_Sector_Event_TUNNEL_SORTIE(id) 

	if(_bOnEnter_Sector_Event_TUNNEL_SORTIE==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_ENTRANCE_01,false)
		--	RadioMessage("DIA_SPE_NIV_K_INGENIEUR_23",true,100,0.0,"")
			Freeze(_idChar_UAN_MIRADOR_00_1,false)
			Freeze(_idChar_UAN_MIRADOR_00_2,false)
			StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav",true)
			_bOnEnter_Sector_Event_TUNNEL_SORTIE=1
		end
	end
end
-------------------------------------------------------
--Si on passe cette boite en EXO alors les mecs dehors s'arment de leur HEAVY
--
function OnEnter_Sector_Event_TUNNEL_PORTE(id)


	if(_bOnEnter_Sector_Event_TUNNEL_PORTE==0)then
		if(id == GetLocalCharacterID("Player"))and(_bIS_IN == 0)then
				FreezeAll(_idGroup_TUNNEL_05,false)
	--	RadioMessage("DIA_SPE_NIV_K_INGENIEUR_23",true,100,0.0,"")
		_bOnEnter_Sector_Event_TUNNEL_PORTE=1
		end
	end
end
------------------------------------------------------
function OnEnter_Sector_Event_TUNNEL_3(id)


	if(_bOnEnter_Sector_Event_TUNNEL_3==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_TUNNEL_04,false)
		
			if(id==_idChar_UAN_TUNNEL_04_1)then
			--	MakeCharacterSpeak(_idChar_UAN_TUNNEL_04_1,_idPlayer,"DIA_GEN_COOL_TO_STRESS_TEAM_A_VOICE_A_1",false,100,2,0.0,"",100)
			end
			_bOnEnter_Sector_Event_TUNNEL_3=1
		end
	end
end
------------------------------------------------



















