extends KinematicBody2D

export var JUMP_FORCE = 300
const GRAVITASI = 10
const ACCELERATION = 50
var movement = Vector2.ZERO
var arah = 1

onready var pivot = $pivot
onready var raycast = $pivot/RayCast2D

func _ready():
	pass
func _physics_process(delta):
	move_and_slide(movement, Vector2.UP)
	
	if is_on_wall() or !raycast.is_colliding():
		arah  = arah * -1
		pivot.scale.x = pivot.scale.x * -1
		
	movement.x = ACCELERATION * arah
	
	if is_on_floor():
		movement.y = GRAVITASI
	else:
		movement.y  += GRAVITASI
		
	update_animasi_hiu()

func update_animasi_hiu():
	if is_on_floor():
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("fall")
	
	$AnimatedSprite.flip_h = true
	if arah == -1:
		$AnimatedSprite.flip_h = false


func _on_Area_damage_body_entered(body):
	if body.name == "Kapten":
		body.hit()
