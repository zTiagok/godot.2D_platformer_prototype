class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer


@export var entity: EntityResource
var direction: Vector2


func _process(_delta: float) -> void:
	# Pega os inputs que o player está apertando.
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))


func ChangeDirection() -> void:
	# Altera a direção do sprite dependendo da direção do player.
	if direction.x > 0:
		sprite.scale.x = 1

	elif direction.x < 0:
		sprite.scale.x = -1
		

func ChangeAnimation(animationName: String) -> void:
	animationPlayer.play(animationName)
