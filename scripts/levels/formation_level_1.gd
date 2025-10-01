extends Node2D

var direction: int = -1
var direction_y: int = 1
@export var speed: int = 16
@export var max_speed: int = 128
@export var speed_increment: int = 4
var sprite_size: int = 16
var distance_y: int = 4

# Liste des ennemis, triés par ligne (la dernière ligne est la plus basse)
var enemies: Array = [[],[],[]]
# Délai aléatoire entre les tirs (en secondes)
var min_shoot_delay: float = 1.0
var max_shoot_delay: float = 3.0
# Timer pour gérer le délai entre les tirs

@onready var shoot_timer: Timer = $ShootTimer
@onready var orange_ship_scene: PackedScene = preload("res://scenes/enemies/orange_ship.tscn")
@onready var violet_ship_scene: PackedScene = preload("res://scenes/enemies/violet_ship.tscn")
@onready var game_manager: Node = %GameManager

func _ready() -> void:
	# Ajoute les ennemis de la première ligne
	for child in get_children():
		if child is Enemy:
			enemies[0].append(child)

    # Ajoute les ennemis de la deuxième ligne (orange)
	for i in range(enemies[0].size()):
		var orange_ship = orange_ship_scene.instantiate()
		orange_ship.position = enemies[0][i].position + Vector2(0, 16)
		add_child(orange_ship)  # Ajoute directement à la scène
		enemies[1].append(orange_ship)

	# Ajoute les ennemis de la troisième ligne (violet)
	for i in range(enemies[1].size()):
		var violet_ship = violet_ship_scene.instantiate()
		violet_ship.position = enemies[1][i].position + Vector2(0, 16)
		add_child(violet_ship)  # Ajoute directement à la scène
		enemies[2].append(violet_ship)

	# print(enemies)
	# Démarre le timer pour le premier tir
	shoot_timer.wait_time = randf_range(min_shoot_delay, max_shoot_delay)
	shoot_timer.start()

func _physics_process(delta: float) -> void:
	# Récupère la taille actuelle de la fenêtre
	var viewport_size = get_viewport_rect().size

	# Déplace l'objet horizontalement
	position.x += speed * delta * direction

	# Inverse la direction horizontale si on atteint les bords
	if position.x > viewport_size.x - 4 * sprite_size or position.x < 4 * sprite_size:
		direction *= -1
		position.y += direction_y * distance_y
		speed = min(speed + speed_increment, max_speed)

    # Inverse la direction verticale si on atteint le haut ou le bas
	if position.y > viewport_size.y - 5 * sprite_size or position.y < 3 * sprite_size:
		direction_y *= -1
		position.y += direction_y * distance_y
	
	if get_bottom_enemies().size() == 0:
		game_manager.winner()

func _on_shoot_timer_timeout() -> void:
	# Trouve la ligne la plus basse avec des ennemis vivants
	var bottom_line_enemies = get_bottom_enemies()
	if bottom_line_enemies.size() > 0:
		# Choisis un ennemi aléatoire dans la ligne la plus basse
		var shooter = bottom_line_enemies[randi() % bottom_line_enemies.size()]
		shooter.shoot()
	# Redémarre le timer avec un délai aléatoire
	shoot_timer.wait_time = randf_range(min_shoot_delay, max_shoot_delay)
	shoot_timer.start()

func get_bottom_enemies() -> Array:
	var bottom_line: Array = []
	# Parcourir chaque ligne du tableau 2D "enemies"
	for line_idx in range(enemies.size()):
		var line = enemies[line_idx]
		for enemy_idx in range(line.size()):
			# Vérifie si l'ennemi est valide et vivant
			if line[enemy_idx] != null and line[enemy_idx].is_inside_tree() and line[enemy_idx].is_alive:
				# Si c'est la dernière ligne, tous les ennemis sont "du bas"
				if line_idx == enemies.size() - 1:
					bottom_line.append(line[enemy_idx])
				# Si c'est l'avant-dernière ligne, vérifier si la ligne en dessous a un ennemi vivant
				elif line_idx == enemies.size() - 2:
					var line_below = enemies[line_idx + 1]
					if enemy_idx >= line_below.size() or line_below[enemy_idx] == null or !line_below[enemy_idx].is_alive:
						bottom_line.append(line[enemy_idx])
				else:
					# Récupérer la ligne en dessous
					var line_below = enemies[line_idx + 1]
					var line_below_below = enemies[line_idx + 2]
					# Vérifier si l'ennemi n'est pas "recouvert" par un ennemi en dessous
					# (on vérifie que l'ennemi en dessous n'existe pas ou n'est pas vivant)
					if (enemy_idx >= line_below.size() or line_below[enemy_idx] == null or !line_below[enemy_idx].is_alive) and (enemy_idx >= line_below_below.size() or line_below_below[enemy_idx] == null or !line_below_below[enemy_idx].is_alive):
						bottom_line.append(line[enemy_idx])
	return bottom_line