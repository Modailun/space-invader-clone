extends CharacterBody2D


const SPEED = 5000.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()
