extends CharacterBody2D

const SPEED = 128.0
const JUMP_VELOCITY = -314.0

var perform_jump : int

var health := 100

func _physics_process(delta):
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$Body.flip_h = velocity.x > 0
		if is_on_floor() : $Body.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() : $Body.play("idle")
	
	if is_on_floor():
		perform_jump = 2
		$Body.scale = Vector2(1, 1)
	else:
		velocity += get_gravity() * delta
		$Body.play("jump")
		$Body.scale = lerp($Body.scale, Vector2(1, 1), 0.1)
	
	if Input.is_action_just_pressed("ui_accept") and perform_jump:
		velocity.y = JUMP_VELOCITY
		perform_jump -= 1
		$Body.scale = Vector2(0.5, 1.5)
		$"/root/JumpSfx".play()
	
	move_and_slide()
	
	if position.y >= 191 : get_tree().reload_current_scene()
