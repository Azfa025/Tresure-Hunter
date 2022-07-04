extends Node

onready var tween = $CanvasLayer/Control/CenterContainer/Tween

func _on_Button_pressed():
	get_tree().change_scene("res://source/Level 1.tscn")


func _on_Button2_pressed():
	get_tree().quit()



