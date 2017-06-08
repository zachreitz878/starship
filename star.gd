
extends RigidBody2D

var twinkle_time = rand_range(0.1, 1)
var rand_velocity = Vector2(0, rand_range(80, 175))
var taken = false
var sprite

func _ready():
	set_fixed_process(true)
	self.add_to_group("collectable")
	sprite = get_node("Sprite")

func _fixed_process(delta):
	#move downward
	self.set_pos(self.get_pos() + rand_velocity * delta)
	
	#star twinkle animation lol
	twinkle_time -= delta
	if(twinkle_time <= 0):
		if(sprite.get_opacity() == 1):
			sprite.set_opacity(0.25)
			twinkle_time = 0.1
		else:
			sprite.set_opacity(1)
			twinkle_time = rand_range(0.1,1)
		
	#delete when past viewport
	if (self.get_pos().y > get_viewport_rect().size.y + 10):
		queue_free()