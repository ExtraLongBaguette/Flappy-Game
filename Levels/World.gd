extends Node2D

onready var pipe_timer = get_node("pipe_timer")
var pipe = preload("res://Objects/Pipe.tscn")
var pipes = []
var difficulty = 1
onready var background = get_node("ParallaxBackground")
onready var floor_texture = get_node("Floor/ParallaxBackground")
var player_alive = true
var game_started = false
var score = 0
onready var ui_layer = get_node("ui_layer")
var score_display = preload("res://Objects/UI_elements/Score_display.tscn")
var game_over_screen = preload("res://Objects/UI_elements/Game_over_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


func _process(delta: float) -> void:
	if player_alive:
		background.scroll_offset.x -= 1
		floor_texture.scroll_offset.x -= 2
		
func start_game() -> void:
	create_pipe(0)
	pipe_timer.start()
	ui_layer.add_child(score_display.instance())

func create_pipe(var game_difficulty) -> void:
	var p = pipe.instance()
	pipes.append(p)
	p.position = Vector2(300,200)
	p.difficulty = game_difficulty
	add_child(p)

func stop_game() -> void:
	ui_layer.add_child(game_over_screen.instance())
	pipe_timer.stop()
	for p in pipes:
		if p != null:
			p.active = false

func _on_pipe_timer_timeout() -> void:
	create_pipe(difficulty)
	pipe_timer.start()

func add_score() -> void:
	score += 1
	get_node("ui_layer/Score_display").get_node("CenterContainer/Label").text = str(score)
