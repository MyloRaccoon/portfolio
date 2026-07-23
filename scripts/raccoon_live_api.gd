extends Node

signal request_completed(result, response_code, headers, body)

const API_URL := "http://localhost:8080"
const MOCKING := true

var request: HTTPRequest

func _ready() -> void:
	if MOCKING: return
	request = HTTPRequest.new()
	request.request_completed.connect(on_request_completed)
	get_tree().current_scene.add_child(request)

func getDiscord():
	if MOCKING: 
		on_request_completed(null, 200, null, {"DisplayName": "Mylo", "Username": "mylo_raccoon", "Activity": "killing myself", "Status": "caves are great"})
		return
	request.request(API_URL + "/discord")

func getYoutube():
	if MOCKING:
		on_request_completed(null, 200, null, {"DisplayName": "Mylo", "Username": "mylo_raccoon", "Activity": "killing myself", "Status": "caves are great"})
		return
	request.request(API_URL + "/youtube")

func on_request_completed(result, response_code, headers, body):
	if MOCKING:
		request_completed.emit(result, response_code, headers, body)
		return
	request_completed.emit(result, response_code, headers, body)
