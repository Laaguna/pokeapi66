## POKEAPI66 - POKEMON FLUTTER APP
Prueba técnica puesto Frontend Flutter Developer para Global66, hecha por Sebastian Camilo Mahecha Pardo.

### ¿Como ejecutar el proyecto?
#### Requisitos:
- Flutter SDK 3.19.3
- Dart SDK 3.3.1

### Instalación:
**1. Clonar el repositorio**
```
git clone https://github.com/Laaguna/pokeapi66.git
cd pokeapi66
```

**2. Instalar dependencias**
```
flutter pub get
```

**3. Generar código de Freezed**
```
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. Ejecutar la aplicación**
```
flutter run 
o 
flutter run -d -emulator-5554
```

**5. Ejecutar tests**
```
# Todos los tests
flutter test

# Con cobertura
flutter test --coverage
```

### Arquitectura del proyecto
```
lib/
├── domain/                    # Capa de Dominio (Entidades + Reglas de Negocio)
│   ├── models/
│   │   └── pokemon/
│   │       ├── pokemon.dart
│   │       └── gateway/
│   │           └── pokemon_gateway.dart    # Abstracción (DIP)
│   └── use_cases/
│       └── pokemon/
│           └── get_pokemon_use_case.dart
│
├── infrastructure/            # Capa de Infraestructura (Implementaciones)
│   ├── driven_adapter/
│   │   └── pokemon_api/
│   │       └── pokemon_api.dart           # Implementación del Gateway
│   └── helpers/
│       ├── pokemon_mapper.dart            # Transformación API -> Dominio
│       └── named_resource_mapper.dart
│
├── ui/                        # Capa de Presentación (MVVM)
│   ├── providers/             # ViewModels (StateNotifiers)
│   │   ├── pokemon_provider.dart
│   │   ├── favorites_provider.dart
│   │   └── filter_provider.dart
│   ├── state/
│   │   └── pokemon_ui_state.dart          # Estados UI con Freezed
│   ├── pages/                 # Views
│   │   ├── splash/
│   │   ├── home/
│   │   ├── pokemon_list/
│   │   ├── favorites/
│   │   └── detail/
│   └── widgets/               # Componentes reutilizables
│
├── config/
│   └── use_case_config.dart   # Inyección de Dependencias Manual
│
└── test/                      # Unit Tests
    ├── domain/
    └── infrastructure/
```

### Flujo de datos
```
UI (Widgets)
    ↓ (lee estado)
Providers (Riverpod StateNotifiers)
    ↓ (llama)
Use Cases (Lógica de Negocio)
    ↓ (usa)
Gateway Interface (Abstracción)
    ↑ (implementa)
API Implementation (Dio + Mappers)
    ↓ (consulta)
PokéAPI REST
```


## ¿Cómo aborde el problema?
Para abordar el problema, primero tuve que identificar desde la documentación de PokeAPI las entidades que debía usar para el proyecto.
- Adicionalmente por el documento de la prueba, sabía que tenia que crear solo dos llamados
  -> Creé la capa de dominio con las reglas del negocio, en estado sería la entidad de Pokemon con sus atributos (PokemonAbility, PokemonType, PokemonStat y PokemonSprites). También agregué una entidad para los NamedResource ya que todos llevan la misma estructura.
- Después de tener las entidades creadas, hice las reglas de negocio
  -> Creé los casos de uso, en este caso serían solo dos (2) (getPokemonById, getAllPokemons)
  -> Como quería hacer una inyección de dependencias, creé un GateWay para que los casos de uso puedan depender de este, de esta manera podemos inyectar diferentes apis que a su vez extienden del gateway y no afectamos las reglas del negocio.

- Teniendo clara la capa de dominio, pasé a hacer la capa de infraestructura. Lo primero fue crear un adaptador para hacer el apicall.
  -> Cree la carpeta driven_adapters / pokemon_api.dart, acá cree una clase que extiende a PokemonGateway y recibe una instancia de el client http Dio.
  -> Con esto claro, empecé las funciones de apicall para getAllPokemon y getPokemonById, acá me di cuenta que en realidad solo tenía que hacer un apicall a getAllPokemon, y en la lista de "results" hacer un mapping para hacer un apicall por cada uno de los resultados paginados. Entonces no fue neceasrio utilizar getPokemonById.
  -> Agregué dos mappers (PokemonMapper.fromJson y NamedResourceMapper.fromJson), para poder convertir la data del api en nuestro Dominio para la UI.
  -> Cuando ya tenia las funciones, la capa de dominio y la infraestructura limpia, necesitaba manualmente crear una config para poder inyectar manualmente las dependencias, en estado /config/use_case_config.dart, maneja la inicialización del cliente Dio, y el Gateway con el api que en este caso vamos a inyectar.

- Finalmente entré en la capa de la UI, donde en primera instancia identifiqué los providers y estados que debía manejar, nunca había usado Freezed, pero logré crear mediante las annotations 4 estados para el pokemonUi (initial, loading, loaded y error).
  -> Lo primero que hice fue crear con riverpod un provider para cargar todos los pokemons, acá tengo una clase que extiende de StateNotifier<PokemonUiState>, para usar el state. En esta misma clase cree una instancia del GetPokemonUseCase, que usará el método para traer todos los pokemon y posteriormente cargarlo en el estado del provider. Acá con el estado se maneja el load, loaded y el error.
  -> De la misma manera cree dos providers adicionales. Uno para poder manejar el cambio de estado a favoritos de los pokemon y poder manejar la lista de favoritos. Y el segundo para manejar los filtros por tipo y por busqueda.

- Ya con toda la lógica de parte del cliente creada, podía empezar con la maquetación de toda la UI y la implementación de los providers en cada widget.
  -> Acá me encargué de identificar los componentes que podía extraer para poder ser reutilizados y aplicar el concepto de DRY. Algunos componentes: (PokemonTypeChips, ErrorWidget, EmptyWidget, PokemonCard, CustomBottomBar)

- Para cerrar el proyecto, teniendo en cuenta las capas que había creado (Dominio, useCases, Infraestructura y ui). Tomé la capa de dominio y de useCases, para crear los respectivos tests.
  -> Creé un test unitario para: Los dos mappers de la data y el caso de uso para Cargar los pokemons.
  -> Estos tests se encargan de revisar los siguientes aspectos:
- NamedResource Mapper
  -> Should map json to NamedResource
  -> Should handle empty strings
- Pokemon Mapper
  -> Should map complete json to Pokemon
  -> Should handle pokemon with multiple abilities and types
- GetPokemonUseCase
  -> Should get pokemon by id from gateway
  -> Should get all pokemon from gateway
  -> Should propagate error when gateway fails

## Pprincipios, patrones y arquitecturas aplicados.
### **SOLID**
1. **S**ingle Responsibility Principle (SRP)
- Cada clase tiene una única responsabilidad
- PokemonMapper solo transforma datos
- PokemonNotifier solo maneja estados UI
- GetPokemonUseCase solo orquesta obtención de datos
2. **O**pen/Closed Principle (OCP)
- PokemonGateway está abierto a extensión (nuevas implementaciones) pero cerrado a modificación
- Podríamos agregar PokemonLocalStorage sin tocar código existente
3. **L**iskov Substitution Principle (LSP)
- Cualquier implementación de PokemonGateway puede sustituirse sin romper funcionalidad
4. **I**nterface Segregation Principle (ISP)
- Interfaces pequeñas y específicas (PokemonGateway solo tiene 2 métodos)
5. **D**ependency Inversion Principle (DIP)
- Las capas de alto nivel NO dependen de detalles de implementación
- GetPokemonUseCase depende de PokemonGateway (abstracción), no de PokemonApi
- UI depende de Use Cases, no de la API

### **DRY (Don't Repeat Yourself)**
- Mappers centralizados, widgets reutilizables

### **KISS (Keep It Simple)**
- Código simple y legible, sin sobre-ingeniería



## **Patrones**

### **Repository Pattern**
- PokemonGateway
### **Dependency Injection**
- UseCaseConfig
### **State Pattern**
- PokemonUiState con Freezed
### **Observer Pattern**
- Riverpod providers
### **Adapter Pattern**
- PokemonMapper
### **MVVM (Model-View View Model)**
- Providers como ViewModels



## **Tecnologias usadas**
### Core

Flutter 3.19.3 - Framework UI multiplataforma
Dart 3.3.1 - Lenguaje de programación

### State Management

Riverpod 2.6.1 - Manejo de estado reactivo y dependency injection
Freezed 2.4.5 - Generación de código para modelos inmutables y pattern matching

### Networking

Dio 5.9.0 - Cliente HTTP para consumir la API REST

### Testing

flutter_test - Framework de testing nativo
Mockito 5.4.4 - Generación de mocks para unit tests

### Code Generation

build_runner - Herramienta para generación de código
freezed_annotation - Anotaciones para Freezed

## **Uso de Inteligencia Artificial en el Desarrollo**
### Herramientas utilizadas:
- Claude Sonnet 4.5
- ChatGPT 5

### Metodología usada
#### Reglas Establecidas para IA
- Solicitar explicaciones arquitectónicas antes de implementar ✅
- Pedir alternativas cuando algo no es claro ✅
- NO copiar código ciegamente sin entender ❌
- NO aceptar soluciones sobre-ingenieradas ❌


## Posibles mejoras para el software
- Persistencia local con Hive/SQLite
- Caché de imágenes con cached_network_image
- Paginación infinita en lista
- Modo oscuro
- Animaciones avanzadas
- Widget tests e Integration tests