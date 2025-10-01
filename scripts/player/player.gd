extends CharacterBody2D

const SPEED = 5000.0

var bubble_scene: PackedScene = preload("res://scenes/player/bubble.tscn")
var bubble_start_speed : float = 50.0
@export var initial_position: Vector2 = Vector2(160, 160)
@onready var timer: Timer = $Timer
@onready var game_manager: Node = %GameManager

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Handle movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	move_and_slide()

	# Handle shooting (si la touche est maintenue et que le timer est terminé)
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		shoot_bubble()

# Handle shooting
func shoot_bubble():
	# print("Shoot!")
	# Crée une instance de la scène de la bulle
	var bubble = bubble_scene.instantiate()
	# Positionne la bulle au-dessus du joueur
	bubble.position = position + Vector2(0, -4)
	bubble.connect("hit", _on_bubble_hit)
	# Ajoute la bulle à la scène
	get_parent().add_child(bubble)
	# Démarre le timer pour limiter la cadence de tir
	timer.start()

func died() -> void:
	if game_manager.lives > 1:
		position = initial_position
	game_manager.lose_life()

func _on_bubble_hit(points: int) -> void:
	game_manager.add_point(points)