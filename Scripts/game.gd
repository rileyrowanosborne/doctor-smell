extends Node2D




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		get_tree().change_scene_to_file("res://Scenes/power_up_select_screen_2.tscn")
