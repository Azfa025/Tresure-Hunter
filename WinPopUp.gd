extends CenterContainer

onready var tween = $Tween

func _ready():
	pass

func Game_Win():
	tween.interpolate_property(self,"rect_position:y", -230, 150, 1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()




func _on_Area2D_body_entered(body):
	Game_Win()
