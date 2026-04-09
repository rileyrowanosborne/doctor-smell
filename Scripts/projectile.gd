extends RigidBody2D



#nodes
@onready var projectile_sprite : Sprite2D = $ProjectileSprite

@export var small_pop_scene : PackedScene


var projectile_direction : Vector2

#base stats for projectiles
var speed : float = 150
var fire_rate_delay : float = .5



func _ready() -> void:
	projectile_type()


func projectile_type():
	if PlayerInfo.is_huge:
		projectile_sprite.scale = Vector2(3,3)
		PlayerInfo.fire_rate_delay =1.5
		PlayerInfo.projectile_speed = 100.0
	
	if PlayerInfo.is_mini:
		projectile_sprite.scale *= Vector2(.8,.8)
		PlayerInfo.fire_rate_delay = .1
		PlayerInfo.projectile_speed = 200.0
	
	if PlayerInfo.can_explode:
		PlayerInfo.fire_rate_delay = .75





func _physics_process(delta: float) -> void:
	linear_velocity = projectile_direction.normalized() * speed


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
