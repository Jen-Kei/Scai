extends Control


@onready var inputBtnScene = preload("res://escUI/input_button.tscn")
@onready var actionList = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList


var isRemapping = false
var actionToRemap = null
var remappingBtn = null

var input_actions = {
	"interact": "Pick Up",
	"drop": "Drop Item",
	"one": "Slot 1",
	"two": "Slot 2",
	"three": "Slot 3",
	"four": "Slot 4",
	"five": "Slot 5",
}

func _ready():
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in actionList.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = inputBtnScene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")

		action_label.text = input_actions[action]

		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""

		actionList.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !isRemapping:
		isRemapping = true
		actionToRemap = action
		remappingBtn = button
		button.find_child("LabelInput").text = "Press a key..."

func _input(event):
	if isRemapping:
		if(event is InputEventKey ||(event is InputEventMouseButton && event.pressed)):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(actionToRemap)
			InputMap.action_add_event(actionToRemap, event)
			_update_action_list(remappingBtn, event)

			isRemapping = false
			actionToRemap = null
			remappingBtn = null

			accept_event()


func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

func _on_reset_button_pressed():
	_create_action_list()


func _on_done_button_down():
	get_parent().queue_free()
