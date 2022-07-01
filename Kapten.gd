extends KinematicBody2D


export var JUMP_FORCE = 300
const GRAVITASI = 10
const ACCELERATION = 5
var movement = Vector2.ZERO
var max_speed = 200
var jump_count = 0
var air_jumped = false

var coin_count = 0


var attack_count = 0

var screen_size
onready var animSprite = $AnimatedSprite


func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(_delta):
	
	move_and_slide(movement,Vector2(0,-1))

	if Input.is_action_pressed("KANAN"):
		movement.x += ACCELERATION
		movement.x = min(movement.x, max_speed)
		
	elif Input.is_action_pressed("KIRI"):
		movement.x -= ACCELERATION
		movement.x = max(movement.x, -max_speed)

	else:
		movement.x = lerp(movement.x, 0 , 0.1)

	if is_on_ceiling():
		movement.y = 0

	if Input.is_action_just_pressed("LOMPAT"):
		if is_on_floor():
			movement.y = -JUMP_FORCE
		elif !air_jumped:
			movement.y = -JUMP_FORCE
			air_jumped = true
	
	elif is_on_floor():
		movement.y = GRAVITASI
		air_jumped = false
		
	else:
		movement.y += GRAVITASI
	
	
	animation_update()

func animation_update():
	#Animasi
	if is_on_floor():
		if movement.x < 2.5 and movement.x > -2.5:
			animSprite.play("idle")
		else:
			animSprite.play("run")
	else:
		if movement.y > 0:
			animSprite.play("fall")
		else:
			animSprite.play("jump")
	
	animSprite.flip_h = false
	if movement.x < 0: animSprite.flip_h = true

func ambil_coin():
	coin_count += 1
	print(coin_count)
