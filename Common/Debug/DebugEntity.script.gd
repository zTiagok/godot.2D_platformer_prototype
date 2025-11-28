@icon("res://Common/Debug/Icons/bug-green.png")
extends Control

@export var stateLabel : Label
var stateMachine : StateMachine

func _ready() -> void:
	# Encontra e salva o State Machine.
	stateMachine = get_parent().find_child("StateMachine")
	
	# Conecta o sinal do State Machine para quando o state for alterado.
	stateMachine.SignalStateChanged.connect(OnStateChanged)

	# Inicia o texto do label com o state iniciado.
	stateLabel.text = "State: %s" % stateMachine.currentState.name


func OnStateChanged(newState: State) -> void:
	print("State: ", newState.name)
	
	# Altera o nome do state quando o sinal for disparado do "State Machine".
	stateLabel.text = "State: %s" % newState.name