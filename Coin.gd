extends Area2D

func _on_Coin_body_entered(body):
	if body.name == "Kapten":
		body.ambil_coin()
	var _coin_effect = preload("res://Coin_effect.tscn")
	var coin_effect = _coin_effect.instance()
	coin_effect.transform = self.transform
	get_tree().current_scene.add_child(coin_effect)
	
	queue_free()

