extends State

var player : Player

func Enter() -> void:
	player = entity


func Update(_delta) -> void:
	# Caso o botão de pulo seja pressionado.
	if Input.is_action_just_pressed("jump") && !player.entity.isFalling:
		stateMachine.ChangeState("Jump")


func PhysicsUpdate(_delta) -> void:
	# Caso o player não esteja no chão, irá trocar seu state para "Fall".
	if !player.is_on_floor() && !player.entity.isJumping:
		stateMachine.ChangeState("Fall")

	if player.direction.x != 0:
		# Caso o player se movimente, troque o estado para "Walk".
		stateMachine.ChangeState("Walk")
	else:
		## TO-DO: VER DE COLOCAR UM LERP PARA PERDER VELOCIDADE COM O TEMPO!
		# Caso não, zere a velocidade.
		player.velocity.x = 0
