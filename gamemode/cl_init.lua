//NOTE: Nearly all of the camera/2D Movement code was written by Dlaor for the Gamemaster gamemode. Thank you, Dlaor.
//He can be found here: http://www.facepunch.com/member.php?u=103210

include("shared.lua")

local viewpos = vector_origin
local viewfov = 0

local lasttime = 0

function clientInit()

	gui.EnableScreenClicker(true)

end
hook.Add("Initialize", "clientInit", clientInit)

function clientThink()


	//I think we can remove this hook, doesn't seem to do anything
	local aimvector = LocalPlayer():GetCursorAimVector()
	
	local tracedata = {}
	tracedata.start = viewpos + Vector( 0, -CAM_DIST, 0 )
	tracedata.endpos = tracedata.start + ( aimvector * 5000 )
	tracedata.filter = player.GetAll()
	ptrace = util.TraceLine( tracedata )

	
	//Shoddy attempt to get freezecam zoom working
	/*if !LocalPlayer():Alive() then
		viewfov = viewfov - 25 * os.clock() - lasttime //Decrease fov by 25 per second if player is dead. Gives freezecam zoom-in.
		
		if viewfov < 20 then viewfov = 20 end
	end
	
	if LocalPlayer():Alive() then
		viewfov = 0
	end
	
	lasttime = os.clock()*/
	
end
hook.Add("Think", "clientThink", clientThink)

function clientMousePressed(mc)
	
	if (mc == MOUSE_LEFT) then LocalPlayer():ConCommand( "+attack" ) RunConsoleCommand( "spec_next" ) end
	if (mc == MOUSE_RIGHT) then LocalPlayer():ConCommand( "+attack2" ) RunConsoleCommand( "spec_prev" ) end
	
end

hook.Add( "GUIMousePressed", "clientMousePressed", clientMousePressed )

function clientMouseReleased( mc )
		
	if ( mc == MOUSE_LEFT ) then
		LocalPlayer():ConCommand( "-attack" )
	end
	
	if ( mc == MOUSE_RIGHT ) then
		LocalPlayer():ConCommand( "-attack2" )
	end
	
end

hook.Add( "GUIMouseReleased", "clientMouseReleased", clientMouseReleased )


function GM:CreateMove( cmd )
	
	if LocalPlayer():Alive() then
	
		cmd:SetForwardMove( cmd:GetSideMove() )
		
		local ang = 0
		local playerpos = ( LocalPlayer():GetShootPos() ):ToScreen()
		local xdiff = gui.MouseX() - playerpos.x
		local ydiff = gui.MouseY() - playerpos.y
		ang = math.Rad2Deg( math.atan2( ydiff, xdiff ) )

		if ( ang < 90 and ang > -90 ) then
			cmd:SetViewAngles( Angle( ang, 0, 0 ) )
		else
			cmd:SetViewAngles( Angle( 180 - ang, 180, 0 ) )
			cmd:SetForwardMove( -cmd:GetSideMove() )
		end
		
		cmd:SetSideMove( 0 )
		
	end
	
end


function GM:CalcView( ply, origin, angles, fov )
	
	if ( ply:Alive() ) then
		
		viewpos = origin + Vector( 0, 0, 0 ) //If the player is alive, just use the player position
		
	end
	
	if ( ValidEntity( ply:GetRagdollEntity() ) ) then //If the player isn't alive, get the ragdoll position
		viewpos = ply:GetRagdollEntity():GetPos() + Vector( 0, 0, 0 )
		if ( ValidEntity( ply:GetObserverTarget() ) ) then //If the player is spectating, use the spectator target position
			viewpos = ply:GetObserverTarget():GetPos() + Vector( 0, 0, 0 )
		end
	end
	
	local view = {}
 
 
	view.origin = viewpos + Vector( 0, -CAM_DIST, 0 )
	
	local normalizedMouseX = (gui.MouseX()*2 / ScrW()) - 1 //Move camera slightly depending on mouse position
	local normalizedMouseY = (gui.MouseY()*2 / ScrW()) - 1
	
	view.origin.x = view.origin.x + normalizedMouseX * 25
	view.origin.z = view.origin.z - normalizedMouseY * 25
	
	view.angles = ( viewpos - view.origin ):Angle()
	
	//view.fov = fov - viewfov
	
	//view.angles.y = view.angles.y * -1
	
	//view.origin = view.origin + ShakeVec() //Shake it baby!
 
	return view
 
end