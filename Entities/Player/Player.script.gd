@icon("res://Entities/Player/Icons/person-blue.png")
class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer


@export var entity: EntityResource
var direction: Vector2


func _ready() -> void:
	# Salva o Player ao GameManager.
	LocalGameManager.player = self


func _process(_delta: float) -> void:
	# Pega os inputs que o player está apertando.
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))


func _physics_process(delta: float) -> void:
	# Ativa a gravidade no Player.
	if !is_on_floor():
		velocity.y -= LocalGameManager.gravity * delta
	
	# Caso não esteja encostando no chão, altera o valor da variável para verdadeiro.
	entity.isFalling = !is_on_floor()

	# Ativa a física.
	move_and_slide()


func ChangeDirection() -> void:
	# Altera a direção do sprite dependendo da direção do player.
	if direction.x > 0:
		sprite.scale.x = 1

	elif direction.x < 0:
		sprite.scale.x = -1
		

func ChangeAnimation(animationName: String) -> void:
	animationPlayer.play(animationName)
