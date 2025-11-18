extends StaticBody2D
class_name BreakablePile

var is_showed : bool = false # 控制障礙物是否能被銷毀
@export var collision : CollisionShape2D
@export var aniplayer : AnimationPlayer

func destroy():
	collision.disabled = true
	aniplayer.play("break")

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_showed = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if is_showed:
		queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
