extends Node

signal Game_Over()

onready var kapten = $Kapten
onready var pos = $start_position
onready var health_progress = $GUI/Bar_Nyawa/TextureProgress
onready var Coin_count = $GUI/Coin_count/Label
onready var label2 = $Label2

func _ready():
	kapten._start_game(pos.position)

func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		kapten.nyemplung()

func _on_Kapten_Kapten_update_health(value):
	health_progress.value = value

func _on_Kapten_Kapten_update_coin(value):
	Coin_count.text = value




func _on_MenutButton_pressed():
	get_tree().change_scene("res://Title_Screen.tscn")


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Title_Screen.tscn")


func _on_Troll_Area_body_entered(body = "Kapten"):
	label2.text = "NGEYEL BANGET DAH"
