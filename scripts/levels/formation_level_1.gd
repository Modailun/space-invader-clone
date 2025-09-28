extends Node2D

var direction : int = -1
@export var speed : int = 32
var sprite_size : int = 16

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.x += speed * delta * direction
	if position.x > 320 - 4 * sprite_size:
		direction *= -1
		position.y += 4
	elif position.x < 4 * sprite_size:
		direction *= -1
		position.y += 4

