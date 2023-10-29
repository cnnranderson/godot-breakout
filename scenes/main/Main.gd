extends Node2D
class_name Main

var curr_scene: Global.Scenes = Global.Scenes.START_MENU
var scene_state = 0
var skip_transition = [false, false]
var SCENE_DELAY = 0.05
var TRANSITION_DELAY = 1

func _ready():
	Global.main = self
	load_scene(Global.Scenes.START_MENU, true, true)

func load_scene(scene: Global.Scenes = Global.Scenes.NONE, skip_intro = false, skip_outro = false):
	# Validate scene
	if scene != 0:
		assert(scene in Global.Scenes.values())
		scene_state = Global.Scenes.START_MENU
		curr_scene = scene
		skip_transition = [skip_intro, skip_outro]
	
	match scene_state:
		0:
			# Pause any happenings
			get_tree().paused = true
			$Timers/LoadTimer.set_wait_time(SCENE_DELAY)
			$Timers/LoadTimer.start()
			scene_state = 1 if not skip_transition[0] else 2
		1:
			# Enter transition
			print("in")
			$TransitionLayer/Screen/Animation.play("transition_in")
			$Timers/LoadTimer.set_wait_time(TRANSITION_DELAY)
			$Timers/LoadTimer.start()
			scene_state = 2
		2:
			# Load the new scene
			print("LOADING Scene: %s" % curr_scene)
			var children = $Scene.get_children()
			if not children.is_empty():
				children[0].queue_free()
			var new_scene = load(Global.SceneMap[curr_scene]).instantiate()
			$Scene.add_child(new_scene)
			
			$Timers/LoadTimer.set_wait_time(SCENE_DELAY)
			$Timers/LoadTimer.start()
			scene_state = 3 if not skip_transition[0] else 4
		3:
			# Exit transition
			print("out")
			$TransitionLayer/Screen/Animation.play("transition_out")
			$Timers/LoadTimer.set_wait_time(TRANSITION_DELAY)
			$Timers/LoadTimer.start()
			scene_state = 4
		4:
			# Unpause the tree to continue with the scene
			get_tree().paused = false
			scene_state = 0

func _on_LoadTimer_timeout():
	load_scene()
