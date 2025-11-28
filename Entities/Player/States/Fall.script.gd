extends State

var player : Player

func Enter() -> void:
	player = entity

	player.isFalling = true


func Update(_delta) -> void:
	# Habilita alterar a direção do sprite.
	player.ChangeDirection()

	# Caso o Player pule novamente, vá para o Double Jump.
	if Input.is_action_just_pressed("jump") && player.jumpsQuantity > 0:
		if player.jumpsQuantity == 1:
			stateMachine.ChangeState("DoubleJump")

		if player.jumpsQuantity >= 2:	
			stateMachine.ChangeState("Jump")
	

func PhysicsUpdate(_delta) -> void:
	# Se o Player estiver no chão, altera o estado dele.
	if player.is_on_floor():
		if player.direction.x == 0:
			stateMachine.ChangeState("Idle")
		else:
			stateMachine.ChangeState("Walk")

	# Calcula a movimentação na horizontal.
	if player.direction.x != 0:
    # Altera a velocidade do Player gradualmente.
		player.velocity.x = lerp(player.velocity.x, player.direction.x * player.entity.movementSpeed, player.movementAcceleration * _delta)
	else:
		# Caso não haja movimento, irá diminuir a velocidade gradualmente.
		player.velocity.x = lerp(player.velocity.x, 0.0, player.stopAcceleration * _delta)

	# Caso o player esteja encostando na parede.
	if player.is_on_wall() && player.canWallSlide:
		stateMachine.ChangeState("WallSlide")


func Exit() -> void:
	player.isFalling = false