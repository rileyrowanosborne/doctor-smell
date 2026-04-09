extends CharacterBody2D





@onready var ground_pound_anim: AnimatedSprite2D = $GroundPoundAnim
@onready var ground_pound_hit_box: Area2D = $GroundPoundHitBox

@onready var attack_delay_timer: Timer = $AttackDelayTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_timer: Timer = $DamageTimer




@export var max_health : float = 50.0
@export var current_health : float

var min_health : float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health
	ground_pound()
	
	add_to_group("Enemy")


func ground_pound():
	ground_pound_hit_box.monitoring = true
	ground_pound_anim.play("default")
	attack_delay_timer.start()


func take_damage():
	print("enemy damaged")
	current_health -= PlayerInfo.projectile_damage
	sprite_2d.modulate = Color.CRIMSON
	damage_timer.start()
	
	
	if current_health <= min_health:
		queue_free()


func _on_ground_pound_anim_animation_finished() -> void:
	ground_pound_hit_box.monitoring = false


func _on_attack_delay_timer_timeout() -> void:
	ground_pound()


func _on_damage_timer_timeout() -> void:
	sprite_2d.modulate = Color.WHITE
