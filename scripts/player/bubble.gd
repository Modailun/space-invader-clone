extends Area2D

var speed: float = 50.0

func _physics_process(delta: float) -> void:
	# Move the bubble upwards
	position.y -= speed * delta
	# Remove the bubble if it goes off-screen
	if position.y < -10:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.queue_free()
		queue_free()
		# Optionally, you can add score increment logic here

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Chunk":
		area.queue_free()
		queue_free()
		# Optionally, you can add score increment logic here
