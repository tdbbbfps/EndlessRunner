extends State

var dir : float = -1
func enter() -> void:
	super()
	can_transition = true
	
func exit() -> void:
	super()

func _physics_process(delta: float) -> void:
	actor.velocity.x = actor.speed * dir
