extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_novo_jogo_pressed():
	# Reseta os dados globais para começar do zero
	Global.player_hp = 4
	Global.dealer_hp = 4
	Global.karmic_balance = 0
	
	get_tree().change_scene_to_file("res://game_manager.tscn")

func _on_carregar_jogo_pressed():
	if Global.carregar_jogo(): # Tenta carregar os dados
		# Se conseguiu, vai para a cena do jogo
		get_tree().change_scene_to_file("res://game_manager.tscn")
	else:
		# Se não tem save, você pode mostrar um aviso ou apenas ignorar
		print("Não foi possível carregar o jogo.")

func _on_configuracoes_pressed():
	Global.voltar_para_pausa = false
	get_tree().change_scene_to_file("res://menu_configuracoes.tscn")

func _on_sair_pressed():
	get_tree().quit()


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	pass # Replace with function body.
