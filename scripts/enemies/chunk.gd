extends Area2D

var speed: float = 50.0

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 190 :  # Supprime la balle si elle sort de l'écran
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.queue_free()
		queue_free()
		# Optionally, you can add score increment logic here
