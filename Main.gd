extends Node

onready var kapten = $Kapten
onready var pos = $start_position

func _ready():
	kapten.start_game(pos.position)

func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		body.start_game(pos.position)
