# Minha Coleção de Jogos 0.2.9

This release updates the native desktop baseline to Zumbra 0.12.9.

## Fixed

- Packaged native builds reuse rendered text textures across frames.
- Cover thumbnails and detail images are loaded once and reused until the source file changes.
- Modal backdrop blur is reused while the same modal remains open.
- Moving the pointer inside the same control no longer redraws the complete application.
- Chart-type changes no longer repeatedly rebuild unrelated text, cover images and backdrop blur.

## Compatibility

The SQLite database, migrations, JSON and CSV formats remain compatible with 0.2.8 and 0.2.6.
