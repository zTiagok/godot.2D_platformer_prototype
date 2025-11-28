extends State

var player : Player

func Enter() -> void:
  player = entity
  player.isJumping = true

  # Diminui a quantidade de pulos utilizados.
  player.jumpsQuantity -= 1

	# Aplica o segundo pulo ao entrar no estado com base na força do pulo.
  player.velocity.y = -player.entity.jumpForce

func Update(_delta) -> void:
  # Habilita alterar a direção do sprite.
  player.ChangeDirection()

  # Se a velocidade vertical do player passar do limiar de 0 (No caso, está caindo),
  # ele altera o state para o "Fall".
  if player.velocity.y >= 0:
    stateMachine.ChangeState("Fall")

  # Caso o player esteja encostando na parede.
  if player.is_on_wall() && player.canWallSlide:
    stateMachine.ChangeState("WallSlide")
    

func PhysicsUpdate(_delta) -> void:
  # Calcula a movimentação na horizontal.
  if player.direction.x != 0:
    # "movementSpeed" é multiplicado por 100 apenas para utilizar números menores
    # no editor.
    player.velocity.x = player.direction.x * (player.entity.movementSpeed * 100) * _delta
  else:
    player.velocity.x = 0


func Exit() -> void:
  player.isJumping = false