extends State

var player : Player
var wallSide: Vector2

@export var horizontalPushOff: float = 20.0

func Enter() -> void:
	player = entity

	player.isWallSliding = true

	# Reseta a quantidade de pulos.
	player.jumpsQuantity = 2

	
	# Salva a direção da parede que o Player está encostando.
	wallSide = player.DetectWallSide()

	# Flipa o sprite do Player baseando-se na direção da parede.
	ChangePlayerSide(wallSide)


func PhysicsUpdate(_delta) -> void:
	if player.is_on_wall():
		if (Input.is_action_just_pressed("jump")):

			# Altera o estado para WallJump.
			stateMachine.ChangeState("WallJump")
	else:
		stateMachine.ChangeState("Fall")

# Função utilizada para alterar a direção do sprite do Player em base na
# direção que a parede está, utilizando a função "DetectWallSide"
func ChangePlayerSide(wallDirection: Vector2) -> void:
	player.sprite.scale.x = wallDirection.x


func Exit() -> void:
	player.isWallSliding = false
