
extends Node2D

var timeout_star #time before another star spawns
var timeout_asteroid #time before another asteroid spawns
var timeout_ufo
var dead_timer
var score = 0
var a_min = 0.1 #asteroid spawn times
var a_max = 3.8
var a_rate = 1.2
var s_min = 0.15 #star spawn times
var s_max = 1.3
var u_min = 15 #UFO spawn times
var u_max = 90

func _ready():
	set_fixed_process(true)
	#centers background in case of screen resizing
	get_node("Map/Background").set_pos(Vector2(get_viewport_rect().size.width/2, get_viewport_rect().size.height/2))
	dead_timer = get_node("Game/dead_time")
	randomize()
	timeout_asteroid = rand_range(a_min, a_max) / a_rate
	randomize()
	timeout_star = rand_range(s_min, s_max)
	randomize()
	timeout_ufo = rand_range(u_min, u_max)

func _fixed_process(delta):
	timeout_star -= delta
	timeout_asteroid -= delta
	timeout_ufo -= delta
	
	if (timeout_star < 0): #when spawn time runs out
		randomize()
		timeout_star = rand_range(s_min, s_max) #assign new random spawn time
		var star = preload("res://data/Scenes/star.scn").instance()
		star.set_pos(Vector2(randf()*get_viewport_rect().size.x, -5))
		add_child(star)
		
	if (timeout_asteroid < 0):
		randomize()
		timeout_asteroid = rand_range(a_min, a_max) / a_rate
		var asteroid = preload("res://data/Scenes/asteroid.scn").instance()
		asteroid.set_pos(Vector2(randf()*get_viewport_rect().size.x, -25))
		add_child(asteroid)
		
	if (timeout_ufo < 0):
		randomize()
		timeout_ufo = rand_range(u_min, u_max)
		var ufo = preload("res://data/Scenes/ufo.scn").instance()
		randomize()
		var rand_side = randi()%2-1
		ufo.set_pos(Vector2(get_viewport_rect().size.x * rand_side * -1, randf()*get_viewport_rect().size.y/4+250))
		if(rand_side == 0):
			rand_side = 1
		ufo.dir *= rand_side
		add_child(ufo)
		
	if(get_node("Player").is_dead == false): #dead_timer not active (not dead)
		score += delta
		get_node("Map/Labels/Score").set_text("Score: " + str(round(score)))
		get_node("Map/Labels/Fuel").set_text("Fuel: " + str(round(get_node("Player").fuel)) + "%")
		#get_node("Map/Labels/fuel").set_scale(Vector2(get_node("Map/Labels/fuel").get_scale().x - delta, get_node("Map/Labels/fuel").get_scale().y))

	if(dead_timer.get_time_left() < 0.1 && dead_timer.get_time_left() != 0):
		get_node("Game/Replay_Menu").show()
		
	a_rate += delta/150
	


func _on_Replay_Button_pressed():
	get_tree().reload_current_scene()
