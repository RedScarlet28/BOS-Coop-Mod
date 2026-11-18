
function Spot ()
	if 	(_rRotX_Spot > 0)then
	_bChangeRot = 1
	end
	if 	(_rRotX_Spot < -2.95)then
	_bChangeRot = 0
	end
	if _bChangeRot == 1 then
	_rRotX_Spot = (_rRotX_Spot - 0.01)
	else
	_rRotX_Spot = (_rRotX_Spot + 0.01)
	end
	
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_01"),"Rotation",Vector3D(-_rRotX_Spot,1.4,-1.97))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_02"),"Rotation",Vector3D((_rRotX_Spot*1.1),0.6,1.28))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_03"),"Rotation",Vector3D(-_rRotX_Spot,1.17,-1.38))

end