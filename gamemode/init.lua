AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");

include("sv_downloads.lua");
include("shared.lua");
include("player_extension.lua");

function serverThink()

	/*for k, v in pairs(player.GetAll()) do //Lock all the players to 0 on the y-axis
		local plyPos = v:GetPos()
		
		if (plyPos.y != 0) then
		
			v:SetPos(Vector(plyPos.x, 0, plyPos.z))
			
		end
	end*/
	
end

hook.Add("Think", "serverThink", serverThink)

function removeFallDamage( ent, inflictor, attacker, amount, dmginfo )

	if ent:IsPlayer() && dmginfo:IsFallDamage() then
		dmginfo:SetDamage(0)
	end
end

hook.Add("EntityTakeDamage", "removeFallDamage", removeFallDamage)

function GM:PlayerSpawn( ply )
	self.BaseClass:PlayerSpawn(ply)
	
	ply:CrosshairDisable() //Don't want the crosshair in the middle of the screen
	ply:RefuelJetpack()
	
end