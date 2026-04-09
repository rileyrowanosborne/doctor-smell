extends Node



var fire_rate_delay : float = .5
var projectile_speed : float = 150.0
var projectile_damage : float = 5.0
var bonus_bounces : int = 0
var projectile_texture : CompressedTexture2D






var active_powerups : Array[PowerupData] = []


const MAX_SLOTS = 4
var crystal_slots : Array[PowerupData] = []


func recalculate_stats():
	projectile_speed = 150.0
	projectile_damage = 5.0
	fire_rate_delay = 0.5
	bonus_bounces = 0  # reset each time

	for crystal in crystal_slots:
		projectile_speed *= crystal.speed_multiplier
		projectile_damage *= crystal.damage_multiplier
		fire_rate_delay *= crystal.fire_rate_multiplier
		bonus_bounces += crystal.adds_bounces
		projectile_texture = crystal.projectile_texture



func equip_crystal(crystal : PowerupData) -> bool:
	if crystal_slots.size() >= MAX_SLOTS:
		return false
	crystal_slots.append(crystal)
	recalculate_stats()
	return true

func unequip_crystal(index : int):
	crystal_slots.remove_at(index)
	recalculate_stats()
