local old_init = CopBrain.post_init
local logic_variants = {
    security = {
        idle = CopLogicIdle,
        attack = CopLogicAttack,
        travel = CopLogicTravel,
        inactive = CopLogicInactive,
        intimidated = CopLogicIntimidated,
        arrest = CopLogicArrest,
        flee = CopLogicFlee,
        sniper = CopLogicSniper,
        spotter = CopLogicSpotter,
        trade = CopLogicTrade,
        phalanx = CopLogicPhalanxMinion,
        turret = CopLogicTurret
    }
}
local security_variant = logic_variants.security
function CopBrain:post_init()
    CopBrain._logic_variants.fbi_cartel_base = clone(security_variant)
    CopBrain._logic_variants.fbi_cartel_light = clone(security_variant)
    CopBrain._logic_variants.fbi_cartel_medium = clone(security_variant)
    CopBrain._logic_variants.fbi_cartel_heavy = clone(security_variant)
    
    old_init(self)
end