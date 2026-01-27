import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/owner.dart';
import '../models/pet.dart';
import '../models/appointment.dart';
import '../models/vaccine.dart';
import '../models/payment.dart';
import '../models/service.dart';
import '../models/medical_record.dart';
import '../models/pet_photo.dart';

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
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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

    await db.execute('''
      CREATE TABLE services (
        id $idType,
        name $textType,
        description $textType,
        price $realType,
        category $textType,
        duration $intType,
        active $intType,
        createdAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE payments (
        id $idType,
        appointmentId $intType,
        serviceId INTEGER,
        amount $realType,
        paymentMethod $textType,
        status $textType,
        paymentDate $textType,
        notes TEXT,
        createdAt $textType,
        FOREIGN KEY (appointmentId) REFERENCES appointments (id) ON DELETE CASCADE,
        FOREIGN KEY (serviceId) REFERENCES services (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE medical_records (
        id $idType,
        appointmentId $intType,
        chiefComplaint $textType,
        anamnesis $textType,
        physicalExam $textType,
        temperature TEXT,
        heartRate TEXT,
        respiratoryRate TEXT,
        weight TEXT,
        diagnosis $textType,
        treatment $textType,
        prognosis TEXT,
        observations TEXT,
        createdAt $textType,
        FOREIGN KEY (appointmentId) REFERENCES appointments (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE pet_photos (
        id $idType,
        petId $intType,
        photoPath $textType,
        description TEXT,
        category $textType,
        photoDate $textType,
        createdAt $textType,
        FOREIGN KEY (petId) REFERENCES pets (id) ON DELETE CASCADE
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      const textType = 'TEXT NOT NULL';
      const intType = 'INTEGER NOT NULL';
      const realType = 'REAL NOT NULL';

      await db.execute('''
        CREATE TABLE services (
          id $idType,
          name $textType,
          description $textType,
          price $realType,
          category $textType,
          duration $intType,
          active $intType,
          createdAt $textType
        )
      ''');

      await db.execute('''
        CREATE TABLE payments (
          id $idType,
          appointmentId $intType,
          serviceId INTEGER,
          amount $realType,
          paymentMethod $textType,
          status $textType,
          paymentDate $textType,
          notes TEXT,
          createdAt $textType,
          FOREIGN KEY (appointmentId) REFERENCES appointments (id) ON DELETE CASCADE,
          FOREIGN KEY (serviceId) REFERENCES services (id)
        )
      ''');
    }

    if (oldVersion < 3) {
      const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      const textType = 'TEXT NOT NULL';
      const intType = 'INTEGER NOT NULL';

      await db.execute('''
        CREATE TABLE medical_records (
          id $idType,
          appointmentId $intType,
          chiefComplaint $textType,
          anamnesis $textType,
          physicalExam $textType,
          temperature TEXT,
          heartRate TEXT,
          respiratoryRate TEXT,
          weight TEXT,
          diagnosis $textType,
          treatment $textType,
          prognosis TEXT,
          observations TEXT,
          createdAt $textType,
          FOREIGN KEY (appointmentId) REFERENCES appointments (id) ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        CREATE TABLE pet_photos (
          id $idType,
          petId $intType,
          photoPath $textType,
          description TEXT,
          category $textType,
          photoDate $textType,
          createdAt $textType,
          FOREIGN KEY (petId) REFERENCES pets (id) ON DELETE CASCADE
        )
      ''');
    }
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

  // Service CRUD
  Future<int> createService(Service service) async {
    final db = await database;
    return await db.insert('services', service.toMap());
  }

  Future<List<Service>> getAllServices() async {
    final db = await database;
    final result = await db.query('services', where: 'active = ?', whereArgs: [1], orderBy: 'name ASC');
    return result.map((map) => Service.fromMap(map)).toList();
  }

  Future<Service?> getService(int id) async {
    final db = await database;
    final maps = await db.query('services', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Service.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateService(Service service) async {
    final db = await database;
    return await db.update('services', service.toMap(), where: 'id = ?', whereArgs: [service.id]);
  }

  Future<int> deleteService(int id) async {
    final db = await database;
    return await db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

  // Payment CRUD
  Future<int> createPayment(Payment payment) async {
    final db = await database;
    return await db.insert('payments', payment.toMap());
  }

  Future<List<Payment>> getAllPayments() async {
    final db = await database;
    final result = await db.query('payments', orderBy: 'paymentDate DESC');
    return result.map((map) => Payment.fromMap(map)).toList();
  }

  Future<List<Payment>> getPaymentsByAppointment(int appointmentId) async {
    final db = await database;
    final result = await db.query('payments', where: 'appointmentId = ?', whereArgs: [appointmentId]);
    return result.map((map) => Payment.fromMap(map)).toList();
  }

  Future<Payment?> getPayment(int id) async {
    final db = await database;
    final maps = await db.query('payments', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Payment.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updatePayment(Payment payment) async {
    final db = await database;
    return await db.update('payments', payment.toMap(), where: 'id = ?', whereArgs: [payment.id]);
  }

  Future<int> deletePayment(int id) async {
    final db = await database;
    return await db.delete('payments', where: 'id = ?', whereArgs: [id]);
  }

  // Financial Reports
  Future<double> getTotalRevenue({DateTime? startDate, DateTime? endDate}) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT SUM(amount) as total
      FROM payments
      WHERE status = 'paid'
      ${startDate != null ? "AND paymentDate >= '${startDate.toIso8601String()}'" : ''}
      ${endDate != null ? "AND paymentDate <= '${endDate.toIso8601String()}'" : ''}
    ''');
    return result.first['total'] as double? ?? 0.0;
  }

  Future<Map<String, double>> getRevenueByPaymentMethod({DateTime? startDate, DateTime? endDate}) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT paymentMethod, SUM(amount) as total
      FROM payments
      WHERE status = 'paid'
      ${startDate != null ? "AND paymentDate >= '${startDate.toIso8601String()}'" : ''}
      ${endDate != null ? "AND paymentDate <= '${endDate.toIso8601String()}'" : ''}
      GROUP BY paymentMethod
    ''');
    
    final Map<String, double> revenue = {};
    for (var row in result) {
      revenue[row['paymentMethod'] as String] = row['total'] as double? ?? 0.0;
    }
    return revenue;
  }

  // MedicalRecord CRUD
  Future<int> createMedicalRecord(MedicalRecord record) async {
    final db = await database;
    return await db.insert('medical_records', record.toMap());
  }

  Future<MedicalRecord?> getMedicalRecordByAppointment(int appointmentId) async {
    final db = await database;
    final maps = await db.query('medical_records', where: 'appointmentId = ?', whereArgs: [appointmentId]);
    if (maps.isNotEmpty) {
      return MedicalRecord.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateMedicalRecord(MedicalRecord record) async {
    final db = await database;
    return await db.update('medical_records', record.toMap(), where: 'id = ?', whereArgs: [record.id]);
  }

  Future<int> deleteMedicalRecord(int id) async {
    final db = await database;
    return await db.delete('medical_records', where: 'id = ?', whereArgs: [id]);
  }

  // PetPhoto CRUD
  Future<int> createPetPhoto(PetPhoto photo) async {
    final db = await database;
    return await db.insert('pet_photos', photo.toMap());
  }

  Future<List<PetPhoto>> getPhotosByPet(int petId) async {
    final db = await database;
    final result = await db.query('pet_photos', where: 'petId = ?', whereArgs: [petId], orderBy: 'photoDate DESC');
    return result.map((map) => PetPhoto.fromMap(map)).toList();
  }

  Future<int> deletePetPhoto(int id) async {
    final db = await database;
    return await db.delete('pet_photos', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}

