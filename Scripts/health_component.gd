extends Node2D


@export var health : float = 150.0





func take_damage():
	if get_parent().is_in_group("Enemy"):
		print("youch")
		health -= PlayerInfo.projectile_damage
