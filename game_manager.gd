extends Node3D

# Máquina de Estados
enum State { DECREE_PHASE, LOAD_CHAMBER, PLAYER_TURN, DEALER_TURN, RESOLUTION }
var current_state: State = State.DECREE_PHASE

# Variáveis do Nó
var chamber: Array = []
var player_hp: int = 4
var dealer_hp: int = 4
var karmic_balance: int = 0 # De -100 a +100

func _ready():
	# Puxa os dados do Global para as variáveis DO NÓ
	player_hp = Global.player_hp
	dealer_hp = Global.dealer_hp
	karmic_balance = Global.karmic_balance
	
	# Atualiza a interface visual do jogo
	atualizar_ui()
	
	# Inicia o fluxo do jogo
	start_game()

func atualizar_ui():
	# Exemplo de como você deve atualizar os textos/barras
	# Descomente e ajuste os caminhos quando criar a UI
	# $UI/LabelPlayerHP.text = "Sua Vida: " + str(player_hp)
	# $UI/LabelDealerHP.text = "Vida Juiz: " + str(dealer_hp)
	# $UI/BarraKarma.value = karmic_balance
	print("UI Atualizada - Player HP: ", player_hp, " | Juiz HP: ", dealer_hp)

func start_game():
	change_state(State.DECREE_PHASE)

func change_state(new_state: State):
	current_state = new_state
	print("Mudando para o estado: ", State.keys()[current_state])
	
	match current_state:
		State.DECREE_PHASE:
			# Lógica para sortear a lei
			change_state(State.LOAD_CHAMBER) # Exemplo de transição automática
		State.LOAD_CHAMBER:
			# Lógica para carregar Yin e Yang
			change_state(State.PLAYER_TURN)
		State.PLAYER_TURN:
			# Aqui você habilita os botões de UI para o jogador
			pass
		State.DEALER_TURN:
			# Aqui você faz o Juiz jogar
			pass
		State.RESOLUTION:
			# Verifica se acabou (HP zerado ou Balança em -100 / +100)
			pass

# Função de atirar
func atirar(alvo: String):
	if chamber.is_empty():
		print("O cilindro está vazio!")
		return
		
	var elemento = chamber.pop_front()
	
	if alvo == "DEALER":
		if elemento == "YIN":
			dealer_hp -= 1
			Global.dealer_hp = dealer_hp # <--- SALVA NO GLOBAL
		else:
			dealer_hp += 1
			Global.dealer_hp = dealer_hp # <--- SALVA NO GLOBAL
		change_state(State.DEALER_TURN)
		
	elif alvo == "SELF":
		if elemento == "YIN":
			player_hp -= 1
			Global.player_hp = player_hp # <--- SALVA NO GLOBAL
			change_state(State.PLAYER_TURN) # Mantém o turno se acertar Yin
		else:
			player_hp += 1
			Global.player_hp = player_hp # <--- SALVA NO GLOBAL
			change_state(State.DEALER_TURN)
			
	# Atualiza a tela após o tiro
	atualizar_ui()
