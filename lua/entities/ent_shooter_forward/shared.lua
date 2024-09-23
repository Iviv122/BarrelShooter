-- Defines the entity's type, base, printable name, and author for shared access (both server and client)
ENT.Type = "anim" -- Sets the entity type to 'anim', indicating it's an animated entity.
ENT.Base = "base_gmodentity" -- Specifies that this entity is based on the 'base_gmodentity', inheriting its functionality.

ENT.PrintName = "Shooter cube (forward)" -- The name that will appear in the spawn menu.
ENT.Purpose = "On Use spawns in front of it explosive barrels, with 0.1 delay which explodes after 3 seconds"
ENT.Category = "barrelshooter" -- The category for this entity in the spawn menu.


ENT.Spawnable = true -- Specifies whether this entity can be spawned by players in the spawn menu.
ENT.Editable = true 



