extends AnimatableBody2D

class_name Enemy

var speed: float = 100.0
var direction: Vector2 = Vector2(1, 0) # Move right initially
var boundary_left: float = 0.0
var boundary_right: float = 320.0

func _process(delta: float) -> void:
	position += direction * speed * delta
	if position.x < boundary_left:
		position.x = boundary_left
		direction.x *= -1 # Reverse direction
	elif position.x > boundary_right:
		position.x = boundary_right
		direction.x *= -1 # Reverse direction