extends VideoPlayer
class_name DiscordNode

@onready var avatar := $SubViewport/PanelContainer/HBoxContainer/Avatar
@onready var username := $SubViewport/PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/username
@onready var global_name := $SubViewport/PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/globalname
@onready var status_lbl := $SubViewport/PanelContainer/HBoxContainer/VBoxContainer/status
@onready var http := $HTTPRequest
@onready var timer := $Timer

func _ready() -> void:
	update()

func update() -> void:
	var discord = await RaccoonLiveApi.get_discord()
	if discord == null:
		hide()
		return
	else:
		show()
	
	username.text = discord["DisplayName"]
	global_name.text = "(" + discord["Username"] + ")"
	var status = discord["Status"]
	var activity = discord["Activity"]
	status_lbl.text = activity if activity != "Custom Status" and activity != "" else status
	http.request(discord["Avatar"])


func _on_http_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var image := Image.new()
		var res := image.load_png_from_buffer(body)
		if res == OK:
			var texture := ImageTexture.create_from_image(image)
			var stylebox: StyleBox = avatar.get_theme_stylebox("panel").duplicate()
			stylebox.texture = texture
			avatar.add_theme_stylebox_override("panel", stylebox)


func _on_timer_timeout() -> void:
	update()
