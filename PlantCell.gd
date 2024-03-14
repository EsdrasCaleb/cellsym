extends Node3D

enum ORGAN {GOLDI_C=1, RETICULO_L=2, RETICULO_R=3, CLOROPLAST=4, MITOCONDRI=5}

@export_category("Upgrates")
@export var clorpoasto_up1:MeshInstance3D
@export var clorpoasto_up2:MeshInstance3D
@export var mitocondia_up1:MeshInstance3D
@export var reticulo_endoplasmatico_rugosu_up1:MeshInstance3D
@export var reticulo_endoplasmatico_rugosu_up2:MeshInstance3D
@export var reticulo_endoplasmatico_liso_up1:MeshInstance3D
@export var reticulo_endoplasmatico_liso_up2:MeshInstance3D

@export_category("Ação")
@export var ribosomo_1:MeshInstance3D
@export var ribosomo_2:MeshInstance3D
@export var lisosomo_1:MeshInstance3D
@export var lisosomo_2:MeshInstance3D
@export var lisosomo_3:MeshInstance3D

@export_category("Seleção")
@export var l_mito:SpotLight3D
@export var l_cloroplast:SpotLight3D
@export var l_goldi:SpotLight3D
@export var l_retiL:SpotLight3D
@export var l_retiR:SpotLight3D

signal selected_organ(organ)
signal set_active_organs(organs)

var active_organs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	clorpoasto_up1.set_visible(false)
	clorpoasto_up2.set_visible(false)
	mitocondia_up1.set_visible(false)
	reticulo_endoplasmatico_rugosu_up1.set_visible(false)
	reticulo_endoplasmatico_rugosu_up2.set_visible(false)
	reticulo_endoplasmatico_liso_up1.set_visible(false)
	reticulo_endoplasmatico_liso_up2.set_visible(false)
	ribosomo_1.set_visible(false)
	ribosomo_2.set_visible(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func disable_organs():
	if(not active_organs.has(ORGAN.MITOCONDRI)):
		l_mito.set_visible(false)
	if(not active_organs.has(ORGAN.CLOROPLAST)):
		l_cloroplast.set_visible(false)
	if(not active_organs.has(ORGAN.GOLDI_C)):
		l_goldi.set_visible(false)
	if(not active_organs.has(ORGAN.RETICULO_L)):
		l_retiL.set_visible(false)
	if(not active_organs.has(ORGAN.RETICULO_R)):
		l_retiR.set_visible(false)


func _on_selected_organ(organ):
	disable_organs()
	enable_organ(organ)


func enable_organ(organ):
	match organ:
		1:
			l_goldi.set_visible(true)
		2:
			l_retiL.set_visible(true)
		3:
			l_retiR.set_visible(true)
		4:
			l_cloroplast.set_visible(true)
		5:
			l_mito.set_visible(true)


func _on_set_active_organs(organs):
	print(organs)
	active_organs = organs
	disable_organs()
	for organ in organs:
		enable_organ(organ)
