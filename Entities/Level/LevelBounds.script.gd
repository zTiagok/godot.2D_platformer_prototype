class_name LevelBounds extends Area2D

var startingPoint: Marker2D

func _ready() -> void:
	startingPoint = get_parent().find_child("LevelStartPoint")

	assert(startingPoint, "No Starting Point was set for this level.")


func OnBodyEntered(body: Node2D) -> void:
	if body is Player:
		body.position = startingPoint.position
		print("OK")
