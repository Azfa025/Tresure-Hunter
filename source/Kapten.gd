extends KinematicBody2D

signal Kapten_update_health(value)
signal Kapten_update_coin(value)
signal Game_Over()
signal Game_Win()

export var JUMP_FORCE = 320	#kekuatan lompat
const GRAVITASI = 10		#Percepatan gravitasi
const ACCELERATION = 5		#Percepatan
var movement = Vector2.ZERO	#Titik awal dan penentu arah
var max_speed = 200			#Batas kecepatan Kapten
var jump_count = 0			#variabel untuk menghitung jumlah lompatan
var air_jumped = false		#variable untuk melompat diudara
var get_hit = false
var coin_count = 0		#variable untuk menghitung jumlah coin yang didapat#variable untuk menghitung jumlah coin yang didapat
var isAttacking = false
var attack_count = 0 #variable untuk seberapa banyak serangan
var maks_nyawa  = 200
var nyawa = 200
var sudah_mati = false

onready var animSprite = $AnimatedSprite


func _ready():
	pass

func _physics_process(_delta):
	
	move_and_slide(movement,Vector2(0,-1))

	if !get_hit and Input.is_action_pressed("KANAN") and sudah_mati == false:
		movement.x += ACCELERATION
		movement.x = min(movement.x, max_speed)
		
		
	elif !get_hit and Input.is_action_pressed("KIRI") and sudah_mati == false:
		movement.x -= ACCELERATION
		movement.x = max(movement.x, -max_speed)
		
	else:
		movement.x = lerp(movement.x, 0 , 0.1)

	if is_on_ceiling():
		movement.y = 0

	if !get_hit and Input.is_action_just_pressed("LOMPAT") and sudah_mati == false:
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
		
	if Input.is_action_just_pressed("ATTACK") and attack_count == 0 and is_on_floor() and sudah_mati == false:
		isAttacking = true
		animSprite.play("attack1")
		$Attack_Area/CollisionShape2D.disabled = false
		attack_count += 1
		
	elif Input.is_action_just_pressed("ATTACK") and attack_count == 1 and is_on_floor() and sudah_mati == false:
		isAttacking = true
		animSprite.play("attack2")
		$Attack_Area/CollisionShape2D.disabled = false
		attack_count += 1
		
	elif Input.is_action_just_pressed("ATTACK") and attack_count == 2 and is_on_floor() and sudah_mati == false:
		isAttacking = true
		animSprite.play("attack3")
		$Attack_Area/CollisionShape2D.disabled = false
		attack_count = 0
		
	if Input.is_action_just_pressed("ATTACK") and attack_count == 0 and !is_on_floor() and sudah_mati == false:
		isAttacking = true
		animSprite.play("air_attack1")
		$AirAttackArea/CollisionShape2D.disabled = false
		movement.y = 0
		movement.x = 0
		attack_count += 1
		
	elif Input.is_action_just_pressed("ATTACK") and attack_count == 1 and !is_on_floor():
		isAttacking = true
		animSprite.play("air_attack2")
		$AirAttackArea/CollisionShape2D.disabled = false
		movement.y = 0
		movement.x = 0
		attack_count = 0
	
	if !get_hit:
		_animation_update()
	if nyawa > 200:
		nyawa = 200
	print(nyawa)

func _animation_update():
	#Animasi
	if is_on_floor():
		if movement.x < 2.5 and movement.x > -2.5 and isAttacking == false:
			animSprite.play("idle")
		else:
			if isAttacking == false:
				animSprite.play("run")
	else:
		if movement.y > 0 and isAttacking == false:
			animSprite.play("fall")
		else:
			if isAttacking == false:
				animSprite.play("jump")
	
	animSprite.flip_h = false
	$Attack_Area.scale.x = 1
	$AirAttackArea.scale.x = 1
	if movement.x < 0:
		animSprite.flip_h = true
		$Attack_Area.scale.x = -1
		$AirAttackArea.scale.x = -1
	
func _on_AnimatedSprite_animation_finished():
	if animSprite.animation == "attack1" or "attack2" or "attack3" or "air_attack1" or "air_attack2":
		$Attack_Area/CollisionShape2D.disabled = true
		$AirAttackArea/CollisionShape2D.disabled = true
		isAttacking = false
		attack_count = 0

func _ambil_coin():
	coin_count += 1
	nyawa += 20
	emit_signal("Kapten_update_health",float(nyawa)/float(maks_nyawa) * 100)
	emit_signal("Kapten_update_coin",str(coin_count))

func _start_game(pos):
	position = pos
	$Camera2D.position = Vector2.ZERO

func _hit():
	get_hit = true
	
	nyawa -= 50
	emit_signal("Kapten_update_health",float(nyawa)/float(maks_nyawa) * 100)
	
	animSprite.play("hit")
	if movement.x > 0:
		movement.x = -500
		movement.y = -200
	else:
		movement.x = 500
		movement.y = -200
	yield(get_tree().create_timer(0.2),"timeout")
	if nyawa <= 0:
		mati()
	else:
		get_hit = false

func mati():
	$AnimatedSprite.play("dead_ground")
	yield(get_tree().create_timer(0.2),"timeout")
#	get_tree().change_scene("res://source/Level 1.tscn")
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(2,false)
	emit_signal("Game_Over")
	sudah_mati = true

func nyemplung():
	nyawa -= 2000
	emit_signal("Kapten_update_health",float(nyawa)/float(maks_nyawa) * 100)
	mati()
	

func _lempar_pedang():
	pass

func _ambil_pedang():
	pass





