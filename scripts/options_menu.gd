extends Control



func _on_back_pressed():
	get_tree().change_scene_to_file(Global.prevScene)
	Global.prevScene = "res://scenes/options_menu.tscn"
