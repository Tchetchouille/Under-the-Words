extends Node2D

@export var word : String
@export var text_color : Color
@export var outline_color : Color
@export var bold_font : FontFile

@onready var c_width = GlobalVariables.character_width
@onready var c_height = GlobalVariables.character_height

@onready var base_character = preload("res://Scenes/Levels/Bases/base_character.tscn")

var norm_position = {
	'x' : 0,
	'y' : 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_body(word)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if Input.is_action_pressed('move_up'):
		move('up')
	if Input.is_action_pressed('move_down'):
		move('down')
	if Input.is_action_pressed('move_left'):
		move('left')
	if Input.is_action_pressed('move_right'):
		move('right')


func create_body(string):
	var x = 0
	# Background
	# We multiply by 1.05 to have a margin
	$Background.size = Vector2(string.split().size() * c_width * 0.97, c_height * 1.05)
	# Text
	for character in string.split():
		var p_character = base_character.instantiate()
		var label = p_character.get_node('Control/Label')
		# In the case of the protag, I don't use special characters yet.
		label.text = character
		# Making it bold and colored
		label.add_theme_font_override('font', bold_font)
		label.add_theme_color_override('font_color', text_color)
		label.add_theme_color_override("font_outline_color", outline_color)
		p_character.position.x = x
		add_child(p_character)
		x += c_width

func move(direction):
	match direction:
		'up':
			# If not at the top of the space
			if not norm_position.y <= 0:
				# We check if there is space for the last character at y - 1
				if not (norm_position.x + word.length()) >= LevelManager.map[norm_position.y - 1].size():
					norm_position.y += -1
			else:
				# Put feedback here (sound, maybe animation)
				pass
		'down':
			# If not at the bottom of the space
			if not norm_position.y + 1 >= LevelManager.map.size():
				# We check if there is space for the last character at y + 1
				if not (norm_position.x + word.length()) >= LevelManager.map[norm_position.y + 1].size():
					norm_position.y += 1
				else:
					# Put feedback here (sound, maybe animation)
					pass
		'right':
			# We check if the wall is hit
			if not (norm_position.x + word.length() + 1) >= LevelManager.map[norm_position.y].size():
				norm_position.x += 1
			else:
				# Put feedback here (sound, maybe animation)
				pass
		'left':
			# We check if the wall is hit
			if not norm_position.x <= 0:
				norm_position.x += -1
			else:
				# Put feedback here (sound, maybe animation)
				pass
		_:
			pass
	# Updating position
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'position', Vector2(norm_position.x * GlobalVariables.character_width, norm_position.y * GlobalVariables.character_height), 0.1)
	#position.x = norm_position.x * GlobalVariables.character_width
	#position.y = norm_position.y * GlobalVariables.character_height
