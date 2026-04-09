extends Area2D








func take_damage():
	if get_parent().is_in_group("Enemy"):
		get_parent().take_damage()
	
	if get_parent().is_in_group("Player"):
		get_parent().take_damage()
