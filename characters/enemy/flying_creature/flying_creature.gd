extends Character
class_name FlyingCreature

var is_showed : bool = false

func _physics_process(delta: float) -> void:
	pass
	

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if not is_showed:
		is_showed = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if is_showed:
		queue_free()
