extends Page

@onready var status_lbl := $status

func _ready() -> void:
	set_status()

func set_status() -> void:
	while true:
		var discord = await RaccoonLiveApi.get_discord()
		#print(discord)
		if discord != null:
			var activity = discord["Activity"]
			if activity == "Custom Status":
				status_lbl.text = discord["Status"]
			else:
				status_lbl.text = activity
		else:
			status_lbl.text = ""
		await get_tree().create_timer(30).timeout
