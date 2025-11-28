extends State


var player : Player
var timer : float

func Enter() -> void:
	player = entity

	# Cria um timer com base no tamanho da animação do "Dodge".
	timer = player.animationPlayer.current_animation_length

	# Altera a velocidade do player para ser 2.5x mais rápido que o movement speed.
	player.velocity.x = player.dodgeDirection.x * (player.entity.movementSpeed * 2.5)

	player.isDodging = true


func Update(_delta) -> void:
	# Faz o countdown do timer.
	timer -= _delta

	# Quando o timer terminar, sai do "Dodge" state.
	if timer <= 0:
		if player.direction.x != 0:
			stateMachine.ChangeState("Walk")
		else:
			stateMachine.ChangeState("Idle")


func Exit() -> void:
	player.isDodging = false