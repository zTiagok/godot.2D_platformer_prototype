extends State

var player : Player

func Enter() -> void:
	player = entity

	player.entity.isFalling = true


func Update(_delta) -> void:
	# Habilita alterar a direção do sprite.
	player.ChangeDirection()
	

func PhysicsUpdate(_delta) -> void:
	# Se o Player estiver no chão, altera o estado dele.
	if player.is_on_floor():
		if player.direction.x == 0:
			stateMachine.ChangeState("Idle")
		else:
			stateMachine.ChangeState("Walk")

	# Calcula a movimentação na horizontal.
	if player.direction.x != 0:
		# "movementSpeed" é multiplicado por 100 apenas para utilizar números menores
		# no editor.
		player.velocity.x = player.direction.x * (player.entity.movementSpeed * 100) * _delta
	else:
		player.velocity.x = 0

	# Caso o Player pule novamente, vá para o Double Jump.
	if Input.is_action_just_pressed("jump") && player.jumpsQuantity > 0:
		stateMachine.ChangeState("DoubleJump")


func Exit() -> void:
	player.entity.isFalling = false