extends Node2D

@onready var obstacle_spawner = $ObstacleSpawner
@onready var ui = $UI

const NINJA_START_POS = Vector2i(150, 485)
const CAMERA_POS = Vector2i(640, 360)
const MAX_SPEED: float = 25.0
const START_SPEED: float = 5.0
const SPAWN_SPEED: float = 300.0
const SPEED_MODIFIER: int = 5000
var speed: float
var screen_size: Vector2i
var score = 0
var game_running = false
var high_score = 0

func _ready() -> void:
	new_game()
	$GameOver.get_node("Button").pressed.connect(new_game)
	screen_size = get_window().size
	
func start_game():
	$UI.get_node("StartLabel").hide()
	game_running = true
	
func new_game():
	#reset variables
	for obstacle in obstacle_spawner.get_children():
		obstacle.queue_free()
	game_running = false
	score = 0
	get_tree().paused = false
	$Player.position = NINJA_START_POS
	$Player.velocity = Vector2i(0, 0)
	$Camera2D.position = CAMERA_POS
	$Ground.position = Vector2i(600, 600)
	
	#reset_hud
	$UI.get_node("StartLabel").show()
	$GameOver.hide()
	
func _process(delta):
	# Start game pressing space
	if not game_running:
		if Input.is_action_just_pressed("ui_accept"):
			start_game()
		return
		
	# Increase score
	score += delta * 10
	ui.update_score(score)
	
	# Increase speed
	speed = START_SPEED + score / SPEED_MODIFIER
	$Player.position.x += speed
	$Camera2D.position.x += speed
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.01171875:
		$Ground.position.x += screen_size.x
		
func check_high_score():
	if score > high_score:
		high_score = score
		$UI.get_node("HighScoreLabel").text = "High score: " + str(int(high_score))
func game_over():
	check_high_score()
	get_tree().paused = true
	game_running = false
	$GameOver.show()
