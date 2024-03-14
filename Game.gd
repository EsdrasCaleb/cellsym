extends Node3D

enum ORGAN {GOLDI_C=1, RETICULO_L=2, RETICULO_R=3, CLOROPLAST=4, MITOCONDRI=5}

const TIME_TOACT = 1
const TIME_TO_DACAY =5
const MAX_RESIDUOS = 10

var atp_decay = 0
var active_organs =[]
var timers = {1:0, 2:0, 3:0, 4:0, 5:0}
var ressources = {"atp":0,"glicose":0,"proteina":0,"lipideos":0,"residuos":0,"co2":0}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for organe in active_organs:
		timers[organe]+= delta
		if(timers[organe]>TIME_TOACT):
			generate(organe)
			timers[organe] = 0
	
	atp_decay+= delta 
	if(atp_decay>TIME_TO_DACAY):
		ressources.atp = max(ressources.atp-1,0)
		ressources.co2 = max(1,ressources.co2)
		atp_decay = 0
	if(ressources.residuos>MAX_RESIDUOS):
		get_tree().change_scene_to_file("res://GameOver.tscn") 
	$Control.set_ressources.emit(ressources)

func generate(organe):
	match(organe):
		ORGAN.GOLDI_C:
			if(ressources.atp>0):
				ressources.residuos -= 1
		ORGAN.RETICULO_L:
			if(ressources.atp>0 and ressources.glicose>0):
				ressources.lipideos += 1
		ORGAN.RETICULO_R:
			if(ressources.atp>0 and ressources.glicose>0):
				ressources.proteina += 1
		ORGAN.CLOROPLAST:
			ressources.glicose += 1
			if(ressources.co2>0):
				ressources.glicose += 1
				ressources.co2 -=1
				ressources.residuos +=1
				print(ressources.co2)
		ORGAN.MITOCONDRI:
			if(ressources.glicose>0 ):
				ressources.atp += 1 
				ressources.co2 += 1
				ressources.glicose -= 1
				ressources.residuos +=1


func _on_control_selected_organ(organ):
	$PlantCell.selected_organ.emit(organ)

func set_active(organ:ORGAN,active:bool):
	if(organ!=ORGAN.CLOROPLAST and ressources.atp<=0 
			and organ!=ORGAN.MITOCONDRI and ressources.glicose<=0):
		$Control.disable_organ.emit(organ)
		return
	if(active_organs.has(organ)):
		if(not active):
			active_organs = active_organs.filter(func(number): return number != organ)
	elif(active):
		active_organs.append(organ)
	$PlantCell.set_active_organs.emit(active_organs)
	print(active_organs)
		
