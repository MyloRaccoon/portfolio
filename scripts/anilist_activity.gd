extends Node3D

@onready var label = $activity

const URL = "https://graphql.anilist.co"
const COOLDOWN = 30
const USERNAME = 'MyloRaccoon'
var user_id = null

func _ready() -> void:
	get_user_id(USERNAME)

func get_user_id(username: String):
	if user_id:
		self.get_last_activity()
		return
	var query = """
		query ($name: String!) {
			User(name: $name) {
				id
			}
		}
	"""
	var variables = {
		"name": username
	}
	var request = HTTPRequest.new()
	request.request_completed.connect(self.got_user_id)
	add_child(request)
	var body = JSON.stringify({"query": query, "variables": variables})
	request.request(URL, ["Content-Type: application/json", "Accept: application/json"], HTTPClient.METHOD_POST, body)
	print("reqest user id...")

func got_user_id(_result, _reponse_code, _headers, body):
	print('got user id!')
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.get_data()
	user_id = data['data']['User']['id']
	print('userid: ', user_id)
	self.get_last_activity()

func get_last_activity():
	var query = """
		query ($userId: Int) {
		  Page(page: 1, perPage: 2) {
		    activities(userId: $userId, sort: ID_DESC, type: MEDIA_LIST) {
		      ... on ListActivity {
		        id
		        status
		        progress
		        media {
		          title { romaji }
		          siteUrl
		        }
		      }
		    }
		  }
		}
	"""
	var variables = {
		"userId": user_id
	}
	var request = HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(self.got_last_activity)
	var body = JSON.stringify({"query": query, "variables": variables})
	request.request(URL, ["Content-Type: application/json", "Accept: application/json"], HTTPClient.METHOD_POST, body)
	print('request activity...')
	
func got_last_activity(_result, _reponse_code, _headers, body):
	print('got activity!')
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.get_data()
	var activity_data = data['data']['Page']['activities'][0]
	self.update(activity_data)

func update(activity_data):
	print('updating...')
	var status = activity_data['status']
	var progress = activity_data['progress']
	var title = activity_data['media']['title']['romaji']
	
	var with_prog = "%s %s of %s" % [status, progress, title]
	var without_prog = "%s %s" % [status, title]
	var activity = with_prog if progress != null else without_prog
	
	label.text = activity
	print('finished!')
	await get_tree().create_timer(COOLDOWN).timeout
	self.get_user_id(USERNAME)
