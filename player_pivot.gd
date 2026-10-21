extends Node3D

# Limites de visão vertical
@export var min_pitch: float = -80.0
@export var max_pitch: float = 80.0

var pitch: float = 0.0

@onready var camera: Camera3D = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		
		# Puxa a sensibilidade definida no menu (Global.gd)
		var sensibilidade = Global.mouse_sensitivity 
		
		# Movimento Horizontal (Gira o nó Pai)
		var mov_x = -event.relative.x * sensibilidade * 10.0 * get_process_delta_time()
		rotate_y(deg_to_rad(mov_x))
		
		# Movimento Vertical (Gira o nó Filho - Câmera)
		var multiplicador_vertical = 3.0 
		var mov_y = -event.relative.y * sensibilidade * 10.0 * multiplicador_vertical * get_process_delta_time()
		
		# Acumula e limita a visão
		pitch += deg_to_rad(mov_y)
		pitch = clamp(pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))
		
		camera.rotation.x = pitch

var menu_pausa_cena = preload("res://menu_pausa.tscn")
var menu_pausa_instanciado = null

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			if menu_pausa_instanciado == null:
				menu_pausa_instanciado = menu_pausa_cena.instantiate()
				menu_pausa_instanciado.name = "MenuPausa" # Força o nome correto
				get_tree().root.add_child(menu_pausa_instanciado)
