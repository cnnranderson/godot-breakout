extends Node

"""
Events Singleton -- used to define events for the entire game.

This allows us to bind events anywhere across the entities used
without having to create complex hierarchies within nodes when
connecting signal subscribers.
"""

signal game_won
signal game_lost
signal game_restart
signal screen_shake

signal brick_destroyed(points, coordinate)
signal powerup_obtained(powerup, pos)
signal powerup_dropped(powerup, pos)
signal ball_destroyed
