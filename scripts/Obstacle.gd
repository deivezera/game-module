extends Area2D

var speed = 0.0

func _ready():
	add_to_group("obstacle")
	var notifier = VisibleOnScreenNotifier2D.new()
	# Set a rect that covers the obstacle (approximate based on sprite)
	notifier.rect = Rect2(-50, -50, 100, 100)
	add_child(notifier)
	notifier.screen_exited.connect(queue_free)

func _process(delta):
	position.x -= speed * delta
