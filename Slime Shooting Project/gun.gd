extends Area2D


func _physics_process(delta):
	var enemies_range = get_overlapping_bodies()
	if enemies_range.size() > 0 :
		var target_enemy = enemies_range[0]
		look_at(target_enemy.global_position)


func _shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_BULLET = BULLET.instantiate()
	new_BULLET.global_position = %ShootingPoint.global_position
	new_BULLET.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_BULLET)


func _on_timer_timeout() -> void:
	_shoot()
