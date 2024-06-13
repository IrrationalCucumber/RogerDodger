extends Node
@export var missile_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MissileTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Tank.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("missile", "queue_free")


func _on_missile_timer_timeout():
	var missile = missile_scene.instantiate()
	var missile_spawn_location = $MissilePath/MissileSpawnLocation
	missile_spawn_location.progress_ratio = randf()
	var direction = missile_spawn_location.rotation + PI /2
	missile.position = missile_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4 )
	missile.rotation = direction
	var velocity = Vector2(randf_range(200.0, 350.0), 0.0)
	missile.linear_velocity = velocity.rotated(direction)
	add_child(missile)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MissileTimer.start()
	$ScoreTimer.start()
