local old_init = CopMovement.init
local action_variants = {
    security = {
        idle = CopActionIdle,
        act = CopActionAct,
        walk = CopActionWalk,
        turn = CopActionTurn,
        hurt = CopActionHurt,
        stand = CopActionStand,
        crouch = CopActionCrouch,
        shoot = CopActionShoot,
        reload = CopActionReload,
        tase = CopActionTase,
        dodge = CopActionDodge,
        warp = CopActionWarp
    }
}
local security_variant = action_variants.security

function CopMovement:init(unit)    
    CopMovement._action_variants.fbi_cartel_base = clone(security_variant) 
    CopMovement._action_variants.fbi_cartel_light = clone(security_variant) 
    CopMovement._action_variants.fbi_cartel_medium = clone(security_variant) 
    CopMovement._action_variants.fbi_cartel_heavy = clone(security_variant)
    
    old_init(self, unit)
end