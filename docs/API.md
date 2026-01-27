# Documentação da API Interna

## DatabaseHelper

Classe singleton para gerenciamento do banco de dados SQLite.

### Métodos

#### Owner (Cliente)

##### `createOwner(Owner owner)`
Cria um novo cliente no banco de dados.
- **Parâmetros**: `Owner owner` - Objeto com dados do cliente
- **Retorno**: `Future<int>` - ID do cliente criado

##### `getAllOwners()`
Retorna todos os clientes cadastrados.
- **Retorno**: `Future<List<Owner>>` - Lista de clientes ordenada por nome

##### `getOwner(int id)`
Busca um cliente específico por ID.
- **Parâmetros**: `int id` - ID do cliente
- **Retorno**: `Future<Owner?>` - Cliente encontrado ou null

##### `updateOwner(Owner owner)`
Atualiza dados de um cliente existente.
- **Parâmetros**: `Owner owner` - Objeto com dados atualizados
- **Retorno**: `Future<int>` - Número de linhas afetadas

##### `deleteOwner(int id)`
Remove um cliente do banco de dados.
- **Parâmetros**: `int id` - ID do cliente
- **Retorno**: `Future<int>` - Número de linhas afetadas

#### Pet

##### `createPet(Pet pet)`
Cria um novo pet no banco de dados.
- **Parâmetros**: `Pet pet` - Objeto com dados do pet
- **Retorno**: `Future<int>` - ID do pet criado

##### `getAllPets()`
Retorna todos os pets cadastrados.
- **Retorno**: `Future<List<Pet>>` - Lista de pets ordenada por nome

##### `getPetsByOwner(int ownerId)`
Busca todos os pets de um cliente específico.
- **Parâmetros**: `int ownerId` - ID do proprietário
- **Retorno**: `Future<List<Pet>>` - Lista de pets do cliente

##### `getPet(int id)`
Busca um pet específico por ID.
- **Parâmetros**: `int id` - ID do pet
- **Retorno**: `Future<Pet?>` - Pet encontrado ou null

##### `updatePet(Pet pet)`
Atualiza dados de um pet existente.
- **Parâmetros**: `Pet pet` - Objeto com dados atualizados
- **Retorno**: `Future<int>` - Número de linhas afetadas

##### `deletePet(int id)`
Remove um pet do banco de dados.
- **Parâmetros**: `int id` - ID do pet
- **Retorno**: `Future<int>` - Número de linhas afetadas

#### Appointment (Consulta)

##### `createAppointment(Appointment appointment)`
Cria uma nova consulta no banco de dados.
- **Parâmetros**: `Appointment appointment` - Objeto com dados da consulta
- **Retorno**: `Future<int>` - ID da consulta criada

##### `getAllAppointments()`
Retorna todas as consultas cadastradas.
- **Retorno**: `Future<List<Appointment>>` - Lista de consultas ordenada por data

##### `getAppointmentsByPet(int petId)`
Busca todas as consultas de um pet específico.
- **Parâmetros**: `int petId` - ID do pet
- **Retorno**: `Future<List<Appointment>>` - Lista de consultas do pet

##### `updateAppointment(Appointment appointment)`
Atualiza dados de uma consulta existente.
- **Parâmetros**: `Appointment appointment` - Objeto com dados atualizados
- **Retorno**: `Future<int>` - Número de linhas afetadas

##### `deleteAppointment(int id)`
Remove uma consulta do banco de dados.
- **Parâmetros**: `int id` - ID da consulta
- **Retorno**: `Future<int>` - Número de linhas afetadas

#### Vaccine (Vacina)

##### `createVaccine(Vaccine vaccine)`
Cria um novo registro de vacina no banco de dados.
- **Parâmetros**: `Vaccine vaccine` - Objeto com dados da vacina
- **Retorno**: `Future<int>` - ID do registro criado

##### `getVaccinesByPet(int petId)`
Busca todas as vacinas de um pet específico.
- **Parâmetros**: `int petId` - ID do pet
- **Retorno**: `Future<List<Vaccine>>` - Lista de vacinas do pet

##### `deleteVaccine(int id)`
Remove um registro de vacina do banco de dados.
- **Parâmetros**: `int id` - ID do registro
- **Retorno**: `Future<int>` - Número de linhas afetadas

## Providers

### PetProvider

Gerencia o estado dos pets na aplicação.

#### Propriedades
- `List<Pet> pets` - Lista de pets
- `bool isLoading` - Indicador de carregamento

#### Métodos
- `loadPets()` - Carrega todos os pets do banco
- `addPet(Pet pet)` - Adiciona um novo pet
- `updatePet(Pet pet)` - Atualiza um pet existente
- `deletePet(int id)` - Remove um pet
- `getPet(int id)` - Busca um pet por ID
- `getPetsByOwner(int ownerId)` - Busca pets de um cliente

### OwnerProvider

Gerencia o estado dos clientes na aplicação.

#### Propriedades
- `List<Owner> owners` - Lista de clientes
- `bool isLoading` - Indicador de carregamento

#### Métodos
- `loadOwners()` - Carrega todos os clientes do banco
- `addOwner(Owner owner)` - Adiciona um novo cliente
- `updateOwner(Owner owner)` - Atualiza um cliente existente
- `deleteOwner(int id)` - Remove um cliente
- `getOwner(int id)` - Busca um cliente por ID

### AppointmentProvider

Gerencia o estado das consultas na aplicação.

#### Propriedades
- `List<Appointment> appointments` - Lista de consultas
- `bool isLoading` - Indicador de carregamento

#### Métodos
- `loadAppointments()` - Carrega todas as consultas do banco
- `addAppointment(Appointment appointment)` - Adiciona uma nova consulta
- `updateAppointment(Appointment appointment)` - Atualiza uma consulta existente
- `deleteAppointment(int id)` - Remove uma consulta
- `getAppointmentsByPet(int petId)` - Busca consultas de um pet
- `getAppointmentsByDate(DateTime date)` - Busca consultas de uma data específica

## Models

### Owner

```dart
class Owner {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String cpf;
  final DateTime createdAt;
}
```

### Pet

```dart
class Pet {
  final int? id;
  final String name;
  final String species;
  final String breed;
  final DateTime birthDate;
  final String gender;
  final double weight;
  final String color;
  final int ownerId;
  final String? photoPath;
  final DateTime createdAt;
}
```

### Appointment

```dart
class Appointment {
  final int? id;
  final int petId;
  final DateTime dateTime;
  final String type;
  final String status;
  final String? notes;
  final String? diagnosis;
  final String? treatment;
  final DateTime createdAt;
}
```

### Vaccine

```dart
class Vaccine {
  final int? id;
  final int petId;
  final String name;
  final DateTime applicationDate;
  final DateTime? nextDoseDate;
  final String batch;
  final String veterinarian;
  final String? notes;
  final DateTime createdAt;
}
```

## Enums e Constantes

### Espécies de Pets
- Cachorro
- Gato
- Pássaro
- Coelho
- Outro

### Gêneros
- Macho
- Fêmea

### Tipos de Consulta
- Consulta
- Vacinação
- Cirurgia
- Exame
- Retorno
- Emergência

### Status de Consulta
- Agendada
- Confirmada
- Em Atendimento
- Concluída
- Cancelada

## Exemplos de Uso

### Criar um Cliente

```dart
final owner = Owner(
  name: 'João Silva',
  email: 'joao@email.com',
  phone: '(11) 98765-4321',
  cpf: '123.456.789-00',
  address: 'Rua Exemplo, 123',
);

await context.read<OwnerProvider>().addOwner(owner);
```

### Criar um Pet

```dart
final pet = Pet(
  name: 'Rex',
  species: 'Cachorro',
  breed: 'Labrador',
  birthDate: DateTime(2020, 1, 15),
  gender: 'Macho',
  weight: 25.5,
  color: 'Amarelo',
  ownerId: 1,
);

await context.read<PetProvider>().addPet(pet);
```

### Agendar uma Consulta

```dart
final appointment = Appointment(
  petId: 1,
  dateTime: DateTime(2026, 2, 1, 14, 30),
  type: 'Consulta',
  status: 'Agendada',
  notes: 'Consulta de rotina',
);

await context.read<AppointmentProvider>().addAppointment(appointment);
```

### Registrar uma Vacina

```dart
final vaccine = Vaccine(
  petId: 1,
  name: 'V10',
  applicationDate: DateTime.now(),
  nextDoseDate: DateTime.now().add(Duration(days: 30)),
  batch: 'ABC123',
  veterinarian: 'Dr. Carlos',
  notes: 'Primeira dose',
);

await DatabaseHelper.instance.createVaccine(vaccine);
```
