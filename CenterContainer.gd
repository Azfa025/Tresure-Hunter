extends CenterContainer

onready var tween = $Tween

func _on_Button3_pressed():
	tween.interpolate_property(self,"rect_position:x", -44, -450, 0.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
