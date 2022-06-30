extends Node



func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		get_tree().change_scene("res://Main.tscn")
