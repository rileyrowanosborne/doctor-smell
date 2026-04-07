extends CharacterBody2D



@export var projectile_scene : PackedScene



var speed : float = 250.0
var accel : float = 8.0
var mouse_dir : Vector2

var input : Vector2



func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()




func _physics_process(delta: float) -> void:
	var player_input = get_input()
	
	velocity = lerp(velocity, player_input * speed, delta * accel)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		mouse_dir = get_global_mouse_position()
		fire_projectile()


func fire_projectile():
	if projectile_scene:
		var projectile_instance = projectile_scene.instantiate()
		add_child(projectile_instance)
		projectile_instance.projectile_direction = mouse_dir
