extends enemy

enum DIRECTION {LEFT = -1, RIGHT = 1}

@export var walking_direction: DIRECTION
@export var enemy_type = "snail"

var state

@onready var sprite_2d = $Sprite2D
@onready var floor_left = $floor_left
@onready var floor_right = $floor_right
@onready var wall_left = $wall_left
@onready var wall_right = $wall_right

func _ready():
	$enemy_stats.enemy_type = enemy_type
	velocity.y = 8
	state = walking_direction

@warning_ignore("unused_parameter")
func _physics_process(delta):
	match state:
		DIRECTION.RIGHT:
			velocity.x = max_speed
			if not floor_right.is_colliding() or wall_right.is_colliding():
				state = DIRECTION.LEFT
		
		DIRECTION.LEFT:
			velocity.x = -max_speed
			if not floor_left.is_colliding() or wall_left.is_colliding():
				state = DIRECTION.RIGHT
	sprite_2d.scale.x = -sign(velocity.x)
	move_and_slide()
