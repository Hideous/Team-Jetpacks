local CLASS = {} // This defines the class's table. We need it to enter the following values
CLASS.DisplayName	= "Base Class" // This is the name of the class, for display purposes
CLASS.WalkSpeed 	= 400 // This is the walk speed of the class (without shift)
CLASS.CrouchedWalkSpeed = 0.2 // This is the amount that the walk speed is multiplied by while crouching
CLASS.RunSpeed		= 600 // This is the sprinting speed of the class (with shift)
CLASS.DuckSpeed		= 0.2 // This is the speed that the class moves from standing to crouching (in seconds)
CLASS.JumpPower		= 160 // This is the jump power of the class (default: 160)
CLASS.PlayerModel	= "models/player/swat.mdl" // This is the player model that is set for this class
CLASS.DrawTeamRing	= false // Whether or not colored team rings are displayed under players with this class
CLASS.DrawViewModel	= false // Whether or not a player's weapon appears in the first person view using this class
CLASS.CanUseFlashlight = false
CLASS.MaxHealth		= 100 // This is the maximum health of a player with this class
CLASS.StartHealth	= 100 // This is how much health the player spawns with
CLASS.StartArmor	= 0 // This is the amount of armor a player spawns with
CLASS.DropWeaponOnDie	= false // Whether or not a player's weapon gets dropped upon death
CLASS.TeammateNoCollide = true // Whether or not a player should be able to walk through his teammates
CLASS.AvoidPlayers	= true // Push players that are able to walk through this player away?
CLASS.Selectable	= false // When false, this class cannot be chosen from the select class menu
CLASS.FullRotation	= false // Allow the player's model to rotate completely with their view (i.e. looking 90 degrees up will rotate your player model 90 degrees)
CLASS.RespawnTime           = 0 // 0 means use the default spawn time chosen by gamemode
 
local viewpos = vector_origin 

function CLASS:Loadout( pl ) // This is called when the player is given their equipment
	pl:GiveAmmo( 255, "Pistol", true )
	pl:Give( "weapon_pistol" )
end
 
function CLASS:OnSpawn( pl ) // This is called when the player respawns
end
 
function CLASS:OnDeath( pl, attacker, damageinfo ) // This is called when the player dies
end
 
function CLASS:Think( pl ) // This is called in the Think hook.

end
 
function CLASS:Move( pl, mv ) // This is called whenever the player moves and can be used to create a fancy movement system
	
	/*local pos = mv:GetOrigin()
	pos.y = 0
	mv:SetOrigin(pos) //Should lock you to 0 on the y-axis*/

end
 
function CLASS:OnKeyPress( pl, key ) // This is called when a player presses a key
end
 
function CLASS:OnKeyRelease( pl, key ) // This is called when a player releases a key
end
 
function CLASS:ShouldDrawLocalPlayer( pl ) // If you return true the local player will be visible, you'll see your own body.
	return true
end
 
function CLASS:InputMouseApply( pl, cmd, x, y, angle ) // Unknown
end
 
player_class.Register( "BasicClass", CLASS ) // This registers your class. The first argument is the reference name, the second is the class's table (that we defined before)
 