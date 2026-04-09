extends Area2D






func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage()
		
	


func _on_body_entered(body: Node2D) -> void:
	if get_parent().has_method("explode"):
		if PlayerInfo.can_ricochet:
			return
		else:
			get_parent().explode()
