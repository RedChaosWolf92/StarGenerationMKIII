extends Camera2D

var zoomSpeed: float = 0.09
var zoomMin: float = .05
var zoomMax: float = 7.25
var dragSensitivity: float = 1.0


func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position -= event.relative * dragSensitivity / zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoomSpeed,zoomSpeed) * zoom
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoomSpeed,zoomSpeed) * zoom
		zoom = clamp(zoom, Vector2(zoomMin,zoomMin), Vector2(zoomMax, zoomMax))
