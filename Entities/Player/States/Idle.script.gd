extends State

var player : Player

func Enter() -> void:
	player = entity


func PhysicsUpdate(_delta) -> void:
	if !player.is_on_floor():
		stateMachine.ChangeState("Fall")

	if player.direction.x != 0:
		# Caso o player se movimente, troque o estado para "Walk".
		stateMachine.ChangeState("Walk")

	else:
		## TO-DO: VER DE COLOCAR UM LERP PARA PERDER VELOCIDADE COM O TEMPO!
		# Caso não, zere a velocidade.
		player.velocity.x = 0
