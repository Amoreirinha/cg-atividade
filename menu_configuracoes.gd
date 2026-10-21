extends Control

@onready var slider_sensibilidade = $VBoxContainer/HBoxSensibilidade/SliderSensibilidade
@onready var slider_musica = $VBoxContainer/HBoxMusica/SliderMusica
@onready var slider_sfx = $VBoxContainer/HBoxSFX/SliderSFX

func _ready():
	slider_sensibilidade.value = Global.mouse_sensitivity * 100
	slider_musica.value = Global.music_volume * 100
	slider_sfx.value = Global.sfx_volume * 100

func _on_slider_sensibilidade_value_changed(value: float) -> void:
	Global.mouse_sensitivity = value / 100.0

func _on_slider_musica_value_changed(value: float) -> void:
	Global.music_volume = value / 100.0
	Global.update_audio_volumes()

func _on_slider_sfx_value_changed(value: float) -> void:
	Global.sfx_volume = value / 100.0
	Global.update_audio_volumes()

func _on_botao_voltar_pressed() -> void:
	if Global.voltar_para_pausa:
		var menu_pausa = get_tree().root.get_node_or_null("MenuPausa")
		if menu_pausa:
			menu_pausa.visible = true
			menu_pausa.set_process_input(true)
		queue_free()
	else:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://main_menu.tscn")

# Adicionado para permitir fechar com ESC
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_botao_voltar_pressed()
