extends Node



func _on_Area2D_body_entered(body):
	if body.name == "Kapten":
		body.kembali_ke_awal(Vector2(180,370))
