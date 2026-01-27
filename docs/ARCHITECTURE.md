# Arquitetura do Sistema

## Visão Geral

O Sistema Veterinário segue uma arquitetura em camadas com separação clara de responsabilidades.

## Camadas

### 1. Apresentação (UI)
- **Localização**: `lib/screens/`
- **Responsabilidade**: Interface do usuário e interação
- **Componentes**:
  - Telas (Screens)
  - Widgets customizados
  - Formulários

### 2. Lógica de Negócio (Providers)
- **Localização**: `lib/providers/`
- **Responsabilidade**: Gerenciamento de estado e lógica de negócio
- **Padrão**: Provider (State Management)
- **Componentes**:
  - `PetProvider`: Gerencia estado dos pets
  - `OwnerProvider`: Gerencia estado dos clientes
  - `AppointmentProvider`: Gerencia estado das consultas

### 3. Dados (Models & Database)
- **Localização**: `lib/models/` e `lib/database/`
- **Responsabilidade**: Persistência e estrutura de dados
- **Componentes**:
  - Models: Representação de entidades
  - DatabaseHelper: Operações CRUD no SQLite

## Fluxo de Dados

```
UI (Screen) 
    ↓
Provider (Business Logic)
    ↓
DatabaseHelper (Data Access)
    ↓
SQLite (Persistence)
```

## Padrões Utilizados

### 1. Singleton
- `DatabaseHelper.instance`
- Garante uma única instância do banco de dados

### 2. Repository Pattern
- `DatabaseHelper` atua como repositório
- Abstrai operações de banco de dados

### 3. Provider Pattern
- Gerenciamento de estado reativo
- Notificação automática de mudanças

### 4. Factory Pattern
- Métodos `fromMap()` nos models
- Criação de objetos a partir de dados do banco

## Estrutura de Dados

### Relacionamentos

```
Owner (1) ----< (N) Pet
Pet (1) ----< (N) Appointment
Pet (1) ----< (N) Vaccine
```

### Tabelas

#### owners
- id (PK)
- name
- email
- phone
- cpf
- address
- createdAt

#### pets
- id (PK)
- name
- species
- breed
- birthDate
- gender
- weight
- color
- ownerId (FK)
- photoPath
- createdAt

#### appointments
- id (PK)
- petId (FK)
- dateTime
- type
- status
- notes
- diagnosis
- treatment
- createdAt

#### vaccines
- id (PK)
- petId (FK)
- name
- applicationDate
- nextDoseDate
- batch
- veterinarian
- notes
- createdAt

## Navegação

O app utiliza Navigator 2.0 com rotas imperativas:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Screen()),
);
```

## Gerenciamento de Estado

### Provider
- Usado para estado global (pets, owners, appointments)
- ChangeNotifier para notificar mudanças
- Consumer widgets para reconstrução reativa

### StatefulWidget
- Usado para estado local (formulários, UI temporária)
- setState() para atualizações locais

## Validação

### Formulários
- Validação no lado do cliente
- GlobalKey<FormState> para controle
- Validators customizados

### Banco de Dados
- Constraints de NOT NULL
- Foreign Keys com ON DELETE CASCADE
- Validação de tipos

## Tratamento de Erros

### Async/Await
- Try-catch em operações assíncronas
- Future.wait para operações paralelas

### UI Feedback
- SnackBars para mensagens
- CircularProgressIndicator para loading
- Dialogs para confirmações

## Performance

### Otimizações
- Uso de const constructors
- ListView.builder para listas grandes
- FutureBuilder para dados assíncronos
- Lazy loading de dados

### Banco de Dados
- Índices em chaves estrangeiras
- Queries otimizadas
- Transações quando necessário

## Segurança

### Dados Locais
- SQLite armazenado localmente
- Sem exposição de dados sensíveis
- Validação de entrada

## Escalabilidade

### Preparado para:
- Adicionar novos módulos
- Integração com backend
- Autenticação de usuários
- Sincronização na nuvem

## Testes

### Estrutura
- Unit tests para models
- Widget tests para UI
- Integration tests para fluxos completos

## Dependências Principais

- **flutter**: Framework base
- **provider**: State management
- **sqflite**: Banco de dados local
- **intl**: Internacionalização
- **table_calendar**: Calendário
- **mask_text_input_formatter**: Máscaras de entrada
