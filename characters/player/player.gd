extends Character
class_name Player

var start_moving : bool = false
var can_jump : bool = false
@export var coyote_timer : Timer

func _ready() -> void:
	super()
	start_moving = true

func _physics_process(delta: float) -> void:
	if start_moving:
		# Automatically change state to move when it is avalible.
		if fsm.current_state != PlayerMove and fsm.current_state.can_transition:
			fsm.change_state("move")
		# Jump
		if Input.is_action_just_pressed("Jump") and can_jump:
			fsm.change_state("jump")
		if Input.is_action_just_released("Jump") and velocity.y < 0:
			velocity.y *= 0.5
		# Start sneaking.
		if Input.is_action_pressed("Sneak") and fsm.current_state != PlayerSneak:
			fsm.change_state("sneak")
		if Input.is_action_just_pressed("Kick") and fsm.current_state != PlayerKick:
			fsm.change_state("kick")
		if Input.is_action_just_pressed("FireBreath") and fsm.current_state != PlayerFireBreath:
			fsm.change_state("firebreath")
	move_and_slide()
	handling_jump()
	apply_gravity(delta)

# Handling player jump and coyote jump.
func handling_jump() -> void:
	if is_on_floor() and not can_jump:
		can_jump = true
	elif not is_on_floor() and can_jump and coyote_timer.is_stopped():
		coyote_timer.start()

func _on_coyote_timer_timeout() -> void:
	if not is_on_floor():
		can_jump = false

func apply_gravity(delta : float) -> void:
	velocity.y += get_gravity().y * delta
