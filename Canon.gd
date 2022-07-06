extends StaticBody2D

onready var raycast = $RayCast2D
onready var anim_tree = $AnimationTree
var canon_ball = preload("res://source/Canon_ball.tscn")

onready var statemachine = anim_tree["parameters/playback"]

func _process(delta):
	var lihat_kapten = raycast.is_colliding()
	if lihat_kapten:
		statemachine.travel("shoot")

func tembak():
	print("kanon boru")
	var _canon_ball = canon_ball.instance()
	_canon_ball.position = $Position2D.global_position
	if scale.x == -1:
		_canon_ball.arah = Vector2.RIGHT
	get_tree().current_scene.add_child(_canon_ball)
