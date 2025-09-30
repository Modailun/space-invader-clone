extends "res://scripts/enemies/enemy.gd"

var direction: int = -1
@export var speed: int = 48

func _ready() -> void:
	print("Mothership ready")
	if position.x > 160:
		direction = -1
	else:
		direction = 1

func _physics_process(delta: float) -> void:
	# Récupère la taille actuelle de la fenêtre
	var viewport_size = get_viewport_rect().size
	# Déplace l'objet horizontalement
	position.x += speed * delta * direction
	# Inverse la direction horizontale si on atteint les bords
	if position.x > viewport_size.x + 16 or position.x < -16:
		queue_free()  # Détruit l'objet s'il sort de l'écran