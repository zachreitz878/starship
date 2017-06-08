
extends RigidBody2D

var velocity = Vector2(100, 0)
var dir = 1
var taken = false
var sounds
var ufo_sound

func _ready():
	set_fixed_process(true)
	self.add_to_group("powerup")
	sounds = get_node("SamplePlayer")
	if(get_node("Sprite").is_visible()):
		ufo_sound = sounds.play("ufo_noise",true)
	

func _fixed_process(delta):
	self.set_pos(self.get_pos() + velocity * delta * dir)
		
	#delete when past viewport
	if (self.get_pos().x > get_viewport_rect().size.x + 10):
		queue_free()
		
func _exit_tree():
	if(get_node("Sprite").is_visible()):
		sounds.stop(ufo_sound)