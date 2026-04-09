extends RigidBody2D



#nodes
@onready var projectile_sprite : Sprite2D = $ProjectileSprite



#assets
	#Base projectiles
const HUGE_LIL_PROJECTILES = preload("uid://cake47m60bpuq")
const LIL_PROJECTILE = preload("uid://dncwug0u8gsp0")
const LIL_LIL_PROJECTILE = preload("uid://6ecuv1y6uheh")
	
	#Ricochet projectiles
const LIL_LIL_RICOCHET_PROJECTILE = preload("uid://cmw1xcedfsuc8")
const LIL_RICHOCHET_PROJECTILE = preload("uid://deg5i8pwhsji6")
const RICOCHET_PROJECTILE = preload("uid://r554hp13km8q")



@export var small_pop_scene : PackedScene


var projectile_direction : Vector2


#base stats for projectiles
var speed : float = 150
var fire_rate_delay : float = .5
var total_bounces : int = 0
var total_max_bounces : int = 3


func _ready() -> void:
	projectile_type()


func projectile_type():
	if PlayerInfo.is_huge:
		PlayerInfo.fire_rate_delay = 1.5
		PlayerInfo.projectile_speed = 100.0
		PlayerInfo.projectile_damage = 10
	
	elif PlayerInfo.is_mini:
		PlayerInfo.fire_rate_delay = .1
		PlayerInfo.projectile_speed = 200.0
		PlayerInfo.projectile_damage = 2.5
	
	elif PlayerInfo.can_explode:
		PlayerInfo.fire_rate_delay = .75
	
	elif PlayerInfo.can_ricochet:
		PlayerInfo.projectile_damage = 5
		PlayerInfo.fire_rate_delay = .5
		PlayerInfo.projectile_speed = 150.0
	
	else:
		PlayerInfo.projectile_damage = 5
		PlayerInfo.fire_rate_delay = .5
		PlayerInfo.projectile_speed = 150.0
	
	if PlayerInfo.can_ricochet:
		total_max_bounces = 2
	else: 
		total_max_bounces = 0



func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(projectile_direction.normalized() * PlayerInfo.projectile_speed * delta)
	if collision:
		if total_bounces >= total_max_bounces:
			explode()
		else:
			projectile_direction = projectile_direction.bounce(collision.get_normal())
			spawn_small_pop(global_position, Vector2(1,1))
			total_bounces += 1

	
	
	
	
func explode():
	
	if PlayerInfo.is_huge:
		spawn_small_pop(global_position, Vector2(2,2))
	elif PlayerInfo.is_mini:
		spawn_small_pop(global_position, Vector2(.5,.5))
	else:
		spawn_small_pop(global_position, Vector2(1,1))
	
	queue_free()




func spawn_small_pop(world_location : Vector2, proj_scale : Vector2):
	if small_pop_scene:
		var small_pop_instance = small_pop_scene.instantiate()
		get_tree().current_scene.add_child(small_pop_instance)
		small_pop_instance.global_position = world_location
		small_pop_instance.scale = proj_scale
