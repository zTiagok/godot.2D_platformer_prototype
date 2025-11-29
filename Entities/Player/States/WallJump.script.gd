extends State

var player : Player
var wallSide : Vector2
var doubleJumpTimer: float;

func Enter() -> void:
	player = entity
	player.isJumping = true

	# Adiciona o timer para que o state não seja trocado para o "Double Jump" no
	# mesmo frame que entraria no "Wall Jump".
	doubleJumpTimer = 0.1;

	# Player fica impossibilitado de encostar na parede novamente.
	player.canWallSlide = false

	# Diminui a quantidade de pulos utilizados.
	player.jumpsQuantity -= 1

	# Aplica o pulo ao entrar no estado com base na força do pulo.
	player.velocity.y = -player.entity.jumpForce

	# Salva a direção da parede que o Player está encostando.
	wallSide = player.DetectWallSide()

	# Pega uma força para pular para fora da parede...
	# var jumpOffForce = Vector2(wallSide.x * horizontalPushOff, player.entity.jumpForce * 1.5)
	var jumpOffForce = Vector2(wallSide.x * player.wallJumpForce.x, -player.wallJumpForce.y)

	# ...e seta essa força na velocity do Player.
	player.velocity = lerp(player.velocity, jumpOffForce, player.movementAcceleration * 0.1)


func Update(_delta) -> void:
	doubleJumpTimer -= _delta

	# Se a velocidade vertical do player passar do limiar de 0 (No caso, está caindo),
	# ele altera o state para o "Fall".
	if player.canWallSlide:
		stateMachine.ChangeState("Fall")

	# Caso o Player pule novamente, vá para o Double Jump.
	if Input.is_action_just_pressed("jump") && player.jumpsQuantity > 0 && !player.canWallSlide && doubleJumpTimer <= 0:
		stateMachine.ChangeState("DoubleJump")

func PhysicsUpdate(_delta) -> void:
	# Calcula a movimentação na horizontal, apenas se o Player estiver movendo-se em outra direção para fora da parede.
	if player.direction.x != 0 && player.direction.x == wallSide.x:
	# Altera a velocidade do Player gradualmente.
		player.velocity.x = lerp(player.velocity.x, (player.direction.x * player.entity.movementSpeed), player.movementAcceleration * _delta)
	else:
		# Caso não haja movimento, irá diminuir a velocidade gradualmente.
		player.velocity.x = lerp(player.velocity.x, 0.0, player.stopAcceleration * _delta)


func Exit() -> void:
	player.isJumping = false