extends RigidBody2D

#nodes
@onready var projectile_sprite : Sprite2D = $ProjectileSprite


@export var small_pop_scene : PackedScene

#projectile sprites
const LIL_PROJECTILE = preload("uid://dncwug0u8gsp0")


var projectile_direction : Vector2
var speed : float = 150

enum projectile_types {
	base,
	explosive,
	piercing,
	mini,
	huge,
	
}

var current_projectile : projectile_types



func _ready() -> void:
	current_projectile = projectile_types.base
	
	projectile_picker()


func _physics_process(delta: float) -> void:
	linear_velocity = projectile_direction.normalized() * speed

func projectile_picker():
	if current_projectile == projectile_types.base:
		projectile_sprite.texture = LIL_PROJECTILE


func explode():
	spawn_small_pop(global_position)
	queue_free()


func spawn_small_pop(world_location : Vector2):
	print("pop")
	if small_pop_scene:
		var small_pop_instance = small_pop_scene.instantiate()
		get_tree().current_scene.add_child(small_pop_instance)
		small_pop_instance.global_position = world_location
