extends Page

@onready var cog := $Cog
@onready var time_lbl := $Time
@onready var date_lbl := $Date

var spiiiin := false
var spin_tick := 0

const SPIIN_TIME = 10

func _process(_delta: float) -> void:
	var new_time := Time.get_time_string_from_system()
	if new_time != time_lbl.text:
		spiiiin = true
		spin_tick = 0
	time_lbl.text = new_time
	date_lbl.text = Time.get_date_string_from_system()
	
	if spiiiin:
		cog.speed = 0.1
		spin_tick += 1
		if spin_tick >= SPIIN_TIME:
			spiiiin = false
	else:
		cog.speed = .0
	
