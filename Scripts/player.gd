extends CharacterBody2D


@onready var damage_timer: Timer = $DamageTimer
@onready var sprite_2d: Sprite2D = $Sprite2D



var current_health : float = 150.0


var speed : float = 200.0
var accel : float = 8.0

var input : Vector2


func _ready() -> void:
	add_to_group("Player")
	

func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()




func _physics_process(delta: float) -> void:
	var player_input = get_input()
	
	velocity = lerp(velocity, player_input * speed, delta * accel)
	
	move_and_slide()




func take_damage():
	sprite_2d.modulate = Color.CRIMSON
	damage_timer.start()


func _on_damage_timer_timeout() -> void:
	sprite_2d.modulate = Color.WHITE
