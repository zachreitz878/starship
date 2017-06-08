
extends Node2D

var sounds
var music
var timer

func _ready():
	sounds = get_node("SamplePlayer")
	sounds.set_default_volume(0.7)
	timer = get_node("Timer")
	music = get_node("StreamPlayer")
	music.set_volume(5)
	music.set_loop(true)
	music.play()
	set_process(true)

func _on_Play_pressed():
	music.stop()
	sounds.play("game_start")
	timer.start()

func _on_Scores_pressed():
	print("scores")
	
func _process(delta):
	if(timer.get_time_left() < 1 && timer.get_time_left() > 0):
		get_tree().change_scene("res://data/Scenes/main_scene.scn")