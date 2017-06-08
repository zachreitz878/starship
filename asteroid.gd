
extends RigidBody2D

var rand_velocity = Vector2(rand_range(-40, 40), rand_range(100, 360))
var rot = rand_range(0, 359)
var rot_rate = rand_range(-200, 200)
var rand_scale = rand_range(0.65, 1.8)
var self_rotate = 1
var rand_h_flip = rand_range(0, 1)
var rand_v_flip = rand_range(0, 1)
var timeout = 1

func _ready():
	#randomize asteroid frame from sprite sheet
	var rand_frame = rand_range(0, 29)
	get_node("Sprite").set_frame(round(rand_frame))
	
	#randomize sprite flip orientation
	if(round(rand_h_flip) == 1):
		get_node("Sprite").set_flip_h(true)
	if(round(rand_v_flip) == 1):
		get_node("Sprite").set_flip_v(true)
	
	#set random starting angle
	set_rotd(rot)
	#set random velocity
	set_linear_velocity(rand_velocity)
	
	add_to_group("asteroid")
	set_fixed_process(true)

func _fixed_process(delta):
	
	#set size of asteroid
	set_scale(Vector2(rand_scale, rand_scale))
	get_node("CollisionShape2D").set_scale(Vector2(rand_scale, rand_scale))
	set_weight(get_weight() * rand_scale)
	
	#destory if it goes past end of screen or is alive for 10 seconds
	timeout -= delta / 10
	if (get_pos().y > get_viewport_rect().size.y + 25 || timeout < 0):
		queue_free()
	
	#rotate object while flying (better way to do this? asteroids do not change rotation after collisions)
	rot = rot + (delta * rot_rate)
	set_rotd(rot)