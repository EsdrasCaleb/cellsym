extends Control

enum ORGAN {GOLDI_C=1, RETICULO_L=2, RETICULO_R=3, CLOROPLAST=4, MITOCONDRI=5}

signal selected_organ(organ)
signal set_active_organ(organ,active)
signal set_ressources(ressources)
signal disable_organ(organ)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _oni_focus_entered(organ):
	selected_organ.emit(organ)
	
func _on_toggle(active,organ):
	set_active_organ.emit(organ,active)

func _on_focus_exited():
	selected_organ.emit(0)



func _on_disable_organ(organe):
	match(organe):
		ORGAN.GOLDI_C:
			$VBoxContainer/HBoxContainer2/VBoxContainer/Goldi.toggle_mode =false
		ORGAN.RETICULO_L:
			$VBoxContainer/HBoxContainer2/VBoxContainer/ReticL.toggle_mode =false
		ORGAN.RETICULO_R:
			$VBoxContainer/HBoxContainer2/VBoxContainer/ReticR.toggle_mode =false
		ORGAN.CLOROPLAST:
			$VBoxContainer/HBoxContainer2/VBoxContainer/CloroPlasto.toggle_mode =false
		ORGAN.MITOCONDRI:
			$VBoxContainer/HBoxContainer2/VBoxContainer/Mitocondri.toggle_mode =false


func _on_set_ressources(ressources):
	$VBoxContainer/HBoxContainer/Val1.text = str(ressources.atp)
	$VBoxContainer/HBoxContainer/Val2.text = str(ressources.lipideos)
	$VBoxContainer/HBoxContainer/Val3.text = str(ressources.proteina)
	$VBoxContainer/HBoxContainer/Val4.text = str(ressources.glicose)
	$VBoxContainer/HBoxContainer/Val5.text = str(ressources.co2)
	$VBoxContainer/HBoxContainer/Val6.text = str(ressources.residuos)
		
