# Minha Coleção de Jogos 0.1.2

Correção visual e de crescimento da listagem sobre a Zumbra 0.11.2.

## Interface

- remove desalinhamentos cumulativos entre títulos, labels, inputs, botões, toolbar e painel principal;
- define altura estável de 80 px para cada card;
- centraliza verticalmente nome, plataforma e franquia no card;
- fixa os botões Editar e Excluir em 74 × 36 px;
- mantém a lista dentro do canvas principal;
- adiciona rolagem vertical interna por roda do mouse;
- reserva espaço para a barra de rolagem sem sobrepor o conteúdo.

## Validação

- `zumbra check src/main.zum`;
- testes de storage e identidade de eventos;
- execução headless pela VM;
- build e execução headless do backend nativo C11.

A confirmação visual final deve ser executada no Debian com SDL3, verificando também listas maiores que a altura da janela.
