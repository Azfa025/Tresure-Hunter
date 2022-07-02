extends KinematicBody2D

export var JUMP_FORCE = 300
const GRAVITASI = 10
const ACCELERATION = 50
var movement = Vector2.ZERO
var arah = 1

export var nyawa_hiu = 3

var hiu_get_hit = false

onready var pivot = $pivot
onready var raycast = $pivot/RayCast2D

func _ready():
	pass
func _physics_process(delta):
	
	if is_on_wall() or !raycast.is_colliding():
		arah  = arah * -1
		pivot.scale.x = pivot.scale.x * -1
		
	if hiu_get_hit == false:
		movement.x = ACCELERATION * arah
	
	if is_on_floor():
		movement.y = GRAVITASI
	else:
		movement.y  += GRAVITASI
	
	move_and_slide(movement, Vector2.UP)
	
	if !hiu_get_hit:
		_update_animasi_hiu()

func _update_animasi_hiu():
	if is_on_floor() and hiu_get_hit == false:
		$AnimatedSprite.play("run")
	else:
		if hiu_get_hit == false:
			$AnimatedSprite.play("fall")
	
	$AnimatedSprite.flip_h = true
	if arah == -1 :
		$AnimatedSprite.flip_h = false

func _on_Area_damage_body_entered(body):
	if body.name == "Kapten":
		body._hit()
	elif body.name == "Attack_Area":
		print("AW")
		
func _hiu_get_hit():
	hiu_get_hit = true
	$AnimatedSprite.play("hit")
	nyawa_hiu -= 1
	
	if movement.x > 0:
		movement.x = 0
		movement.y = -500
		
	else:
		movement.x = 0
		movement.y = -500
	yield(get_tree().create_timer(1),"timeout")
	hiu_get_hit = false
	
	if nyawa_hiu <= 0:
		hiu_get_hit = true
		$AnimatedSprite.play("dead_hit")
		_hiu_mati()

func _hiu_mati():
	
	set_collision_layer_bit(2,false)
	set_collision_mask_bit(0, false)
	$Area_damage.set_collision_layer_bit(2,false)
	$Area_damage.set_collision_mask_bit(0,false)
	yield(get_tree().create_timer(0.3),"timeout")
	queue_free()


func _on_Area_damage_area_entered(area):
	if area.is_in_group("sword") and not hiu_get_hit:
		_hiu_get_hit()
		
		
