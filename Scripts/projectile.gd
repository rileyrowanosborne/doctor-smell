extends RigidBody2D



#nodes
@onready var projectile_sprite : Sprite2D = $ProjectileSprite

#scenes to instantiate
@export var small_pop_scene : PackedScene


var projectile_direction : Vector2


#base stats for projectiles
var speed : float = 150
var fire_rate_delay : float = .5
var damage : float = 5.0
var total_bounces : int = 0
var total_max_bounces : int = 0
var texture : CompressedTexture2D



func _ready() -> void:
	total_max_bounces = PlayerInfo.bonus_bounces
	speed = PlayerInfo.projectile_speed
	fire_rate_delay = PlayerInfo.fire_rate_delay
	damage = PlayerInfo.projectile_damage
	


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
	spawn_small_pop(global_position, Vector2(1,1))
	queue_free()




func spawn_small_pop(world_location : Vector2, proj_scale : Vector2):
	if small_pop_scene:
		var small_pop_instance = small_pop_scene.instantiate()
		get_tree().current_scene.add_child(small_pop_instance)
		small_pop_instance.global_position = world_location
		small_pop_instance.scale = proj_scale
