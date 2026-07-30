# Arquitetura

## Repositórios

O aplicativo é separado do `Zumbra-lang`. O repositório da linguagem contém compilador, VM, backend C11, runtime e biblioteca padrão; este repositório contém o produto, seus módulos, testes e assets.

## Camadas

```text
src/main.zum
├── lifecycle desktop e árvore retida de UI
├── estados reativos, bindings e preferências
├── modais, atalhos, notificações e file pickers
└── roteamento de ações da lista dinâmica

src/storage.zum
├── migrations SQLite
├── CRUD, busca, filtros e ordenação
├── duplicatas e estatísticas
└── backup, restauração e integridade

src/exchange.zum
├── JSON versionado
├── CSV com cabeçalho estável
├── validação de registros
└── relatório de importados, duplicados e inválidos

src/preferences.zum
├── valores padrão
├── leitura recuperável
└── escrita atômica em JSON
```

## Schema SQLite

A migration 1 cria `games`. A migration 2 adiciona detalhes e índices:

```sql
CREATE TABLE games (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  platform TEXT NOT NULL,
  franchise TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE games ADD COLUMN region TEXT NOT NULL DEFAULT '';
ALTER TABLE games ADD COLUMN media TEXT NOT NULL DEFAULT '';
ALTER TABLE games ADD COLUMN condition TEXT NOT NULL DEFAULT '';
ALTER TABLE games ADD COLUMN cover_path TEXT NOT NULL DEFAULT '';
```

Índices `NOCASE` cobrem nome, plataforma e franquia.

## Eventos dinâmicos

Cards usam IDs como `edit-game-42`, `delete-game-42` e `cover-game-42`. Os callbacks recebem `targetId` e `targetKind`, consultam dicionários de alvos e não criam closures capturando dados por card. Botões estáticos usam um dispatcher global por ID, mantendo compatibilidade com o backend nativo.

## Segurança da restauração

Antes de restaurar um banco escolhido, o aplicativo cria `before-restore.sqlite` na pasta de dados. A Zumbra valida o arquivo de origem com `PRAGMA quick_check` e substitui o banco de forma atômica somente após a validação.

## Modelo local

Banco, preferências e capas pertencem ao usuário do sistema operacional. O aplicativo não possui conta, sincronização, telemetria ou serviço remoto.
