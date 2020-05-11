class_name GSAITraverse
extends GSAISteeringBehavior

signal traversed

var arrive : GSAIArrive
var positions : Array
var _current_position_index := 0


func _init(agent: GSAISteeringAgent, _positions: Array, _arrival_tolerance:= 10.0).(agent) -> void:
	positions = _positions
	var target = GSAIAgentLocation.new()
	_current_position_index = 0
	target.position = positions[_current_position_index]
	arrive = GSAIArrive.new(agent, target)
	arrive.arrival_tolerance = _arrival_tolerance
	arrive.connect("arrive", self, "_on_arrived")


func _calculate_steering(acceleration: GSAITargetAcceleration) -> void:
	arrive._calculate_steering(acceleration)


func _on_arrived():
	if _current_position_index == positions.size():
		return
	
	_current_position_index += 1
	
	if _current_position_index == positions.size():
		emit_signal("traversed")
	else:
		arrive.target.position = positions[_current_position_index]
