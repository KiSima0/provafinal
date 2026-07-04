import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'study_planner.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE disciplinas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        professor TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE atividades(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        dataEntrega TEXT NOT NULL,
        disciplinaId INTEGER NOT NULL,
        FOREIGN KEY (disciplinaId)
        REFERENCES disciplinas(id)
      )
    ''');
  }

  Future<int> insertDisciplina(Map<String, dynamic> disciplina) async {
    final db = await database;

    return await db.insert(
      'disciplinas',
      disciplina,
    );
  }

  Future<List<Map<String, dynamic>>> getDisciplinas() async {
    final db = await database;

    return await db.query('disciplinas');
  }

  Future<int> getTotalDisciplinas() async {
    final db = await database;

    final resultado = await db.rawQuery(
      'SELECT COUNT(*) as total FROM disciplinas',
    );

    return resultado.first['total'] as int;
  }

  Future<int> updateDisciplina(
    int id,
    Map<String, dynamic> disciplina,
  ) async {
    final db = await database;

    return await db.update(
      'disciplinas',
      disciplina,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

Future<int> deleteDisciplina(int id) async {
  final db = await database;

  await db.delete(
    'atividades',
    where: 'disciplinaId = ?',
    whereArgs: [id],
  );

  return await db.delete(
    'disciplinas',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<int> insertAtividade(
    Map<String, dynamic> atividade,
  ) async {
    final db = await database;

    return await db.insert(
      'atividades',
      atividade,
    );
  }

  Future<List<Map<String, dynamic>>> getAtividades(
    int disciplinaId,
  ) async {
    final db = await database;

    return await db.query(
      'atividades',
      where: 'disciplinaId = ?',
      whereArgs: [disciplinaId],
    );
  }

  Future<int> getTotalAtividades() async {
    final db = await database;

    final resultado = await db.rawQuery(
      'SELECT COUNT(*) as total FROM atividades',
    );

    return resultado.first['total'] as int;
  }

  Future<List<Map<String, dynamic>>> getUltimasAtividades() async {
    final db = await database;

    return await db.query(
      'atividades',
      orderBy: 'id DESC',
      limit: 5,
    );
  }

  Future<int> updateAtividade(
    int id,
    Map<String, dynamic> atividade,
  ) async {
    final db = await database;

    return await db.update(
      'atividades',
      atividade,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAtividade(int id) async {
    final db = await database;

    return await db.delete(
      'atividades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}