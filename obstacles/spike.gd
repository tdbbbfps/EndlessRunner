extends Node2D

@export var area2d : Area2D
var is_showed : bool = false # 控制障礙物是否能被銷毀

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_showed = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if is_showed:
		queue_free()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is Character:
		body.take_damage(1)
		area2d.set_collision_mask_value(4, false) # Disabled spike
