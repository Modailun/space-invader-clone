extends Node2D

var direction: int = -1
var direction_y: int = 1
@export var speed: int = 32
@export var max_speed: int = 128
var sprite_size: int = 16
var distance_y: int = 4

func _physics_process(delta: float) -> void:
	# Récupère la taille actuelle de la fenêtre
	var viewport_size = get_viewport_rect().size

	# Déplace l'objet horizontalement
	position.x += speed * delta * direction

	# Inverse la direction horizontale si on atteint les bords
	if position.x > viewport_size.x - 4 * sprite_size or position.x < 4 * sprite_size:
		direction *= -1
		position.y += direction_y * 4
		speed = min(speed + 2, max_speed)

    # Inverse la direction verticale si on atteint le haut ou le bas
	if position.y > viewport_size.y - 4 * sprite_size or position.y < 3 * sprite_size:
		direction_y *= -1
		position.y += direction_y * 4