SWEP.PrintName			= "Barrel Thrower" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Instructions		= "Left click to barrage with Barrels! Right click to shoot 20 barrels at once"
SWEP.Category           = "BarrelShooter"


SWEP.Spawnable = true
SWEP.AdminOnly = true


SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.ShootSound = Sound( "Metal.SawbladeStick" )


function SWEP:ThrowBarrel(model_file)
    local owner = self:GetOwner()

   if (not owner:IsValid() ) then return end

    self:EmitSound(self.ShootSound)

    local ent = ents.Create("prop_physics")

    if(not ent:IsValid()) then return end

    ent:SetModel(model_file)
    
    util.SpriteTrail( ent, 0, Color( 255, 0, 0 ), false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, "trails/plasma" )
    ent:Ignite(8,5)

   local aimvec = owner:GetAimVector() // same as owner:EyePos() but more efficient
   local pos = aimvec * 46
   pos:Add(owner:EyePos()) // transfer local vector to world cords;

   ent:SetPos(pos)

   ent:SetAngles(owner:EyeAngles())
   ent:Spawn()

   local phys = ent:GetPhysicsObject()
   if   (not phys:IsValid()) then ent:Remove() return end

   aimvec:Mul(100)
   aimvec:Add(VectorRand(-10,10))
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


function SWEP:PrimaryAttack()
	self:ThrowBarrel("models/props_c17/oildrum001_explosive.mdl")
end

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime()+0.0001)

    for  i=0,20
    do
        self:ThrowBarrel("models/props_c17/oildrum001_explosive.mdl")
    end
end