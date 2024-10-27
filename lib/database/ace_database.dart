import 'package:ace_app/models/confirmation.dart';
import 'package:ace_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDir = await getDatabasesPath();
    final databasePath = join(databaseDir, 'ace_db.db');
    final database =
        openDatabase(databasePath, version: 1, onCreate: _createTables);
    return database;
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        classe TEXT,
        promotion TEXT,
        numtel TEXT,
        isConfirm INTEGER
      )
      ''',
    );

    await db.execute(
      '''
      CREATE TABLE confirmations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        date TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
      ''',
    );
  }

  // Fonction pour ajouter un utilisateur
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fonction pour récupérer tous les utilisateurs
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Fonction pour rechercher un utilisateur par nom
  Future<List<User>> searchUserByName(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'], // Recherche par nom
    );
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Fonction pour confirmer la présence d'un utilisateur
  Future<void> confirmUserPresence(int userId, bool isConfirmed) async {
    final db = await database;
    await db.update(
      'users',
      {'isConfirm': true}, // Met à jour le champ isConfirm
      where: 'id = ?',
      whereArgs: [userId],
    );

    // Ajout de la confirmation dans la table confirmations
    if (isConfirmed) {
      await db.insert(
        'confirmations',
        Confirmation(userId: userId, date: DateTime.now()).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Fonction pour remettre l'état des confirmations à false
  Future<void> resetUserConfirmations() async {
    final db = await database;
    await db.update(
      'users',
      {'isConfirm': false}, // Met à jour le champ isConfirm à false pour tous les utilisateurs
    );
  }

  // Fonction pour récupérer toutes les confirmations
  Future<List<Confirmation>> getAllConfirmations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('confirmations');
    return List.generate(maps.length, (i) {
      return Confirmation.fromMap(maps[i]);
    });
  }
}