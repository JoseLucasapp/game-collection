# Minha Coleção de Jogos

<img src='./assets/pic.png' width='400' align='center'/>
<br/>
<br/>

Primeiro aplicativo desktop oficial criado com a linguagem Zumbra. Ele mantém uma coleção local de jogos em SQLite, sem conta e sem depender da internet.

## Recursos da versão 0.1.3

- cadastro de nome, plataforma e franquia;
- edição e exclusão;
- busca pelos três campos;
- ordenação por nome, plataforma, franquia e data de cadastro;
- tema claro e escuro;
- persistência local em SQLite;
- atalhos de teclado;
- distribuição pelo Zumbra para Linux, Windows e macOS;
- cards compactos, com altura estável e ações alinhadas;
- listagem com rolagem interna, sem ultrapassar a área principal.

## Requisitos

- Zumbra 0.11.3 ou superior;
- SQLite 3;
- SDL3 e SDL3_ttf para a interface gráfica.

## Executar

```bash
scripts/run.sh
```

## Testar

```bash
scripts/test.sh
```

## Empacotar

```bash
scripts/package-linux.sh
scripts/package-windows.sh
scripts/package-macos.sh
```

Os pacotes Windows e macOS exigem o ambiente nativo correspondente ou uma toolchain de cross-compilation configurada.

## Manutenção

```bash
scripts/clean.sh
scripts/check-repository-hygiene.sh
```

## Dados locais

O banco é armazenado na pasta de dados do usuário, no arquivo `zumbra-game-collection.sqlite` dentro da pasta de dados do usuário. Nenhum dado é enviado para servidores externos.
