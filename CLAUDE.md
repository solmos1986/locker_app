# CLAUDE.md

Este archivo proporciona orientación a Claude Code (claude.ai/code) al trabajar con el código
de este repositorio.

## Qué es esto

App Flutter tipo kiosco para un **gabinete físico de lockers inteligentes**, que corre en una
tablet Android montada rotada 90° (de ahí el `Transform.rotate(angle: pi/2)` que envuelve al
`MaterialApp` en [lib/main.dart](lib/main.dart), y las contra-rotaciones por pantalla). La tablet:

- controla las cerraduras del locker por un **puerto serial RS-485** (`/dev/ttyS0`, 9600 baudios,
  cadenas HEX) mediante `flutter_serial` / `libserialport`;
- recibe comandos remotos de "abrir esta puerta" desde un broker **RabbitMQ** (`dart_amqp`, cola `open`);
- refleja su configuración y datos de movimientos desde un **backend REST** (Dio) hacia una base
  de datos local **SQLite** (`sqflite`).

El código está en español (comentarios, textos de UI, algunos identificadores). Además tiene
errores de ortografía incrustados en identificadores y columnas de la BD — `comand` (no command),
`Rabbti`, `reponse`, `inizialize`, `departament`/`department` mezclados. **Respeta la ortografía
existente** al editar.

## Comandos

```bash
flutter pub get                                        # instalar dependencias
flutter run --dart-define-from-file=lib/dev.json        # ejecutar (config dev) — ver "Configuración" abajo
flutter run --dart-define-from-file=lib/prod.json       # ejecutar (config prod)
flutter analyze                                         # lint / análisis estático
flutter test                                            # correr todas las pruebas
flutter test test/widget_test.dart                      # correr un solo archivo de prueba
flutter build apk                                       # build de release (objetivo principal: Android)
```

Las configuraciones de ejecución de VS Code `developer` y `production` (en
[.vscode/launch.json](.vscode/launch.json)) pasan el `--dart-define-from-file` correspondiente.
Configuración de lint: [analysis_options.yaml](analysis_options.yaml) (`flutter_lints`, con
`avoid_print` deshabilitado).

Solo existe `test/widget_test.dart` y es la plantilla sin modificar — probablemente obsoleta dada
la UI rotada / de kiosco.

## Configuración

La configuración en tiempo de ejecución viene de defines de compilación leídos en
[lib/helper/env.dart](lib/helper/env.dart) (`EnvConfig`): `BASE_URL`, `TOKEN`, `LOCKER_ID`,
`BUILDING_ID`.

`lib/dev.json` y `lib/prod.json` están en **.gitignore**. Copia
[lib/dev.json.example.json](lib/dev.json.example.json) para crearlos. Ejecutar sin
`--dart-define-from-file` deja estos valores vacíos y las llamadas a la API fallan.

## Arquitectura

En capas, aproximadamente clean architecture:

- `domain/entities/` — objetos de dominio.
- `infrastructure/models/` — modelos de API/DTO y de vista (`fromJson`/`toJson`).
- `repositories/` — CRUD de SQLite, una clase por tabla. Cada una tiene una clase acompañante
  `*Fields` con el nombre de la tabla y las constantes de columnas. Se usa SQL crudo para
  joins/reportes.
- `services/` — `DatabaseService` / `MovementService` (REST vía Dio), y `services/integration/`
  (conexión al puerto serial y arneses de prueba).
- `presentation/screens/` + `presentation/provider/` — UI con `provider` / `ChangeNotifier`.
  Los providers globales están en el `MultiProvider` de `main.dart`; los providers por ruta se
  crean en línea dentro del mapa `routes`.
- `config/database.dart` — la **única fuente del esquema** (`LockeAppDatabase`, singleton,
  versión 1). `config/theme.dart` — tematización.

### La BD local es un espejo desechable del servidor

**No hay migraciones** — la versión de la BD está fija en 1. En su lugar, `ConfigScreen` →
`ConfigProvider.getDataBase()`:

1. `DatabaseService.getAllDataBase()` — `GET /api/database` devuelve el dataset completo;
2. `ResetRepository.resetDataBase()` — hace `DROP` y recrea todas las tablas;
3. el `createAll(...)` de cada repositorio repuebla desde la respuesta de la API.

Consecuencia: **cualquier cambio de esquema debe hacerse tanto en
[lib/config/database.dart](lib/config/database.dart) como en
[lib/repositories/reset_repository.dart](lib/repositories/reset_repository.dart)**, y las
instalaciones existentes solo lo toman tras una sincronización de datos (o reinstalación).

### Modelo de comandos de hardware

Las tablas `request_comand` / `response_comand` guardan las cadenas hex de comando y de respuesta
esperada, indexadas por `door_id` y un nombre de acción (`"abrir"`, `"lectura"`, ...).
`RequestComandRepository.getCodeForDoor(doorId, action)` las obtiene. Flujo: enviar `requestComand`
por serial (`ConnectSerial.sendMessage`), luego comparar las tramas `SerialResponse` entrantes
(decodificadas con `GetLogReponse`) contra el `responseComand` esperado para confirmar el estado
abierto/cerrado.

### Flujo de apertura remota

`UtilRabbtiMqProvider.connecRabbit()` se espera con `await` en `main()` antes de `runApp`. Consume
la cola `open`; cada mensaje (`OpenDoorModel`, lleva `doorId`) dispara la secuencia de apertura por
serial descrita arriba.

### Flujo de movimientos

- **Entregar** (`/reception` → `/select-locker` → `/confirm-reception`): elegir departamento +
  puerta, `MovementProvider.sendMovement` genera un código de 6+ dígitos (`GenerateCode`), escribe
  una fila `movement` local y hace `POST /api/movement/pending`.
- **Recoger** (`/client` → `/qr-scan` o `/password` → `/confirm-delivery`):
  `VerifiedCodeProvider.verifiedCode` valida el código contra la tabla `movement` local, abre la
  puerta y luego hace `POST /api/movement/received`.

La autenticación con el backend es `Authorization: Bearer <EnvConfig.token>` en cada petición.
