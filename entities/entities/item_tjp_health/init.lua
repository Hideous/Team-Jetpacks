AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

ENT.aHealth = 70
ENT.aModel = "models/tjp/healthcross.mdl"
ENT.gib = 1
ENT.brkOnUse = 1
ENT.dieTime = 0
ENT.killme = false
ENT.Touched = false
ENT.giveHealth = false
ENT.closest = nil
ENT.closestpos = 100

function ENT:Initialize()

	self.Entity:SetModel(self.aModel)
	//self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	/*local w=100 //Width
    local l=100 //Length
    local h=100 //Height
 
    //Vectors
    local min=Vector(0-(w/2),0-(l/2),0-(h/2))
    local max=Vector(w/2,l/2,h/2)
 
    //Set bounding box
    self:SetCollisionBounds(min,max)*/

end


function ENT:GetCenterPos()
	return self:GetPos()
end

function ENT:Use(activator, caller)
	return true
end

function ENT:OnRemove()
end

function ENT:Touch(hitEnt)
	/*if !hitEnt:IsValid() or !hitEnt:IsPlayer() then return end
	
	if self.Entity.Touched == false then
		local health = hitEnt:Health()
	
		health = health + 30
	
		hitEnt:SetHealth(health)
		self.Entity.killme = true
		self.Entity.Touched = true
	end*/
end

function ENT:Think()
	if self.Entity.Touched == false then
		local potents = ents.FindInSphere(self.Entity:GetPos(), 50)
		if next(potents) != nil then
			local potplayers = {}
			for k, v in pairs(potents) do
				if v:IsValid() and v:IsPlayer() then
					table.insert(potplayers,v)
				end
			end
			for k, v in pairs(potplayers) do
				if (self.Entity:GetPos():Distance(v:GetPos()) < self.Entity.closestpos) and (v:Health() < v:GetMaxHealth()) then
					self.Entity.closest = v
					self.Entity.closestpos = self.Entity:GetPos():Distance(v:GetPos())
				end
			end
		end
	end
	
	if self.Entity.closest != nil then
		self.Entity.giveHealth = true
	end
		
	if self.Entity.giveHealth == true then
		//if closest:IsValid() and closest:IsPlayer() then
			local health = self.Entity.closest:Health()
			local maxHealth = self.Entity.closest:GetMaxHealth()
		
			health = health + 30
			if health > maxHealth then
				health = maxHealth
			end
		
			self.Entity.closest:SetHealth(health)
			self.Entity.giveHealth = false
			self.Entity.killme = true
			self.Entity.Touched = true
		//end
	end
		
	
	if (self.Entity.killme == true) then
		self:EmitSound("HealthKit.Touch")
		self:Remove()
	end
end