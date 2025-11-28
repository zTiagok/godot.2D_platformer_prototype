extends State

var player : Player
var wallSide: Vector2

@export var horizontalPushOff: float = 20.0

func Enter() -> void:
	player = entity

	player.isWallSliding = true

	# Incrementa a quantidade de pulos.
	if player.jumpsQuantity < 2:
		player.jumpsQuantity += 1

	
	# Salva a direção da parede que o Player está encostando.
	wallSide = DetectWallSide()

	# Flipa o sprite do Player baseando-se na direção da parede.
	ChangePlayerSide(wallSide)


func PhysicsUpdate(_delta) -> void:
	if player.is_on_wall():
		if (Input.is_action_just_pressed("jump")):
			# Aplica o Wall Jump.
			ApplyWallJump()
 
			# Altera o estado baseando-se na quantidade de pulos restantes.
			if player.jumpsQuantity >= 2:
				stateMachine.ChangeState("DoubleJump")
			
			if player.jumpsQuantity >= 1:
				stateMachine.ChangeState("Jump")
	else:
		stateMachine.ChangeState("Fall")


func DetectWallSide() -> Vector2:
	var currentCollision : KinematicCollision2D

	# Percorre todas as colisões do Player.
	for collision in player.get_slide_collision_count():
		# Pega a primeira colisão detectada no Player.
		currentCollision = player.get_slide_collision(collision)

	# Retorna o vetor do lado no qual está sendo encostado.
	return currentCollision.get_normal()


func ApplyWallJump() -> void:
	# Player fica impossibilitado de encostar na parede novamente.
	player.canWallSlide = false

	# Pega uma força para pular para fora da parede...
	var jumpOffForce = Vector2(wallSide.x * horizontalPushOff, player.entity.jumpForce)

	# ...e seta essa força na velocity do Player.
	player.velocity = jumpOffForce


# Função utilizada para alterar a direção do sprite do Player em base na
# direção que a parede está, utilizando a função "DetectWallSide"
func ChangePlayerSide(wallDirection: Vector2) -> void:
	player.sprite.scale.x = wallDirection.x


func Exit() -> void:
	player.isWallSliding = false
