extends Node

@export var mob_scene: PackedScene
var score = 0



func game_over():
	$Music.stop()
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUB.show_game_over()
	$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTime.start()
	$HUB.update_score(score)
	$HUB.show_message("Get Ready!")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()



func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()


	var direction = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 350.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)


func _on_start_time_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUB.update_score(score)

