extends Node

const URL := "http://localhost:8080"

var response

func get_discord():
	var request := HTTPRequest.new()
	request.request_completed.connect(
		func(result, response_code, headers, body):
			_on_request_completed(request, result, response_code, headers, body)
	)
	add_child(request)
	request.request(URL + "/discord")
	await request.request_completed
	return response
	
func _on_request_completed(request, _result, response_code, _headers, body):
	if response_code != 200:
		response = null
		return
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	response = json.get_data()
	request.queue_free()
