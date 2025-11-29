class_name EnvironmentGrass extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
  # Caso o sprite tenha o shader, ele irá duplica-lo para cada instância de
  # Grass, para que, quando houver alteração em um, não irá alterar todos os
  # Grass que não foram encostados.
  if sprite.material:
    sprite.material = sprite.material.duplicate()

    # Faz com que cada grama tenha uma movimentação inicial diferente.
    sprite.material.set("shader_parameter/windOffset", randf() * 100.0)