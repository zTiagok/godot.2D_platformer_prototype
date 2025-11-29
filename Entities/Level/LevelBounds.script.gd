class_name LevelBounds extends Area2D

@onready var teleportingPoint: Marker2D = $TeleportingPoint 

func OnBodyEntered(body: Node2D) -> void:
	if body is Player:
		# Verifica se a colisão é o Player e o teleporta ao ponto inicial.
		body.global_position = teleportingPoint.global_position
