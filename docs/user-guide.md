# Guia do usuário

## Cadastro e edição

Preencha Nome e Plataforma, que são obrigatórios. Franquia, Região, Mídia, Condição e Capa local são opcionais. O botão **Escolher** abre o file picker para uma imagem local. Ao editar um card, todos os campos são preenchidos novamente.

## Busca e filtros

A busca considera nome, plataforma, franquia, região, mídia e condição. Os filtros de plataforma e franquia podem ser combinados com a busca e a ordenação.

## Exclusão

**Excluir** abre uma confirmação com o nome do jogo. O fundo fica bloqueado até confirmar, cancelar ou pressionar `Esc`.

## Importação e exportação

Abra **Dados** ou pressione `Ctrl+D`.

- JSON preserva o formato versionado do aplicativo.
- CSV usa as colunas `name`, `platform`, `franchise`, `region`, `media`, `condition` e `cover_path`.
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
