extends Panel

@export var cam_name:String

signal change_camera(_cam_name)

@warning_ignore("unused_parameter")
func _on_player_sensor_body_entered(body):
	change_camera.emit(cam_name)
