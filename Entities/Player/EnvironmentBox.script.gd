extends Area2D

var sprite : Sprite2D
var player : Player

func OnAreaEntered(area: Area2D) -> void:
	# Procura pela scene "Grass"
	if area.get_parent() is EnvironmentGrass:
		# Pega o shader em seu sprite e altera suas variáveis.
		sprite = area.get_parent().sprite

		# Salva o Player na variável.
		player = LocalGameManager.player

		# Duração fixa para o Tween.
		# var fixedDuration : float = 2.5;
		
		# Aplica uma animação.
		# TweenShader(sprite, "shader_parameter/speed", 1.0, 20.0, fixedDuration)



# Utilizado para fazer um Tween no Shader, alterando suas variáveis/animação de forma mais fluída.
func TweenShader(materialOwner: Node2D, materialVariable: String, startValue: float, finalValue: float, duration: float) -> Tween:
	var tween: Tween = get_tree().create_tween()

	# Reseta o valor para o inicial, para assim começar a animação novamente.
	materialOwner.material.set(materialVariable, startValue)

	# Aqui é feito um tween dentro de uma função qualquer, na qual o "value",
	# será alterado, iniciando com o "startValue", indo até o "finalValue" dentro
	# do tempo de "duration".
	tween.tween_method(
		func(value): materialOwner.material.set(materialVariable, value),
		startValue,
		finalValue,
		duration
	)

	# Reseta a animação para os valores iniciais.
	tween.tween_method(
		func(value): materialOwner.material.set(materialVariable, value),
		finalValue,
		startValue,
		duration
	)

	return tween
