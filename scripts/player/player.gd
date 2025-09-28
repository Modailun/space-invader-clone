extends CharacterBody2D

const SPEED = 5000.0

var bubble_scene: PackedScene = preload("res://scenes/player/bubble.tscn")
var bubble_start_speed : float = 50.0

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	# Handle movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	move_and_slide()

# Handle shooting
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and not timer.is_stopped():
		return  # Empêche le tir si le timer est en cours
	if event.is_action_pressed("shoot"):
		print("Shoot!")
		# Crée une instance de la scène de la bulle
		var bubble = bubble_scene.instantiate()
		# Positionne la bulle au-dessus du joueur
		bubble.position = position + Vector2(0, -4)
		# Définit la vitesse de la bulle
		bubble.speed = bubble_start_speed
		# Ajoute la bulle à la scène
		get_parent().add_child(bubble)
		# Démarre le timer pour limiter la cadence de tir
		timer.start()
