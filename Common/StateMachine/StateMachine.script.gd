@icon("res://Common/StateMachine/Icons/spark-full-white.png")
class_name StateMachine extends Node


@export var initialState : State
var currentState : State
var stateList : Dictionary[String, State] = {}


signal SignalStateChanged(state: State)


func _ready() -> void:
  # Percorre todos os filhos do StateMachine
  for state : State in get_children():
    # Se atribui à eles.
    state.stateMachine = self

    # Salva o usuário da state machine no state.
    state.entity = get_parent()

    # E os guarda em uma lista.
    stateList[state.name] = state
  
  # Caso não exista um initial state, irá pegar o primeiro valor salvo na lista
  # e irá assina-lo.
  if !initialState:
    initialState = stateList.values()[0]

  # Quando houver um inital state, ele irá executa-lo e salva-lo como state atual.
  initialState.Enter()
  currentState = initialState


func _process(delta):
  if currentState:
    currentState.Update(delta)


func _physics_process(delta):
  if currentState:
    currentState.PhysicsUpdate(delta)


func ChangeState(newStateName: String) -> void:
  # Caso exista um novo estado, ele executará o "Exit" do estado atual.
  if newStateName != "":
    currentState.Exit()

    # O estado atual será alterado para este novo estado.
    currentState = stateList[newStateName]

    # E este estado chamará o "Enter".
    currentState.Enter()

    # Acessa a entidade e pede para trocar a animação do estado atual.
    currentState.entity.ChangeAnimation(newStateName)

    # Emite um sinal para quando o state for alterado
    SignalStateChanged.emit(stateList[newStateName])