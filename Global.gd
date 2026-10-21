extends Node

# --- Configurações ---
var mouse_sensitivity: float = 0.15
var sfx_volume: float = 1.0
var music_volume: float = 1.0
var voltar_para_pausa: bool = false

# --- Dados do Jogo (Save) ---
var player_hp: int = 4
var dealer_hp: int = 4
var karmic_balance: int = 0
# Adicione aqui outras variáveis do seu jogo (ex: itens na mochila, fase atual, etc.)

func update_audio_volumes():
	var sfx_bus = AudioServer.get_bus_index("SFX")
	var music_bus = AudioServer.get_bus_index("Music")
	if sfx_bus != -1:
		AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(sfx_volume))
	if music_bus != -1:
		AudioServer.set_bus_volume_db(music_bus, linear_to_db(music_volume))

# --- LÓGICA DE SALVAR ---
func salvar_jogo():
	var dados = {
		"player_hp": player_hp,
		"dealer_hp": dealer_hp,
		"karmic_balance": karmic_balance,
		# Adicione as outras variáveis aqui
	}
	
	var arquivo = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if arquivo:
		var json_string = JSON.stringify(dados)
		arquivo.store_line(json_string)
		print("Jogo salvo com sucesso!")
	else:
		print("Erro ao tentar salvar o jogo.")

# --- LÓGICA DE CARREGAR ---
func carregar_jogo() -> bool:
	if not FileAccess.file_exists("user://savegame.save"):
		print("Nenhum save encontrado.")
		return false
		
	var arquivo = FileAccess.open("user://savegame.save", FileAccess.READ)
	if arquivo:
		var json_string = arquivo.get_line()
		var json = JSON.new()
		var erro = json.parse(json_string)
		
		if erro == OK:
			var dados = json.data
			# Restaura os valores do jogo
			player_hp = dados.get("player_hp", 4)
			dealer_hp = dados.get("dealer_hp", 4)
			karmic_balance = dados.get("karmic_balance", 0)
			print("Jogo carregado com sucesso!")
			return true
		else:
			print("Erro ao ler o arquivo de save.")
	return false
