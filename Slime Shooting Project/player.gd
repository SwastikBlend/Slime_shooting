extends CharacterBody2D


@onready var pause_menu = $Camera2D/PauseMenu
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
		
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused  

signal health_deplete

var health = 100.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 300
	move_and_slide()
	
	if velocity.length()>0.0:
		get_node("HappyBoo").play_walk_animation()
	else:
		get_node("HappyBoo").play_idle_animation()
		
	
	const DAMAGE = 30.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_deplete.emit()
			
