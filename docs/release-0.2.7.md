# Minha Coleção de Jogos 0.2.7

Esta versão recompila o aplicativo sobre a Zumbra 0.12.7.

## Alteração

- Atualização da baseline nativa para o event loop SDL3 orientado a eventos.
- O executável C11 usado por `.deb`, AppImage e bundle agora permanece bloqueado quando a interface está ociosa, em vez de consumir continuamente um núcleo da CPU.
- Nenhuma funcionalidade ou formato de dados foi alterado.

## Validação esperada

Com o aplicativo parado, o processo instalado e o AppImage devem retornar a uso de CPU próximo de zero. Interações, redimensionamento e abertura de diálogos podem causar aumentos temporários.
