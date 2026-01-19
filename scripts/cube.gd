extends CSGMesh3D
class_name Cube

signal showed

const IDLE_MAX_SPEED = 10
const IDLE_MIN_SPEED = 0
const ROTATING_SPEED = 10

enum States {IDLE, ROTATING, SHOWING}
var state: States = States.IDLE

enum Faces {ONE, TWO, THREE, FOUR, FIVE, SIX}
var face = Faces.ONE
var face_target = Faces.ONE
const FACE_ROTATIONS = {
	Faces.ONE: Quaternion(Vector3.UP, 0),
	Faces.TWO: Quaternion(Vector3.UP, PI / 2),
	Faces.THREE: Quaternion(Vector3.UP, PI),
	Faces.FOUR: Quaternion(Vector3.UP, -PI / 2),
	Faces.FIVE: Quaternion(Vector3.RIGHT, PI / 2),
	Faces.SIX: Quaternion(Vector3.RIGHT, -PI / 2),
}

var x = randi_range(-10, 10)
var y = randi_range(-10, 10)
var z = randi_range(-10, 10)

func show_face(face_to_show: Faces):
	state = States.ROTATING
	face = face_to_show

func select_face() -> Faces:
	var new_faces = Faces.values()
	new_faces.erase(face)
	return new_faces.pick_random()

func spin():
	show_face(select_face())

func idle():
	spin()
	await showed
	state = States.IDLE

func _process(delta: float) -> void:
	
	if state == States.IDLE:
		rotate(Vector3(x, y, z).normalized(), deg_to_rad(1))
		x += randi_range(IDLE_MIN_SPEED, IDLE_MAX_SPEED) * delta
		y += randi_range(IDLE_MIN_SPEED, IDLE_MAX_SPEED) * delta
		z += randi_range(IDLE_MIN_SPEED, IDLE_MAX_SPEED) * delta

	if state == States.ROTATING:
		var target_quat = FACE_ROTATIONS[face]
		var current_quat = quaternion
		
		var new_quat = current_quat.slerp(
			target_quat,
			ROTATING_SPEED * delta
		)
		
		global_transform.basis = Basis(new_quat)
		
		if current_quat.dot(target_quat) > 0.999:
			state = States.SHOWING
			showed.emit()
