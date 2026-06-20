extends CharacterBody2D
@onready var camera_2d = $Camera2D
@onready var return_camera_timer = $ReturnCameraTimer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	
	if direction:
		
		if direction > 0 and camera_2d.offset.x < 31:
			camera_2d.offset.x += 2
		elif camera_2d.offset.x > - 31:
			camera_2d.offset.x -= 2
		return_camera_timer.start()
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_return_camera_timer_timeout():
	camera_2d.offset.x = 0
