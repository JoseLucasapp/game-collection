# Minha Coleção de Jogos 0.2.8

This release updates the native desktop baseline to Zumbra 0.12.8.

## Fixed

- Packaged native builds no longer treat SDL3 poll-sentinel events as ordinary application events.
- `.deb`, AppImage and native bundle builds return to the blocking event wait after draining queued events.
- No schema, migration, JSON or CSV format changes were introduced.

## Compatibility

The SQLite database and all data-exchange formats remain compatible with 0.2.7 and 0.2.6.
