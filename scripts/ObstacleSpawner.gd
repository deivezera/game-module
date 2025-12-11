extends Node

var obstacle_scene = preload("res://scenes/Obstacle.tscn")
var spawn_timer = 0.0
var spawn_interval = 2.0
var game_speed = 0.0
var screen_size: Vector2i
var ground_height: int
@onready var player = $"../Player"
@onready var game = get_parent()
func _ready(): 
	#initialize screen size
	screen_size = get_window().size
func _process(delta):
	# Update spawn timer
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_obstacle()
		reset_spawn_timer()

func reset_spawn_timer():
	#randomize spawn interval between 0.5 and 3 seconds
	spawn_interval = randf_range(0.5, 3.0)
	spawn_timer = spawn_interval

func spawn_obstacle():
	if obstacle_scene:
		#instantiate obstacle and spawn it offscreen to the right
		var obstacle = obstacle_scene.instantiate()
		var obj_x: int = player.position.x + screen_size.x
		obstacle.position = Vector2i(obj_x, 600)
		obstacle.body_entered.connect(hit_obs) 
		add_child(obstacle)

func hit_obs(body):
	# Handle collision with player
	if body.name == "Player":
		game.game_over()
	
