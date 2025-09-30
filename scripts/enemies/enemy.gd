extends CharacterBody2D

class_name Enemy

var is_alive: bool = true
var chunk_scene: PackedScene = preload("res://scenes/enemies/chunk.tscn")

func _ready() -> void:
	add_to_group("enemies")

func shoot() -> void:
	if is_alive:
		var chunk = chunk_scene.instantiate()
		chunk.position = global_position + Vector2(0, 16)  # Ajuste selon ton sprite
		get_tree().current_scene.add_child(chunk)

func die() -> void:
	is_alive = false