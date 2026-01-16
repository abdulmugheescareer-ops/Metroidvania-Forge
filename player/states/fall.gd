class_name PlayerStateFall extends PlayerState

@export var gravity_multiplier : float = 1.165
@export var cayote_time : float = 0.4
@export var jump_buffer_time : float = 0.2

var cayote_timer = 0
var buffer_timer = 0


# What happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	#play animation
	player.gravity_multiplier = fall.gravity_multiplier
	if player.previous_state == jump:
		cayote_timer = 0
	else:
		cayote_timer = cayote_time
	pass


# What happens when we exit this state?
func exit() -> void:
	player.gravity_multiplier = 1.0
	pass


# What happens when an input is pressed?
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("Jump"):
		if cayote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	
	return next_state


# What happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	cayote_timer -= _delta
	buffer_timer -= _delta
	return next_state


# What happens each physics_process tick in this state?
func physics_process( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		if buffer_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
