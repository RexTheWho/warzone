
local logic_variants = {
	security = {
		idle = CopLogicIdle,
		attack = CopLogicAttack,
		travel = CopLogicTravel,
		inactive = CopLogicInactive,
		intimidated = CopLogicIntimidated,
		arrest = CopLogicArrest,
		guard = CopLogicGuard,
		flee = CopLogicFlee,
		sniper = CopLogicSniper,
		trade = CopLogicTrade,
		phalanx = CopLogicPhalanxMinion
	}
}
local security_variant = logic_variants.security
logic_variants.gensec = security_variant
logic_variants.cop = security_variant
logic_variants.cop_female = security_variant
logic_variants.fbi = security_variant

-- CARTEL GO HERE
logic_variants.fbi_cartel_base = security_variant
logic_variants.fbi_cartel_light = security_variant
logic_variants.fbi_cartel_medium = security_variant
logic_variants.fbi_cartel_heavy = security_variant


logic_variants.swat = security_variant
logic_variants.heavy_swat = security_variant
logic_variants.fbi_swat = security_variant
logic_variants.fbi_heavy_swat = security_variant
logic_variants.nathan = security_variant
logic_variants.sniper = security_variant
logic_variants.gangster = security_variant
logic_variants.biker = security_variant
logic_variants.mobster = security_variant
logic_variants.mobster_boss = security_variant
logic_variants.hector_boss = security_variant
logic_variants.hector_boss_no_armor = security_variant
logic_variants.dealer = security_variant
logic_variants.biker_escape = security_variant
logic_variants.city_swat = security_variant
logic_variants.old_hoxton_mission = security_variant
logic_variants.inside_man = security_variant
logic_variants.medic = security_variant
logic_variants.biker_boss = security_variant
logic_variants.chavez_boss = security_variant
logic_variants.bolivian = security_variant
logic_variants.bolivian_indoors = security_variant
logic_variants.drug_lord_boss = security_variant
logic_variants.drug_lord_boss_stealth = security_variant
logic_variants.spa_vip = security_variant
logic_variants.bolivian_indoors_mex = security_variant
logic_variants.security_mex = security_variant
logic_variants.cop_scared = security_variant
logic_variants.security_undominatable = security_variant
logic_variants.mute_security_undominatable = security_variant
logic_variants.captain = security_variant

for _, tweak_table_name in pairs({
	"shield",
	"tank",
	"spooc",
	"taser",
	"shadow_spooc"
}) do
	logic_variants[tweak_table_name] = clone(security_variant)
end

logic_variants.shield.attack = ShieldLogicAttack
logic_variants.shield.intimidated = nil
logic_variants.shield.flee = nil
logic_variants.phalanx_minion = clone(logic_variants.shield)
logic_variants.phalanx_vip = clone(logic_variants.shield)
logic_variants.phalanx_vip.phalanx = CopLogicPhalanxVip
logic_variants.tank.attack = TankCopLogicAttack
logic_variants.tank_hw = logic_variants.tank
logic_variants.spooc.idle = SpoocLogicIdle
logic_variants.spooc.attack = SpoocLogicAttack
logic_variants.shadow_spooc.idle = SpoocLogicIdle
logic_variants.shadow_spooc.attack = SpoocLogicAttack
logic_variants.taser.attack = TaserLogicAttack
logic_variants.tank_medic = logic_variants.tank
logic_variants.tank_mini = logic_variants.tank
logic_variants.heavy_swat_sniper = logic_variants.heavy_swat
security_variant = nil
CopBrain._logic_variants = logic_variants
logic_varaints = nil