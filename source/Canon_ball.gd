extends Area2D

var kecepatan = 400
var arah = Vector2.LEFT

func _process(delta):
	translate(arah * kecepatan * delta)


func _on_Canon_ball_body_entered(body = "Kapten"):
	if body.name == "Kapten":
		body._hit()
	kecepatan = 0
	$Sprite.visible = false
	$Particles2D.emitting = true
	yield(get_tree().create_timer($Particles2D.lifetime),"timeout")
	queue_free()
