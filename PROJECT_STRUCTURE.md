# Estrutura do Projeto

## 📁 Visão Geral

```
veterinario/
├── android/                    # Configurações Android
├── ios/                        # Configurações iOS
├── linux/                      # Configurações Linux
├── macos/                      # Configurações macOS
├── web/                        # Configurações Web
├── windows/                    # Configurações Windows
├── lib/                        # Código fonte principal
│   ├── database/              # Camada de dados
│   ├── models/                # Modelos de dados
│   ├── providers/             # Gerenciamento de estado
│   ├── screens/               # Telas do aplicativo
│   └── main.dart              # Ponto de entrada
├── docs/                       # Documentação
│   ├── API.md
│   ├── ARCHITECTURE.md
│   ├── FAQ.md
│   ├── FEATURES.md
│   ├── README.md
│   ├── SETUP.md
│   └── USAGE.md
├── test/                       # Testes
├── .gitignore                 # Arquivos ignorados pelo Git
├── CHANGELOG.md               # Histórico de versões
├── CONTRIBUTING.md            # Guia de contribuição
├── LICENSE                    # Licença MIT
├── PROJECT_STRUCTURE.md       # Este arquivo
├── README.md                  # Documentação principal
├── analysis_options.yaml      # Configurações de análise
└── pubspec.yaml              # Dependências do projeto
```

## 📂 Detalhamento das Pastas

### `/lib` - Código Fonte

#### `/lib/database`
Camada de acesso a dados com SQLite.

```
database/
└── database_helper.dart       # Singleton para operações CRUD
```

**Responsabilidades:**
- Criação e gerenciamento do banco de dados
- Operações CRUD para todas as entidades
- Queries e relacionamentos

#### `/lib/models`
Modelos de dados (entidades).

```
models/
├── appointment.dart           # Modelo de Consulta
├── owner.dart                # Modelo de Cliente
├── pet.dart                  # Modelo de Pet
└── vaccine.dart              # Modelo de Vacina
```

**Cada modelo contém:**
- Propriedades da entidade
- Construtor
- Método `toMap()` para serialização
- Factory `fromMap()` para desserialização
- Método `copyWith()` para imutabilidade

#### `/lib/providers`
Gerenciamento de estado com Provider.

```
providers/
├── appointment_provider.dart  # Estado de consultas
├── owner_provider.dart       # Estado de clientes
└── pet_provider.dart         # Estado de pets
```

**Cada provider contém:**
- Lista de entidades
- Estado de loading
- Métodos para operações CRUD
- Notificação de mudanças

#### `/lib/screens`
Telas e interfaces do usuário.

```
screens/
├── home_screen.dart              # Tela principal com navegação
├── dashboard_screen.dart         # Dashboard com estatísticas
├── owners_screen.dart            # Lista de clientes
├── owner_form_screen.dart        # Formulário de cliente
├── owner_detail_screen.dart      # Detalhes do cliente
├── pets_screen.dart              # Lista de pets
├── pet_form_screen.dart          # Formulário de pet
├── pet_detail_screen.dart        # Detalhes do pet (com abas)
├── appointments_screen.dart      # Calendário de consultas
├── appointment_form_screen.dart  # Formulário de consulta
└── vaccine_form_screen.dart      # Formulário de vacina
```

**Organização das telas:**
- Telas de listagem (`*_screen.dart`)
- Telas de formulário (`*_form_screen.dart`)
- Telas de detalhes (`*_detail_screen.dart`)

### `/docs` - Documentação

```
docs/
├── README.md              # Índice da documentação
├── SETUP.md              # Guia de instalação
├── USAGE.md              # Guia de uso
├── FEATURES.md           # Funcionalidades detalhadas
├── ARCHITECTURE.md       # Arquitetura do sistema
├── API.md               # Documentação da API
└── FAQ.md               # Perguntas frequentes
```

### `/test` - Testes

```
test/
└── widget_test.dart      # Testes de widgets (preparado)
```

**Tipos de testes planejados:**
- Unit tests (modelos e lógica)
- Widget tests (componentes UI)
- Integration tests (fluxos completos)

## 🏗️ Arquitetura em Camadas

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│         (Screens/Widgets)           │
├─────────────────────────────────────┤
│       Business Logic Layer          │
│          (Providers)                │
├─────────────────────────────────────┤
│         Data Layer                  │
│    (Models + DatabaseHelper)        │
├─────────────────────────────────────┤
│       Persistence Layer             │
│          (SQLite)                   │
└─────────────────────────────────────┘
```

## 📊 Fluxo de Dados

```
User Action (Screen)
    ↓
Provider Method
    ↓
DatabaseHelper Operation
    ↓
SQLite Database
    ↓
Return Data
    ↓
Update Provider State
    ↓
Notify Listeners
    ↓
Rebuild UI
```

## 🗄️ Estrutura do Banco de Dados

```sql
owners
├── id (PK)
├── name
├── email
├── phone
├── cpf
├── address
└── createdAt

pets
├── id (PK)
├── name
├── species
├── breed
├── birthDate
├── gender
├── weight
├── color
├── ownerId (FK → owners.id)
├── photoPath
└── createdAt

appointments
├── id (PK)
├── petId (FK → pets.id)
├── dateTime
├── type
├── status
├── notes
├── diagnosis
├── treatment
└── createdAt

vaccines
├── id (PK)
├── petId (FK → pets.id)
├── name
├── applicationDate
├── nextDoseDate
├── batch
├── veterinarian
├── notes
└── createdAt
```

## 🎨 Estrutura de Temas

```dart
MaterialApp
├── Theme
│   ├── ColorScheme (Teal)
│   ├── CardTheme
│   ├── TextTheme
│   └── IconTheme
└── Routes
    ├── HomeScreen
    │   ├── DashboardScreen
    │   ├── PetsScreen
    │   ├── OwnersScreen
    │   └── AppointmentsScreen
    └── Detail/Form Screens
```

## 📱 Navegação

```
HomeScreen (Bottom Navigation)
├── Tab 0: DashboardScreen
├── Tab 1: PetsScreen
│   └── → PetDetailScreen
│       ├── Tab: Info
│       ├── Tab: Appointments
│       └── Tab: Vaccines
│           └── → VaccineFormScreen
├── Tab 2: OwnersScreen
│   └── → OwnerDetailScreen
│       └── List of Pets
└── Tab 3: AppointmentsScreen
    └── → AppointmentFormScreen
```

## 🔧 Configurações por Plataforma

### Android (`/android`)
```
android/
├── app/
│   ├── src/main/
│   │   ├── AndroidManifest.xml
│   │   └── kotlin/
│   └── build.gradle.kts
├── gradle/
├── build.gradle.kts
└── settings.gradle.kts
```

### iOS (`/ios`)
```
ios/
├── Runner/
│   ├── Info.plist
│   └── AppDelegate.swift
├── Runner.xcodeproj/
└── Runner.xcworkspace/
```

### Web (`/web`)
```
web/
├── index.html
├── manifest.json
└── icons/
```

## 📦 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Database
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  
  # UI Components
  table_calendar: ^3.0.9
  flutter_slidable: ^3.0.1
  
  # Utilities
  intl: ^0.19.0
  mask_text_input_formatter: ^2.5.0
```

## 🎯 Convenções de Nomenclatura

### Arquivos
- Screens: `nome_screen.dart`
- Models: `nome.dart`
- Providers: `nome_provider.dart`
- Widgets: `nome_widget.dart`

### Classes
- Screens: `NomeScreen`
- Models: `Nome`
- Providers: `NomeProvider`
- Widgets: `NomeWidget`

### Variáveis
- Private: `_nomeDaVariavel`
- Public: `nomeDaVariavel`
- Constants: `NOME_DA_CONSTANTE`

## 📝 Padrões de Código

### Imports
```dart
// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:provider/provider.dart';

// Local
import '../models/pet.dart';
import '../providers/pet_provider.dart';
```

### Estrutura de Widget
```dart
class NomeScreen extends StatelessWidget {
  const NomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Título'),
      ),
      body: const Center(
        child: Text('Conteúdo'),
      ),
    );
  }
}
```

## 🔍 Localização de Recursos

### Onde encontrar...

**Operações de banco de dados:**
- `lib/database/database_helper.dart`

**Modelos de dados:**
- `lib/models/`

**Lógica de negócio:**
- `lib/providers/`

**Interfaces de usuário:**
- `lib/screens/`

**Configurações do app:**
- `lib/main.dart`
- `pubspec.yaml`

**Documentação:**
- `docs/`
- `README.md`

## 🚀 Pontos de Entrada

### Desenvolvimento
```bash
flutter run                    # Debug mode
flutter run --release         # Release mode
flutter run -d chrome         # Web
flutter run -d windows        # Windows
```

### Build
```bash
flutter build apk             # Android APK
flutter build appbundle       # Android Bundle
flutter build ios             # iOS
flutter build web             # Web
```

## 📊 Métricas do Projeto

- **Total de arquivos Dart**: ~20
- **Linhas de código**: ~3000+
- **Modelos**: 4
- **Providers**: 3
- **Screens**: 11
- **Tabelas no banco**: 4

## 🔄 Ciclo de Desenvolvimento

1. **Planejamento**: Definir funcionalidade
2. **Modelo**: Criar/atualizar model
3. **Banco**: Adicionar tabela/campos
4. **Provider**: Implementar lógica
5. **UI**: Criar/atualizar telas
6. **Teste**: Testar funcionalidade
7. **Documentação**: Atualizar docs
8. **Commit**: Versionar mudanças

## 📚 Recursos Relacionados

- [Arquitetura Detalhada](docs/ARCHITECTURE.md)
- [Documentação da API](docs/API.md)
- [Guia de Contribuição](CONTRIBUTING.md)

---

**Última atualização**: Janeiro 2026
