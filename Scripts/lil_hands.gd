extends Node2D



@onready var projectile_spawn_point: Marker2D = $ProjectileSpawnPoint
@onready var fire_rate_timer: Timer = $FireRateTimer




@export var projectile_scene : PackedScene


@export var is_huge : bool = false
@export var is_mini : bool = false
@export var is_shotgun : bool = false
@export var can_ricochet : bool = false
@export var can_explode : bool = false
@export var can_pierce : bool = false
@export var can_zap : bool = false




var mouse_dir : Vector2

var fire_held : bool = false
var on_delay : bool = false





func _process(delta: float) -> void:
	if Input.is_action_pressed("Fire") and not on_delay:
		on_delay = true
		fire_held = true
		mouse_dir = get_global_mouse_position()
		fire_projectile(projectile_spawn_point.global_position)
	
	if Input.is_action_just_released("Fire"):
		fire_held = false





func fire_projectile(world_location : Vector2):
	if projectile_scene:
		var projectile_instance = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile_instance)
		projectile_instance.projectile_direction = mouse_dir - global_position
		projectile_instance.global_position = world_location
		projectile_instance.rotation = get_angle_to(mouse_dir)
	if fire_held:
		fire_rate_timer.start(PlayerInfo.fire_rate_delay)


func _on_fire_rate_timer_timeout() -> void:
	on_delay = false
