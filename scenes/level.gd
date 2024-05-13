extends Node


@export var syllable_scene: PackedScene
var upper_syllables: Array = []


func _ready():
	create_syllable()
	$Timer.start()


func _process(delta):
	for syllable in upper_syllables:
		syllable.position.x += 25 * delta


func _on_timer_timeout():
	create_syllable()


func create_syllable():
	var syllable = syllable_scene.instantiate()
	syllable.position.x = -100
	syllable.position.y = 50
	syllable.pressed.connect(_on_syllable_pressed)
	add_child(syllable)
	upper_syllables.append(syllable)


func _on_syllable_pressed():
	print("Syllable pressed.")
