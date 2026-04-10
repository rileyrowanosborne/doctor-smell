extends Control

@onready var inventory_list: ItemList = $InventoryList
@onready var equipped_list: ItemList = $EquippedList
@onready var equip: Button = $Equip
@onready var unequip: Button = $Unequip




const GREEN_CRYSTAL = preload("uid://dva2fdx6leqk1")
const MAJOR_CRYSTAL = preload("uid://3blj72uwx7gv")
const ORANGE_CRYSTAL = preload("uid://dqqt2s6y61hvl")
const RED_CRYSTAL = preload("uid://cps7y8ecfifkv")
const YELLOW_CRYSTAL = preload("uid://cenprdgdq16vt")
const DULL_CRYSTAL = preload("uid://e7tkkr87prj2")

var selected_item_name
var selected_item_texture
var selected_item_index

var ricochet = load("res://powerups/RICOCHET CRYSTAL.tres")
var huge = load("res://powerups/HUGE CRYSTAL.tres")
var mini = load("res://powerups/MINI CRYSTAL.tres")
var explosive
var electro
var homing




func _ready() -> void:
	
	if PlayerInventory.inventory_name.is_empty():
		print("nothing to repopulate")
	else:
		if PlayerInventory.inventory_name.has("MINI CRYSTAL"):
			inventory_list.add_item("MINI CRYSTAL", GREEN_CRYSTAL, true)
		if PlayerInventory.inventory_name.has("HUGE CRYSTAL"):
			inventory_list.add_item("HUGE CRYSTAL", RED_CRYSTAL, true)
		if PlayerInventory.inventory_name.has("RICOCHET CRYSTAL"):
			inventory_list.add_item("RICOCHET CRYSTAL", ORANGE_CRYSTAL, true)
		if PlayerInventory.inventory_name.has("EXPLOSIVE CRYSTAL"):
			inventory_list.add_item("EXPLOSIVE CRYSTAL", MAJOR_CRYSTAL, true)
		if PlayerInventory.inventory_name.has("ELECTRO CRYSTAL"):
			inventory_list.add_item("ELECTRO CRYSTAL", YELLOW_CRYSTAL, true)
		if PlayerInventory.inventory_name.has("HOMING CRYSTAL"):
			inventory_list.add_item("HOMING CRYSTAL", DULL_CRYSTAL, true)
	
	if PlayerInventory.equipped_name.is_empty():
		print("nothing equipped")
	else:
		if PlayerInventory.equipped_name.has("MINI CRYSTAL"):
			equipped_list.add_item("MINI CRYSTAL", GREEN_CRYSTAL, true)
		if PlayerInventory.equipped_name.has("HUGE CRYSTAL"):
			equipped_list.add_item("HUGE CRYSTAL", RED_CRYSTAL, true)
		if PlayerInventory.equipped_name.has("RICOCHET CRYSTAL"):
			equipped_list.add_item("RICOCHET CRYSTAL", ORANGE_CRYSTAL, true)
		if PlayerInventory.equipped_name.has("EXPLOSIVE CRYSTAL"):
			equipped_list.add_item("EXPLOSIVE CRYSTAL", MAJOR_CRYSTAL, true)
		if PlayerInventory.equipped_name.has("ELECTRO CRYSTAL"):
			equipped_list.add_item("ELECTRO CRYSTAL", YELLOW_CRYSTAL, true)
		if PlayerInventory.equipped_name.has("HOMING CRYSTAL"):
			equipped_list.add_item("HOMING CRYSTAL", DULL_CRYSTAL, true)
	
	GameSignals.connect("mini_crystal_collected", add_mini_crystal)
	GameSignals.connect("huge_crystal_collected", add_huge_crystal)
	GameSignals.connect("ricochet_crystal_collected", add_ricochet_crystal)
	GameSignals.connect("explosive_crystal_collected", add_explosive_crystal)
	GameSignals.connect("electro_crystal_collected", add_electro_crystal)
	GameSignals.connect("homing_crystal_collected", add_homing_crystal)
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		add_ricochet_crystal()
		add_huge_crystal()
		add_mini_crystal()
		add_mini_crystal()


func add_mini_crystal():
	PlayerInventory.inventory_name.append("MINI CRYSTAL")
	inventory_list.add_item("MINI CRYSTAL", GREEN_CRYSTAL, true)

func add_ricochet_crystal():
	PlayerInventory.inventory_name.append("RICOCHET CRYSTAL")
	inventory_list.add_item("RICOCHET CRYSTAL", ORANGE_CRYSTAL, true)

func add_huge_crystal():
	PlayerInventory.inventory_name.append("HUGE CRYSTAL")
	inventory_list.add_item("HUGE CRYSTAL", RED_CRYSTAL, true)


func add_explosive_crystal():
	PlayerInventory.inventory_name.append("EXPLOSIVE CRYSTAL")
	inventory_list.add_item("EXPLOSIVE CRYSTAL", MAJOR_CRYSTAL, true)

func add_electro_crystal():
	PlayerInventory.inventory_name.append("EXPLOSIVE CRYSTAL")
	inventory_list.add_item("ELECTRO CRYSTAL", YELLOW_CRYSTAL, true)

func add_homing_crystal():
	PlayerInventory.inventory_name.append("HOMING CRYSTAL")
	inventory_list.add_item("HOMING CRYSTAL", DULL_CRYSTAL, true )



func _on_inventory_list_item_selected(index: int) -> void:
	selected_item_name = inventory_list.get_item_text(index)
	selected_item_texture = inventory_list.get_item_icon(index)
	selected_item_index = index
	
	equip.disabled = false
	unequip.disabled = true



func _on_equip_pressed() -> void:
	
	if equipped_list.item_count < 3:
		equipped_list.add_item(selected_item_name, selected_item_texture, true)
		inventory_list.remove_item(selected_item_index)
		
		if selected_item_name == "MINI CRYSTAL":
			PlayerInfo.equip_crystal(mini)
			PlayerInventory.equipped_name.append( "MINI CRYSTAL")
		elif selected_item_name == "HUGE CRYSTAL":
			PlayerInfo.equip_crystal(huge)
			PlayerInventory.equipped_name.append("HUGE CRYSTAL")
		elif selected_item_name == "RICOCHET CRYSTAL":
			PlayerInfo.equip_crystal(ricochet)
			PlayerInventory.equipped_name.append("RICOCHET CRYSTAL")
		elif selected_item_name == "EXPLOSIVE CRYSTAL":
			PlayerInventory.equipped_name.append("EXPLOSIVE CRYSTAL")
		elif selected_item_name == "ELECTRO CRYSTAL":
			PlayerInventory.equipped_name.append("ELECTRO CRYSTAL")
		elif selected_item_name == "HOMING CRYSTAL":
			PlayerInventory.equipped_name.append("HOMING CRYSTAL")
		

func _on_equipped_list_item_selected(index: int) -> void:
	selected_item_name = equipped_list.get_item_text(index)
	selected_item_texture = equipped_list.get_item_icon(index)
	selected_item_index = index
	
	equip.disabled = true
	unequip.disabled = false



func _on_unequip_pressed() -> void:
	inventory_list.add_item(selected_item_name, selected_item_texture, true)
	equipped_list.remove_item(selected_item_index)
	
	PlayerInfo.unequip_crystal(selected_item_index)
	PlayerInventory.equipped_name.erase(selected_item_name)


func _on_resume_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
