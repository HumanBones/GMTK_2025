extends Node

signal looping
signal start
signal end
signal pause
signal win
signal shake(amount : float)

enum GameState {
	START,
	LOOPING,
	PAUSED,
	END,
}

var cur_game_state : GameState

func _ready() -> void:
	cur_game_state = GameState.START


func change_state(state : GameState) ->void:
	cur_game_state = state
