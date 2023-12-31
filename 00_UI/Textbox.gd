extends CanvasLayer
#textbox.gd

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextBoxContainer
onready var start_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}


var current_state = State.READY
var text_queue = []

func _ready():
	print("Starting state: State.READY")
	hide_textbox()

func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				get_tree().paused = true
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1
				$Tween.remove_all()
				end_symbol.text = "."
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()


func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	get_tree().paused = false

func show_textbox():
	start_symbol.text = ""
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed():
	end_symbol.text = "."
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Textbox Ready,")
		State.READING:
			print("Textbox Reading ...")
		State.FINISHED:
			print("Text Finished.")
