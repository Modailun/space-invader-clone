extends Area2D

signal hit(points: int)

@export var speed: float = 50.0

func _physics_process(delta: float) -> void:
	# Move the bubble upwards
	position.y -= speed * delta
	# Remove the bubble if it goes off-screen
	if position.y < -32:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("rock") and body.is_inside_tree():
		body.queue_free()
		queue_free()
	elif body is Enemy and body.is_inside_tree():
		if body.is_in_group("mothership"):
			emit_signal("hit", 100)
			#%GameManager.add_point(100)
		elif body.is_in_group("violet_ship"):
			emit_signal("hit", 30)
			#%GameManager.add_point(30)
		elif body.is_in_group("orange_ship"):
			emit_signal("hit", 20)
			#%GameManager.add_point(20)
		body.queue_free()
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_chunks") and area.is_inside_tree():
		#%GameManager.add_point(5)
		emit_signal("hit", 5)
		area.queue_free()
		queue_free()
