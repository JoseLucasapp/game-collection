# Z16 — Primeiro aplicativo desktop oficial

## Produto

- [x] Repositório separado do compilador.
- [x] Manifesto desktop.
- [x] Janela redimensionável.
- [x] Layout real de aplicativo.
- [x] Formulários e validação.
- [x] Binding bidirecional.
- [x] Lista dinâmica com scroll interno.
- [x] Nomes longos sem invadir ações.

## Dados

- [x] SQLite local.
- [x] Migrations versionadas.
- [x] CRUD completo.
- [x] Busca geral.
- [x] Filtros por plataforma e franquia.
- [x] Ordenação.
- [x] Campos de região, mídia e condição.
- [x] Capas locais.
- [x] Estatísticas.
- [x] Integridade do banco.

## Portabilidade e segurança

- [x] Confirmação antes de excluir.
- [x] Exportação JSON versionada.
- [x] Importação JSON validada.
- [x] Exportação CSV.
- [x] Importação CSV validada.
- [x] Detecção de duplicatas.
- [x] Backup SQLite.
- [x] Restauração SQLite.
- [x] Backup automático antes da restauração.
- [x] File picker de abrir e salvar.
- [x] Erros recuperáveis.
- [x] Notificações.

## Experiência desktop

- [x] Tema claro e escuro.
- [x] Persistência de preferências.
- [x] Atalhos de teclado.
- [x] Navegação com Tab e Shift+Tab.
- [x] Modais com isolamento de foco.
- [x] Fundo bloqueado durante modais.
- [x] Árvore de acessibilidade correta.
- [x] Menu lateral totalmente retrátil com reflow responsivo.
- [x] Botão permanente para ocultar e reabrir o menu.
- [x] Cursores visuais `pointer` e `text` nos controles interativos.
- [x] Caret visível e foco interno nos inputs e textareas.
- [x] Botões de ícone vetorial sem clipping.
- [x] Scrollbar sobreposta sem quebrar margens simétricas.
- [x] Estatísticas com seleção entre barras, pizza e linha.
- [x] Tabela estruturada das principais plataformas.
- [x] Estado vazio sem containers gráficos quebrados.

## Qualidade e distribuição

- [x] Testes de storage e migrations.
- [x] Testes de round-trip JSON/CSV.
- [x] Testes de backup/restauração/integridade.
- [x] Teste de 500 registros.
- [x] Testes de acessibilidade e integração.
- [x] Execução headless na VM.
- [x] Build e execução headless nativa C11.
- [x] Bundle Linux.
- [x] Pacote `.deb` validado no Debian.
- [x] AppDir e AppImage validados no Debian.
- [x] Estrutura de pacote Windows e instalador NSIS.
- [x] Estrutura de bundle macOS `.app` e ZIP.
- [x] Documentação do usuário e arquitetura.
- [x] Higiene do repositório.

## Validação de release por plataforma

- [x] Debian/Linux real.
- [ ] Windows real — executar antes de publicar um instalador Windows.
- [ ] macOS real — executar antes de publicar um bundle macOS.

As duas últimas linhas são validações externas de release, não lacunas de implementação do Z16.
