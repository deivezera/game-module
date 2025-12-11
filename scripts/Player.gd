extends CharacterBody2D

const JUMP_VELOCITY = -1400.0
const GRAVITY = 4200.0
	
@onready var animated_sprite = $AnimatedSprite2D
@onready var game = get_parent()

func _physics_process(delta):
	velocity.y += GRAVITY * delta # Use += for gravity accumulation
	
	if not game.game_running:
		animated_sprite.play("IDLE")
	else:
		if is_on_floor():
			animated_sprite.play("RUN")
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_VELOCITY
				animated_sprite.play("JUMP")
		else:
			animated_sprite.play("JUMP")
			
	move_and_slide()
