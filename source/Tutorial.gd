extends Control

onready var anim_player = $AnimationPlayer


func _ready():
	pass
	
func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		queue_free()
	
