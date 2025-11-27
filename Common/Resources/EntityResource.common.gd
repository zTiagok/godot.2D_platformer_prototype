class_name EntityResource extends Resource

@export var maxHealth : float
@export var currentDamage : float
@export var movementSpeed : float
@export var jumpForce : float
@export var knockbackForce : float


var currentHealth : float
var isInvulnerable : bool
var isFalling : bool = false
var animationPlayer : AnimationPlayer


# Função utilizada para gerenciar o dano recebido na entidade.
func TakeDamage(damage : float) -> float:
	# Caso o dano seja maior que a vida atual, deduz a vida.
	if damage >= currentHealth:
		currentHealth -= damage;
	
	# Retorna o dano.
	return currentDamage