extends Node

signal Game_Over()

onready var kapten = $Kapten
onready var pos = $start_position
onready var health_progress = $GUI/Bar_Nyawa/TextureProgress
onready var Coin_count = $GUI/Coin_count/Label

func _ready():
	kapten._start_game(pos.position)

func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		kapten.nyemplung()

func _on_Kapten_Kapten_update_health(value):
	health_progress.value = value

func _on_Kapten_Kapten_update_coin(value):
	Coin_count.text = value


