class_name PlayerWalkState extends State

var player : Player

func Enter() -> void:
	player = entity

func PhysicsUpdate(_delta) -> void:
	player.ChangeDirection()

	# Calcula a movimentação na horizontal.
	if player.direction.x != 0:
		# "movementSpeed" é multiplicado por 100 apenas para utilizar números menores
		# no editor.
		player.velocity.x = player.direction.x * (player.entity.movementSpeed * 100) * _delta

	else:
		# Caso não aperte nada, volte para o "Idle" state.
		stateMachine.ChangeState("Idle")

	# Ativa a física.
	player.move_and_slide()