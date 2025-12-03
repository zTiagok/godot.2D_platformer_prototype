class_name Hitbox extends Area2D

func OnAreaEntered(area: Area2D):
  if area is Hitbox:
    print(area)
