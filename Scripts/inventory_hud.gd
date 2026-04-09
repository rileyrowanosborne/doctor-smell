extends ItemList

const GREEN_CRYSTAL = preload("uid://dva2fdx6leqk1")
const MAJOR_CRYSTAL = preload("uid://3blj72uwx7gv")
const ORANGE_CRYSTAL = preload("uid://dqqt2s6y61hvl")
const RED_CRYSTAL = preload("uid://cps7y8ecfifkv")
const YELLOW_CRYSTAL = preload("uid://cenprdgdq16vt")
const DULL_CRYSTAL = preload("uid://e7tkkr87prj2")

@onready var crystal_1: TextureButton = $"../Crystal1"
@onready var crystal_2: TextureButton = $"../Crystal2"
@onready var crystal_3: TextureButton = $"../Crystal3"
@onready var crystal_4: TextureButton = $"../Crystal4"

enum crystal_spots {
	crystal_one,
	crystal_two,
	crystal_three,
	crystal_four
}

var current_crystal_selection : crystal_spots


func _ready() -> void:
	GameSignals.connect("mini_crystal_collected", add_mini_crystal)
	GameSignals.connect("huge_crystal_collected", add_huge_crystal)
	GameSignals.connect("ricochet_crystal_collected", add_ricochet_crystal)
	GameSignals.connect("explosive_crystal_collected", add_explosive_crystal)
	GameSignals.connect("electro_crystal_collected", add_electro_crystal)
	GameSignals.connect("homing_crystal_collected", add_homing_crystal)
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		add_electro_crystal()
		add_explosive_crystal()
		add_huge_crystal()
		add_mini_crystal()
		add_mini_crystal()


func add_mini_crystal():
	add_item("MINI CRYSTAL", GREEN_CRYSTAL, true)

func add_ricochet_crystal():
	add_item("RICOCHET CRYSTAL", ORANGE_CRYSTAL, true)

func add_huge_crystal():
	add_item("HUGE CRYSTAL", RED_CRYSTAL, true)


func add_explosive_crystal():
	add_item("EXPLOSIVE CRYSTAL", MAJOR_CRYSTAL, true)

func add_electro_crystal():
	add_item("ELECTRO CRYSTAL", YELLOW_CRYSTAL, true)

func add_homing_crystal():
	add_item("HOMING CRYSTAL", DULL_CRYSTAL, true )


func _on_item_selected(index: int) -> void:
	var item_texture = get_item_icon(index)
	
	
	
	remove_item(index)
	
	match current_crystal_selection:
		
		crystal_spots.crystal_one:
			crystal_1.texture_normal = item_texture
		
		crystal_spots.crystal_two:
			crystal_2.texture_normal = item_texture
		
		crystal_spots.crystal_three:
			crystal_3.texture_normal = item_texture
		
		crystal_spots.crystal_four:
			crystal_4.texture_normal = item_texture
		
	


func _on_crystal_1_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_crystal_selection = crystal_spots.crystal_one


func _on_crystal_2_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_crystal_selection = crystal_spots.crystal_two


func _on_crystal_3_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_crystal_selection = crystal_spots.crystal_three


func _on_crystal_4_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_crystal_selection = crystal_spots.crystal_four
