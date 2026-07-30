# Guia do usuário

## Cadastro e edição

Preencha Nome e Plataforma, que são obrigatórios. Franquia, Região, Mídia, Condição, Valor, Nota, Link, Descrição e Capa local são opcionais. O botão **Escolher** abre o file picker para uma imagem local. Ao editar um card, todos os campos são preenchidos novamente.

## Busca e filtros

A busca considera nome, plataforma, franquia, região, mídia, condição, valor, nota, descrição e link. Os filtros de plataforma e franquia podem ser combinados com a busca e a ordenação.

## Exclusão

**Excluir** abre uma confirmação com o nome do jogo. O fundo fica bloqueado até confirmar, cancelar ou pressionar `Esc`.

## Importação e exportação

Abra **Dados** ou pressione `Ctrl+D`.

- JSON preserva o formato versionado do aplicativo.
- CSV usa as colunas `name`, `platform`, `franchise`, `region`, `media`, `condition`, `cover_path`, `price`, `description`, `link` e `rating`. Arquivos da versão anterior, com sete colunas, continuam importáveis.
- Registros sem nome ou plataforma são inválidos.
- Nome + plataforma + região iguais são tratados como duplicata.

## Backup e restauração

**Criar backup** salva uma cópia consistente do SQLite. Ao restaurar, o aplicativo cria primeiro `before-restore.sqlite` na pasta de dados. Um arquivo inválido ou corrompido é rejeitado.

## Atalhos

```text
Ctrl+N       novo jogo
Ctrl+S       salvar
Ctrl+F       focar busca
Ctrl+D       abrir Dados
Ctrl+T       abrir Estatísticas
Ctrl+Q       sair
Tab          próximo controle
Shift+Tab    controle anterior
Esc          fechar diálogos
```

## Arquivos locais

- banco: pasta de dados do sistema;
- preferências: pasta de configuração do sistema;
- capas: permanecem no caminho escolhido e não são copiadas para o banco.

## Recolher e expandir o menu

O botão no início do header oculta completamente o formulário lateral. Quando o menu está fechado, a listagem passa a ocupar automaticamente toda a largura disponível. O mesmo botão permanece no header e permite reabrir o formulário a qualquer momento.

## Estatísticas visuais

No modal **Estatísticas**, o campo **Tipo de gráfico** permite alternar a visualização das principais plataformas entre:

- Barras;
- Pizza;
- Linha.

A tabela permanece ao lado do gráfico com os valores exatos. Quando a coleção não possui dados para o ranking, o aplicativo mostra uma mensagem única em vez de containers vazios.

## Indicação visual de interação

Botões, selects e demais ações exibem cursor de ponteiro. Inputs exibem cursor de texto, mudança de fundo ao receber foco e um caret vertical indicando a posição de digitação.


## Cards, capas e detalhes

Quando um jogo possui uma capa local, o card mostra uma miniatura quadrada sem distorção. O botão **Ver mais** abre um modal com a capa, plataforma, franquia, região, mídia, condição, valor, nota, link e descrição. **Abrir imagem** envia a capa ao visualizador padrão do sistema; **Abrir link** abre a página cadastrada. As ações só aparecem quando o dado correspondente existe.

## Edição de texto

Inputs e textareas permitem posicionar o caret com o mouse, mover com as setas, usar `Home` e `End`, selecionar com `Shift`, selecionar palavras com duplo clique e arrastar a seleção. `Ctrl+A`, `Ctrl+C`, `Ctrl+X` e `Ctrl+V` funcionam como nos demais aplicativos desktop.
