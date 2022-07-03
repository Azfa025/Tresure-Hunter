extends CenterContainer

onready var tween = $Tween

func _ready():
	pass

func Game_Over():
	tween.interpolate_property(self,"rect_position:y", -230, 150, 1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()


func _on_RepeatButton_pressed():
	get_tree().change_scene("res://source/Level 1.tscn")


func _on_Kapten_Game_Over():
	Game_Over()
