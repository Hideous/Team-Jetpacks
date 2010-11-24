
if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Base				=	"weapon_tjp_base"

SWEP.PrintName			=	"Assault Shotgun"

SWEP.WorldModel			=	"models/weapons/w_shot_m3super90.mdl"

SWEP.HoldType			=	"shotgun"

//Primary fire settings
SWEP.Primary.Sound		=	"weapons/m3/m3-1.wav"
SWEP.Primary.Damage		=	8
SWEP.Primary.TakeAmmo	=	1
SWEP.Primary.ClipSize	=	6
SWEP.Primary.DefaultClip = 	6
SWEP.Primary.Automatic	=	false
SWEP.Primary.Recoil		=	10 //Not relevant while view-punch doesn't work
SWEP.Primary.Delay		= 0.8
SWEP.Primary.Force		= 260
SWEP.Primary.NumberofShots = 4
SWEP.Primary.Spread		=	0.25

function SWEP:PrimaryAttack()

	if !self:CanPrimaryAttack() then return end
	
	local i
	local shots = self.Primary.NumberofShots
	
	for i=0,shots do //Workaround for broken spread system
	
		local bullet = {}
		
		bullet.Num	=	self.Primary.NumberofShots
		bullet.Src	=	self.Owner:GetShootPos()
		bullet.Dir	=	self.Owner:GetAimVector( ) + math.Rand( -1, 1 ) * Vector( 0, 0, self.Primary.Spread )
		
		local spreadVal = 0//math.sin(math.Deg2Rad(self.Primary.Spread*0.5))
		bullet.Spread = Vector(spreadVal, spreadVal, spreadVal);
		bullet.Tracer = 1//math.random(0,1)
		bullet.TracerName = "Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
		bullet.Force = self.Primary.Force
		
		
		self:ShootEffects()
		
		self.Owner:FireBullets(bullet) //Pow!
		
	end
	
	self:EmitSound(Sound(self.Primary.Sound))
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	
end