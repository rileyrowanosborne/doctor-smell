extends Node2D

#nodes
@onready var projectile_sprite : Sprite2D = $ProjectileSprite


#projectile sprites
const BASE_PROJECTILE = preload("uid://1vmbt4sbpkth")


var projectile_direction : Vector2 = Vector2(1,0)


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


func _process(delta: float) -> void:
	position += projectile_direction * 5 * delta


func projectile_picker():
	if current_projectile == projectile_types.base:
		projectile_sprite.texture = BASE_PROJECTILE
