extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_btn_salvar_pressed():
	Global.salvar_jogo() # Chama a função do Global
	_voltar_ao_jogo() # Volta a jogar

var cena_configuracoes = preload("res://menu_configuracoes.tscn")
var menu_config_instanciado = null

func _on_btn_configuracoes_pressed():
	if menu_config_instanciado == null:
		Global.voltar_para_pausa = true # Avisa que veio do jogo
		menu_config_instanciado = cena_configuracoes.instantiate()
		menu_config_instanciado.name = "MenuConfiguracoes"
		get_tree().root.add_child(menu_config_instanciado)
		self.visible = false
		self.set_process_input(false)

func _on_btn_sair_menu_pressed():
	get_tree().paused = false 
	# --- ADICIONE ESTA LINHA ---
	queue_free() # Destrói o menu de pausa para não bugar a próxima cena
	# ---------------------------
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
func _on_btn_sair_jogo_pressed():
	get_tree().quit()

func _voltar_ao_jogo():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()

func _unhandled_input(event):
	# Só fecha com ESC se o menu estiver visível
	if event.is_action_pressed("ui_cancel") and self.visible:
		_voltar_ao_jogo()
