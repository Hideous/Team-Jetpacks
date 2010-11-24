
if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.PrintName			=	"Base TJP Weapon"

SWEP.Author				=	"Hideous"
SWEP.Instructions		=	"Point and shoot, bitches."
SWEP.Contact			=	""
SWEP.Purpose			=	"It kills people."

SWEP.AdminSpawnable 	= 	false
SWEP.Spawnable 			= 	false

SWEP.ViewModelFOV		=	143 //Irrelevant, viewmodel is never shown
SWEP.ViewModel			=	"models/weapons/v_knife_t.mdl" //IT'S A KNIFE LOLOLOL

SWEP.Slot				=	1 //First bucket slot
SWEP.SlotPos			=	2

SWEP.HoldType			=	"pistol"

SWEP.FiresUnderwater 	= 	true
SWEP.Weight				=	2.5 //Not entirely sure how this is relevant

SWEP.DrawCrosshair		=	false

SWEP.Category			=	"Team Jetpacks"
SWEP.DrawAmmo			=	true

SWEP.Primary.Ammo		=	"Pistol" //Since all the classes only have one gun, Pistol ammo should do fine
//attack2 is taken by jetpack, so no secondary fire

SWEP.Secondary.Ammo		=	"smg"

SWEP.Base				=	"weapon_base"

function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:SecondaryAttack()

end