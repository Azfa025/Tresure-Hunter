extends Area2D



func _on_Spike_body_entered(body = "Kapten"):
	if body.get_hit == false:
		body._hit()
	
