extends Sprite2D


#base projectiles
const HUGE_LIL_PROJECTILES = preload("uid://cake47m60bpuq")
const LIL_LIL_PROJECTILE = preload("uid://6ecuv1y6uheh")
const LIL_PROJECTILE = preload("uid://dncwug0u8gsp0")

#richochet projectiles
const LIL_LIL_RICOCHET_PROJECTILE = preload("uid://cmw1xcedfsuc8")
const LIL_RICHOCHET_PROJECTILE = preload("uid://deg5i8pwhsji6")
const RICOCHET_PROJECTILE = preload("uid://r554hp13km8q")




func _ready() -> void:
	projectile_checker()




func projectile_checker():
	
	if PlayerInfo.is_mini:
		if PlayerInfo.can_ricochet:
			texture = LIL_LIL_RICOCHET_PROJECTILE
		else:
			texture = LIL_LIL_PROJECTILE
	
	elif PlayerInfo.is_huge:
		if PlayerInfo.can_ricochet:
			texture = LIL_RICHOCHET_PROJECTILE
		else:
			texture = HUGE_LIL_PROJECTILES
	else:
		if PlayerInfo.can_ricochet:
			texture = LIL_RICHOCHET_PROJECTILE
		else:
			texture = LIL_PROJECTILE
	
