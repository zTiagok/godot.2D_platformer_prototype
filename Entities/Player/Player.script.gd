@icon("res://Entities/Player/Icons/person-blue.svg")
class_name Player extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var wallRayscast : Array[RayCast2D] = [$Raycast/WallRaycastTop, $Raycast/WallRaycastBottom]


@export var entity : EntityResource
var direction : Vector2

@export_group("Player Settings")
@export var movementAcceleration : float = 12.0
@export var stopAcceleration : float = 8.0
@export var wallJumpForce : Vector2 = Vector2(20.0, 150.0)
var dodgeDirection : Vector2
var jumpsQuantity : int = 2
var isFalling : bool = false
var isJumping : bool = false
var isDodging : bool = false
var isWallSliding : bool = false
var canWallSlide : bool = true
var wallSlideTimer : float = 0.3


func _ready() -> void:
	# Salva o Player ao GameManager.
	LocalGameManager.player = self


func _process(_delta: float) -> void:
	# Pega os inputs que o player está apertando.
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	MonitoreJumpQuantity()
	MonitoreWallSlide(_delta)


func _physics_process(_delta: float) -> void:
	# Aplica gravidade...
	if !isWallSliding:
		# Caso não esteja no "Wall Slide", a gravidade é aplicada normalmente.
		velocity.y -= LocalGameManager.gravity * _delta

	else:
		# Caso esteja, ela será diminuida para dar uma melhor sensação ao state.
		velocity.y -= LocalGameManager.gravity * _delta * 0.75 

	# Ativa a física.
	move_and_slide()


# Função para monitorar se o Player está no chão e assim, habilitar os pulos novamente.
func MonitoreJumpQuantity():
	# Caso esteja encostado no chão, reseta o valor da quantidade de pulos.
	if is_on_floor():
		jumpsQuantity = 2


# Função para monitorar se o Player pode fazer um outro Wall Slide.
func MonitoreWallSlide(_delta: float):
	# Caso não possa, um timer irá se iniciar.
	if !canWallSlide:
		wallSlideTimer -= _delta

		# Quando o timer terminar, habilita o Player  fazer outro Wall Slide e reseta
		# o timer.
		if wallSlideTimer <= 0:
			canWallSlide = true 
			wallSlideTimer = 0.3


# Função utilizada para saber de qual lado da parede o Player está encostado.
func DetectWallSide() -> Vector2:
	var currentCollision : KinematicCollision2D

	# Percorre todas as colisões do Player.
	for collision in get_slide_collision_count():
		# Pega a primeira colisão detectada no Player.
		currentCollision = get_slide_collision(collision)

	if currentCollision:
		# Retorna o vetor do lado no qual está sendo encostado.
		return currentCollision.get_normal()
	else:
		return Vector2.ZERO

func ChangeDirection() -> void:
	# Altera a direção do sprite dependendo da direção do player.
	if direction.x > 0:
		sprite.scale.x = 1

	elif direction.x < 0:
		sprite.scale.x = -1
		

func ChangeAnimation(animationName: String) -> void:
	animationPlayer.play(animationName)
