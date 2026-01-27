import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/owner.dart';
import '../models/pet.dart';
import '../models/appointment.dart';
import '../models/vaccine.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('veterinario.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE owners (
        id $idType,
        name $textType,
        email $textType,
        phone $textType,
        address $textType,
        cpf $textType,
        createdAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE pets (
        id $idType,
        name $textType,
        species $textType,
        breed $textType,
        birthDate $textType,
        gender $textType,
        weight $realType,
        color $textType,
        ownerId $intType,
        photoPath TEXT,
        createdAt $textType,
        FOREIGN KEY (ownerId) REFERENCES owners (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE appointments (
        id $idType,
        petId $intType,
        dateTime $textType,
        type $textType,
        status $textType,
        notes TEXT,
        diagnosis TEXT,
        treatment TEXT,
        createdAt $textType,
        FOREIGN KEY (petId) REFERENCES pets (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE vaccines (
        id $idType,
        petId $intType,
        name $textType,
        applicationDate $textType,
        nextDoseDate TEXT,
        batch $textType,
        veterinarian $textType,
        notes TEXT,
        createdAt $textType,
        FOREIGN KEY (petId) REFERENCES pets (id) ON DELETE CASCADE
      )
    ''');
  }

  // Owner CRUD
  Future<int> createOwner(Owner owner) async {
    final db = await database;
    return await db.insert('owners', owner.toMap());
  }

  Future<List<Owner>> getAllOwners() async {
    final db = await database;
    final result = await db.query('owners', orderBy: 'name ASC');
    return result.map((map) => Owner.fromMap(map)).toList();
  }

  Future<Owner?> getOwner(int id) async {
    final db = await database;
    final maps = await db.query('owners', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Owner.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateOwner(Owner owner) async {
    final db = await database;
    return await db.update('owners', owner.toMap(), where: 'id = ?', whereArgs: [owner.id]);
  }

  Future<int> deleteOwner(int id) async {
    final db = await database;
    return await db.delete('owners', where: 'id = ?', whereArgs: [id]);
  }

  // Pet CRUD
  Future<int> createPet(Pet pet) async {
    final db = await database;
    return await db.insert('pets', pet.toMap());
  }

  Future<List<Pet>> getAllPets() async {
    final db = await database;
    final result = await db.query('pets', orderBy: 'name ASC');
    return result.map((map) => Pet.fromMap(map)).toList();
  }

  Future<List<Pet>> getPetsByOwner(int ownerId) async {
    final db = await database;
    final result = await db.query('pets', where: 'ownerId = ?', whereArgs: [ownerId]);
    return result.map((map) => Pet.fromMap(map)).toList();
  }

  Future<Pet?> getPet(int id) async {
    final db = await database;
    final maps = await db.query('pets', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Pet.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updatePet(Pet pet) async {
    final db = await database;
    return await db.update('pets', pet.toMap(), where: 'id = ?', whereArgs: [pet.id]);
  }

  Future<int> deletePet(int id) async {
    final db = await database;
    return await db.delete('pets', where: 'id = ?', whereArgs: [id]);
  }

  // Appointment CRUD
  Future<int> createAppointment(Appointment appointment) async {
    final db = await database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<Appointment>> getAllAppointments() async {
    final db = await database;
    final result = await db.query('appointments', orderBy: 'dateTime DESC');
    return result.map((map) => Appointment.fromMap(map)).toList();
  }

  Future<List<Appointment>> getAppointmentsByPet(int petId) async {
    final db = await database;
    final result = await db.query('appointments', where: 'petId = ?', whereArgs: [petId], orderBy: 'dateTime DESC');
    return result.map((map) => Appointment.fromMap(map)).toList();
  }

  Future<int> updateAppointment(Appointment appointment) async {
    final db = await database;
    return await db.update('appointments', appointment.toMap(), where: 'id = ?', whereArgs: [appointment.id]);
  }

  Future<int> deleteAppointment(int id) async {
    final db = await database;
    return await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }

  // Vaccine CRUD
  Future<int> createVaccine(Vaccine vaccine) async {
    final db = await database;
    return await db.insert('vaccines', vaccine.toMap());
  }

  Future<List<Vaccine>> getVaccinesByPet(int petId) async {
    final db = await database;
    final result = await db.query('vaccines', where: 'petId = ?', whereArgs: [petId], orderBy: 'applicationDate DESC');
    return result.map((map) => Vaccine.fromMap(map)).toList();
  }

  Future<int> deleteVaccine(int id) async {
    final db = await database;
    return await db.delete('vaccines', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
