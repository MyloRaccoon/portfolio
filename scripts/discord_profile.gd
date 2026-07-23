extends Node3D

@onready var lbl_username := $Username
@onready var lbl_activity := $Activity
@onready var lbl_status := $Status
@onready var timer := $Timer

const FETCH_TIME := 1.0

func _ready() -> void:
	RaccoonLiveApi.request_completed.connect(on_request_completed)
	RaccoonLiveApi.getDiscord()

func on_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	lbl_username.text = json["DisplayName"] + " (" + json["Username"] + ")"
	lbl_activity.text = json["Activity"]
	lbl_status.text = json["Status"]
	timer.start(FETCH_TIME)

func _on_timer_timeout() -> void:
	RaccoonLiveApi.getDiscord()
