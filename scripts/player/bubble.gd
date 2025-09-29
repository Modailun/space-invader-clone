extends Area2D

@export var speed: float = 50.0

func _physics_process(delta: float) -> void:
	# Move the bubble upwards
	position.y -= speed * delta
	# Remove the bubble if it goes off-screen
	if position.y < -32:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy and body.is_inside_tree():
		body.queue_free()
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_chunks") and area.is_inside_tree():
		area.queue_free()
		queue_free()
