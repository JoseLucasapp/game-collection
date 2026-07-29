# Arquitetura

## Repositórios

O aplicativo é deliberadamente separado do `Zumbra-lang`. O repositório da linguagem contém compilador, VM, backend nativo, biblioteca padrão e pequenos exemplos de regressão. Este repositório contém apenas o produto de coleção de jogos.

## Camadas da aplicação

```text
src/main.zum
├── ciclo de vida da aplicação desktop
├── árvore retida de interface
├── estado reativo do formulário, busca e ordenação
└── roteamento de eventos da lista dinâmica

src/storage.zum
├── migration SQLite
├── criação, atualização e exclusão
├── busca
└── ordenação
```

## Schema SQLite

```sql
CREATE TABLE games (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  platform TEXT NOT NULL,
  franchise TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

O banco pertence ao usuário atual do sistema operacional. Nenhuma conta, telemetria ou serviço remoto é necessário.

## Ações dinâmicas

As linhas usam identificadores como `edit-game-42` e `delete-game-42`. O Zumbra 0.11.0 expõe `targetId` e `targetKind` nos callbacks de UI, permitindo que toda a lista utilize um callback genérico de edição e outro de exclusão.
