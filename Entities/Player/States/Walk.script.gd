extends State

var player : Player

func Enter() -> void:
	player = entity

func Update(_delta) -> void:
	# Habilita alterar a direção do sprite.
	player.ChangeDirection()

	# Caso o botão de pulo seja pressionado.
	if Input.is_action_just_pressed("jump") && !player.entity.isFalling:
		stateMachine.ChangeState("Jump")


func PhysicsUpdate(_delta) -> void:	
	# Caso o player não esteja no chão, irá trocar seu state para "Fall".
	if !player.is_on_floor() && !player.entity.isJumping:
		stateMachine.ChangeState("Fall")

	# Calcula a movimentação na horizontal.
	if player.direction.x != 0:
		# "movementSpeed" é multiplicado por 100 apenas para utilizar números menores
		# no editor.
		player.velocity.x = player.direction.x * (player.entity.movementSpeed * 100) * _delta
	else:
		# Caso não aperte nada, volte para o "Idle" state.
		stateMachine.ChangeState("Idle")