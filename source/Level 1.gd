extends Node

onready var kapten = $Kapten
onready var pos = $start_position
onready var health_progress = $CanvasLayer/Bar_Nyawa/TextureProgress
onready var Coin_count = $CanvasLayer/Coin_count/Label

func _ready():
	kapten._start_game(pos.position)

func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		body.get_tree().change_scene("res://source/Level 1.tscn")


func _on_Kapten_Kapten_update_health(value):
	health_progress.value = value





func _on_Kapten_Kapten_update_coin(value):
	Coin_count.text = value
