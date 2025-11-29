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
	# Se o Player ainda estiver encostando na parede...
	print(player.is_on_wall())
	if player.is_on_wall():

		# Caso o Player pule.
		if (Input.is_action_just_pressed("jump")):

			# Altera o estado para WallJump.
			stateMachine.ChangeState("WallJump")

		# Caso o Player aperte a direção ao contrário da parede.
		if player.direction.x == player.DetectWallSide().x:
			# Descola o Player da parede.
			player.velocity.x = lerp(player.velocity.x, (player.direction.x * player.entity.movementSpeed), player.movementAcceleration * _delta)

	# Caso não esteja mais encostando na parede.
	else:
		stateMachine.ChangeState("Fall")

# Função utilizada para alterar a direção do sprite do Player em base na
# direção que a parede está, utilizando a função "DetectWallSide"
func ChangePlayerSide(wallDirection: Vector2) -> void:
	player.sprite.scale.x = wallDirection.x


func Exit() -> void:
	player.isWallSliding = false
