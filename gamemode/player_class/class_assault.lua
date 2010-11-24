local CLASS = {}
 
CLASS.DisplayName			= "Assault"
CLASS.WalkSpeed 			= 300
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 300
CLASS.DuckSpeed				= 0.2
CLASS.JumpPower				= 220
CLASS.PlayerModel			= "models/player/kleiner.mdl"
CLASS.MaxHealth				= 100
CLASS.StartHealth			= 100
CLASS.DropWeaponOnDie		= false
CLASS.TeammateNoCollide 	= false
CLASS.AvoidPlayers			= false // Automatically avoid players that we're no colliding
CLASS.Selectable			= true // When false, this disables all the team checking
CLASS.FullRotation			= false // Allow the player's model to rotate upwards, etc etc
CLASS.Base					= "BasicClass"
 
function CLASS:Loadout( pl )
	
	pl:GiveAmmo(30, "pistol")
	pl:Give( "weapon_tjp_shotgun" )
 
end
 
function CLASS:OnSpawn( pl )
end
 
function CLASS:OnDeath( pl, attacker, dmginfo )
end
 
function CLASS:Think( pl )
end
 
function CLASS:Move( pl, mv )
end
 
function CLASS:OnKeyPress( pl, key )
end
 
function CLASS:OnKeyRelease( pl, key )
end
 
function CLASS:ShouldDrawLocalPlayer( pl )
	return true
end
 
player_class.Register( "AssaultClass", CLASS )