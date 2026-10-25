# Relatório Final — Game Jam 2026

## 1. Identificação da Equipe

**Equipe:** Team YANE (Grupo 2)

**Integrantes:**

- **Ana Carolina Lins de Laet** — Análise e Desenvolvimento de Sistemas, 2º semestre, tarde.
- **Ezequiel da Silva** — Análise e Desenvolvimento de Sistemas, 4º semestre, matutino.
- **Natã Silva Marques** — Análise e Desenvolvimento de Sistemas, 1º semestre, tarde.
- **Yago Henrique dos Santos Lima** — Análise e Desenvolvimento de Sistemas, 6º semestre, noturno.

## 2. Título do Projeto

**Fatec Phantom Chaos**

## 3. Ferramentas e Tecnologias de Desenvolvimento

- **Engine:** Godot Engine. O arquivo de configuração do projeto está preparado para recursos da Godot 4.6.
- **Linguagem:** GDScript.
- **Arte e animação:** Aseprite, ferramenta de desenho em pixel art e criação de spritesheets. 
- **Controle de versão:** Git e GitHub.
- **Recursos visuais:** sprites, fontes, imagens de cenários e tilesets em diferentes formatos. As licenças de terceiros identificáveis são listadas na seção de créditos.
- **Áudio:** 

## 4. Estilo e Gênero do Jogo

- **Gênero:** sobrevivência em arena, com elementos de roguelite e *auto-shooter*, conforme a proposta do projeto.
- **Perspectiva:** 2D top-down (visão de cima).
- **Estilo visual:** pixel art com temática de Halloween.
- **Referência de gameplay:** jogos de sobrevivência em que o jogador se movimenta para evitar inimigos enquanto os ataques são acionados automaticamente, como vampire survivors.

## 5. Tema e Premissa Narrativa

A proposta combina o cotidiano de estudantes da Fatec Campinas com a temática de Halloween. Na narrativa elaborada pela equipe, a protagonista é **Lídia**, uma estudante que vai à faculdade porque o celular descarregou e ela não vê o aviso de que não haverá aula. Próximo ao campus, um ritual realizado no cemitério dá errado e libera criaturas sobrenaturais. A personagem precisa sobreviver às ameaças.

Texto narrativo:

> *"Você é Lídia, uma estudante da Fatec Campinas. Infelizmente, seu celular descarregou e você não viu o aviso de que hoje, dia 30, não haveria aula e foi para a faculdade, que estava vazia. Pouco depois de chegar, sons estranhos de trovões, uivos e gritos tomaram o ar, como se viessem do cemitério. O céu ficou completamente nublado. Na hora era impossível saber, mas no cemitério próximo à Fatec alguém havia iniciado um ritual que deu muito errado. Agora monstros, mortos-vivos e espíritos assombram a região. Você precisa sobreviver com o que tiver à disposição até que o ritual falho seja cancelado. Boa sorte."*



## 6. Descrição do Jogo e das Mecânicas

*Fatec Phantom Chaos* é um jogo de sobrevivência em arena. No início, o jogador passa pelo menu principal e escolhe uma entre três armas iniciais: **Chicote** (Um Mouse), **Projétil** (Réguas) ou **Splash** (Frascos com químicos tóxicos). Durante a partida, deve-se movimentar a personagem para evitar os inimigos e sobreviver o maior tempo possível.

Os ataques são acionados automaticamente de acordo com o tempo de recarga da arma. O comportamento depende da arma escolhida: o ataque de projétil busca atingir o inimigo mais próximo, o *Splash* posiciona uma área de dano sobre um alvo e o chicote ataca na direção para a qual a personagem está voltada. Assim, **o mouse não é usado para mirar continuamente durante a partida**; ele é usado para interagir com os botões e selecionar opções da interface.

Os inimigos perseguem a personagem e causam dano ao entrar em contato com ela. Ao serem derrotados, podem deixar itens coletáveis; na configuração atual, o recurso de inimigo disponível concede experiência (XP). Ao acumular XP suficiente, a personagem sobe de nível e o jogo apresenta opções de melhoria de arma ou de atributos passivos. A tela de opções pausa a partida enquanto o jogador escolhe uma melhoria. A vida, a experiência e o nível são acompanhados pela interface.

A partida termina em **Game Over** quando a vida da personagem chega a zero. O projeto também possui pausa, opção de retomar a partida e opção de voltar ao menu principal.


## 7. Arquitetura da Solução

O projeto utiliza a organização por cenas, nós e recursos da Godot Engine. Os principais componentes identificados são:

- **Menu principal (`screens/main_menu.tscn`):** apresenta as opções para iniciar o jogo ou sair.
- **Seleção de arma (`screens/selecao_armas.tscn`):** permite escolher uma das três armas iniciais antes de entrar na arena.
- **Arena (`screens/arena.tscn`):** reúne as camadas de mapa, a personagem, o gerenciador de surgimento de inimigos, a interface de jogo, a pausa e a tela de Game Over.
- **Personagem (`player/player.tscn` e `player/player.gd`):** controla movimento, vida, experiência, nível, animações e o uso da arma selecionada. A personagem usa `CharacterBody2D` para a movimentação.
- **Inimigos (`enemies/inimigo.tscn` e `enemies/inimigo.gd`):** representam entidades que perseguem o jogador, recebem dano, sofrem repulsão (*knockback*) e podem deixar itens ao morrer.
- **Gerenciador de inimigos (`utils/spawner.gd`):** cria inimigos em posições ao redor da personagem e utiliza temporizadores para controlar o surgimento. O código limita a quantidade de inimigos ativos e remove os que se afastam muito da personagem.
- **Armas e melhorias (`player/armas/`, `upgrade/` e arquivos `.tres`):** definem os comportamentos de ataque, recarga, dano e melhorias das armas.
- **Itens coletáveis e atributos (`pickup/` e `itens/resources/`):** implementam a coleta de experiência e recursos para melhorias passivas, como alcance de coleta, dano, velocidade, regeneração e vida máxima.


## 8. Mecanismos Técnicos

- **Movimentação e colisão:** uso de `CharacterBody2D`, `Area2D`, `move_and_slide()`, `move_and_collide()` e formas de colisão da Godot.
- **Temporizadores:** controlam a frequência dos ataques e o surgimento de inimigos.
- **Animação e efeitos:** uso de `AnimationPlayer` e *tweens* para animações da personagem e efeitos de ataque.
- **Dados configuráveis:** recursos `.tres` armazenam parâmetros de inimigos, armas, melhorias e itens.
- **Controle de quantidade de inimigos:** o código impede novos surgimentos quando o número de inimigos do grupo chega ao limite estabelecido. Isso não é a mesma técnica que *Object Pooling*.


## 9. Instalação e Execução

### Executar o projeto-fonte

#### Por execautável
1. Baixe o arquivo executável do repositório githun (ou o projeto todo)
2. Abra o executável

#### Por ZIP com projeto que não passou por build
1. Extraia o ZIP do projeto.
2. Instale a Godot Engine compatível com a configuração do projeto (Godot 4.6).
3. Abra o **Godot Project Manager**, importe/abra o projeto selecionando o arquivo `phantom-chaos/project.godot` e aguarde a importação dos recursos.
4. Execute o projeto pelo botão **Run Project** ou pela tecla **F5** no editor.

### Controles 

- **W, A, S, D** ou **setas direcionais:** movimentam a personagem.
- **Esc:** abre ou fecha a pausa durante a partida, salvo quando uma janela de opções ou de Game Over impede a alternância.
- **Mouse:** interage com botões do menu, seleção de arma e opções de melhoria. Não funciona como mira manual contínua dos ataques.


## 10. Evolução em Relação ao Relatório Inicial

A comparação com `relatorioInicia_TeamYANE.md` e com a estrutura do projeto permite registrar os seguintes pontos:

1. **Aprofundamento da narrativa:** a documentação final passa a chamar a protagonista de Lídia e explica sua ida à faculdade pela bateria descarregada do celular. .
2. **Seleção de arma inicial:** a versão atual contém uma tela própria para escolher entre Chicote (Mouse), Projétil(Réguas) e Splash (Frascos com químico tóxico) antes da partida.
3. **Progressão durante a partida:** o projeto contém coleta de XP, sistema de níveis e opções de melhorias para a arma e para atributos passivos.
4. **Fluxo de partida:** estão presentes menu principal, pausa, seleção de arma e tela de Game Over.
5. **Ícones de melhorias:** alguns recursos de atributos passivos usam texturas provisórias (`PlaceholderTexture2D`), enquanto outros têm imagens definidas. 
6. **Áudio:** 

## 11. Créditos, Licenças e Uso de IA

Os arquivos de licença e de informações presentes no projeto permitem identificar algumas fontes de recursos:

- **Kenney — Roguelike/RPG Pack:** a documentação incluída no projeto indica licença **CC0 1.0**. Fonte: [Kenney — Roguelike/RPG Pack](https://kenney.nl/assets/roguelike-rpg-pack) e [Creative Commons CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
- **Kenney — Tiny City:** o arquivo `assets/tileset/kenney_tiny/License.txt` também indica licença **CC0 1.0**.
- **Craftpix — Free Werewolf Sprite Sheets– Pixel Art**: O projeto contém os arquivos werewolf_walk_X100.png e werewolf_walk_X400.png, referentes a sprites de lobisomem. Os recursos foram obtidos no pacote gratuito disponibilizado pela Craftpix — Free Werewolf Sprite Sheets – Pixel Art. Conforme os termos de licença da Craftpix, os recursos podem ser utilizados e modificados em projetos pessoais e comerciais, respeitando as restrições de redistribuição e revenda dos arquivos de arte.
- **Tileset “Path and Road”:** o arquivo `assets/tileset/path and road/license.txt` encaminha para os termos de licença da [Craftpix](https://craftpix.net/file-licenses/).
- **Tileset “50s_Diner”:** o arquivo informativo menciona `0-mem0ry` e o endereço [0-mem0ry no itch.io](https://0-mem0ry.itch.io/).


**Uso de IA generativa:** Foi utilizado como: Ajuda para traduzir o mapa da fatec campinas para o jogo;  auxílio na criação de alguns spritesheets complexos (como do boss final); Como auxílio na criação do relatório final.

## 12. Galeria Demonstrativa
#### Menu Inicial

#### Introdução e seleção de arma
<img width="500" height="300" alt="image" src="https://github.com/user-attachments/assets/8a3d2622-0ee0-417a-905e-14da7cbfdc2c" />

#### Menu de melhorias
<img width="279" height="174" alt="image" src="https://github.com/user-attachments/assets/256be157-2271-4ac3-9f13-42a58fd39d94" />
Uma lista de melhorias disponíveis após coletar XP (Pontos de Experiência) o bastante

#### Menu de opções
<img width="500" height="300" alt="image" src="https://github.com/user-attachments/assets/bdcfeed2-66f0-44e2-88ad-fa02e681f322" />

#### Combate
<img width="500" height="300" alt="image" src="https://github.com/user-attachments/assets/13956432-8eec-4ce5-851d-3ff53ab21538" />
<img width="1000" height="600" alt="20261025-0245-41 0602966" src="https://github.com/user-attachments/assets/aa2d11c1-09bf-4b15-b5ef-172b2d1ce143" />


### GIFs de spritesheets
<img width="128" height="192" alt="zumb400i" src="https://github.com/user-attachments/assets/48289e13-fd83-4589-b86e-3157f79958df" />
<img width="128" height="128" alt="spinningLilGhost" src="https://github.com/user-attachments/assets/0b71ab16-9b2a-4cdf-8861-719f81e1bf34" />
<img width="128" height="192" alt="MC1-Sheet_NoArm_R-Sheet" src="https://github.com/user-attachments/assets/c0cecbf7-8fac-4556-ae7f-ed08914f3e9e" />





---
