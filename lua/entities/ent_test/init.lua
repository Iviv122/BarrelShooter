AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Server-side initialization function for the entity
function ENT:Initialize()
    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- Sets the model for the entity.

    self:PhysicsInit( SOLID_VPHYSICS ) -- Initializes physics for the entity, making it solid and interactable.
    self:SetMoveType( MOVETYPE_VPHYSICS ) -- Sets how the entity moves, using physics.
    self:SetSolid( SOLID_VPHYSICS ) -- Makes the entity solid, allowing for collisions.

    self:SetColor(Color(0,255,0))

    local phys = self:GetPhysicsObject() -- Retrieves the physics object of the entity.

    if phys:IsValid() then -- Checks if the physics object is valid.
        phys:Wake() -- Activates the physics object, making the entity subject to physics (gravity, collisions, etc.).

    end
end

function ENT:Use(activator, caller)
   
        local pos = self:GetPos()
        local effectdata = EffectData()
        effectdata:SetOrigin(pos)

        util.Effect("Explosion",effectdata)
        util.BlastDamage(self,self,pos,100,200)
       
        self:Remove()
    
end