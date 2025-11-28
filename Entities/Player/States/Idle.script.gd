extends State

var player : Player

@export var stopAccelerationSpeed: float = 10.0

func Enter() -> void:
	player = entity


func Update(_delta) -> void:
	# Caso o botão de pulo seja pressionado.
	if Input.is_action_just_pressed("jump") && !player.isFalling && player.jumpsQuantity > 0:
		stateMachine.ChangeState("Jump")


func PhysicsUpdate(_delta) -> void:
	# Caso o player não esteja no chão, irá trocar seu state para "Fall".
	if !player.is_on_floor() && !player.isJumping:
		stateMachine.ChangeState("Fall")

	if player.direction.x != 0:
		# Caso o player se movimente, troque o estado para "Walk".
		stateMachine.ChangeState("Walk")
	else:
		# Caso não, aplica uma aceleração para diminuir a velocidade até 0 (Parado).
		player.velocity.x = lerp(player.velocity.x, 0.0, stopAccelerationSpeed * _delta)
