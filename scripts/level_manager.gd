extends Node


@export var player : CharacterBody2D
@export var ui : CanvasLayer


func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().paused = true
		ui.get_node("Pause").show()

func _on_pm_play_pressed():
	get_tree().paused = false
	ui.get_node("Pause").hide()
