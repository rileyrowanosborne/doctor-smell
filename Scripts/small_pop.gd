extends Node2D

@onready var explode_anim: AnimatedSprite2D = $ExplodeAnim



func _ready() -> void:
	explode_anim.play("Explode")


func _on_explode_anim_animation_finished() -> void:
	queue_free()
