extends Node



var fire_rate_delay : float = .5
var projectile_speed : float = 150.0
var projectile_damage : float = 5.0



var is_huge : bool = false
var is_mini : bool = false
var is_shotgun : bool = false
var can_ricochet : bool = false
var can_explode : bool = false
var can_pierce : bool = false
var can_zap : bool = false



var active_powerups : Array[PowerupData] = []


const MAX_SLOTS = 3
var crystal_slots : Array[PowerupData] = []


func recalculate_stats():
	projectile_speed = 150.0
	projectile_damage = 5.0
	fire_rate_delay = 0.5
	
	for p in active_powerups:
		projectile_speed *= p.speed_multiplier
		projectile_damage *= p.damage_multiplier
		fire_rate_delay *= p.fire_rate_multiplier




func equip_crystal(crystal : PowerupData) -> bool:
	if crystal_slots.size() >= MAX_SLOTS:
		return false
	crystal_slots.append(crystal)
	recalculate_stats()
	return true

func unequip_crystal(index : int):
	crystal_slots.remove_at(index)
	recalculate_stats()
