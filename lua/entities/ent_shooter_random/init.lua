AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local delay = 0.1

function ENT:Initialize()
    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- Sets the model for the entity.

    self:PhysicsInit( SOLID_VPHYSICS ) -- Initializes physics for the entity, making it solid and interactable.
    self:SetMoveType( MOVETYPE_VPHYSICS ) -- Sets how the entity moves, using physics.
    self:SetSolid( SOLID_VPHYSICS ) -- Makes the entity solid, allowing for collisions.

    local phys = self:GetPhysicsObject() -- Retrieves the physics object of the entity.

    if phys:IsValid() then -- Checks if the physics object is valid.
        phys:Wake() -- Activates the physics object, making the entity subject to physics (gravity, collisions, etc.).

    end

    self.isReady = true

end


function ENT:Use(activator, caller)

    if self.isReady then
        self:Shoot("models/props_c17/oildrum001_explosive.mdl")

        self.isReady = false

        timer.Simple(delay,function() 
            self.isReady = true
            self:Use(activator,caller)
        end) 
     end
end



function ENT:Shoot(ent_model)

    local ent = ents.Create("prop_physics")
    
    if(not ent:IsValid()) then return end

    ent:SetModel(ent_model)

    util.SpriteTrail( ent, 0, Color( 255, 0, 0 ), false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, "trails/plasma" )
    ent:Ignite(8,10)

    if(not ent:IsValid()) then return end

    local aimvec = self:GetForward()*35
    aimvec:Add(VectorRand(-5,5))
    local pos = self:GetPos()+aimvec
    
    ent:SetPos(pos)

    ent:SetAngles(self:GetAngles())
    ent:Spawn()

    local phys = ent:GetPhysicsObject()
    if (not phys:IsValid()) then ent:Remove() return end

    aimvec:Mul(100)
    phys:ApplyForceCenter(aimvec*1000)

    
    timer.Simple( 3, function() if ent and ent:IsValid() then 
        
        local pos = ent:GetPos()
        local effectdata = EffectData()
        effectdata:SetOrigin(pos)

        util.Effect("Explosion",effectdata)
        util.BlastDamage(ent,ent,pos,100,200)
       
        ent:Remove()
    
    end end )

end
