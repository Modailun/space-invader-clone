extends Area2D

@export var speed: float = 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("enemy_chunks")

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 212 :  # Supprime la balle si elle sort de l'écran
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("rock") and body.is_inside_tree():
		animation_player.play("rock destroy")
		body.queue_free()
	elif body.is_in_group("player") and body.is_inside_tree():
		animation_player.play("death player")
		body.died()
