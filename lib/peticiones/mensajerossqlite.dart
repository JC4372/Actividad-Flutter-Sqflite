import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqllite_project/modelos/mensajeros.dart';

class MensajerosCRUD {

  static const table = "mensajeros";

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $table(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nombre TEXT,
        foto TEXT,
        placa TEXT,
        telefono TEXT,
        whatsapp TEXT,
        moto TEXT,
        soat TEXT,
        tecno TEXT,
        activo TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      '$table.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> guardarMensajero(Mensajero mensajero) async {
    final db = await MensajerosCRUD.db();
    final data = mensajero.toMap();
    data.remove('id');
    mensajero.id = await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return mensajero.id;
  }

  static Future<List<Mensajero>> listarMensajeros() async {
    final db = await MensajerosCRUD.db();
    var result = await db.query(table, orderBy: "id");
    return result.map((e) => Mensajero.fromJson(e)).toList();
  }

  static Future<Mensajero> obtenerMensajero(int id) async {
    final db = await MensajerosCRUD.db();
    var result = await db.query(table, where: "id = ?", whereArgs: [id], limit: 1);
    return Mensajero.fromJson(result.first);
  }

  static Future<int> actualizarMensajero(Mensajero mensajero) async {
    final db = await MensajerosCRUD.db();
    final data = mensajero.toMap();
    data.putIfAbsent("createdAt", () => DateTime.now().toString());
    final result = await db.update(table, data, where: "id = ?", whereArgs: [mensajero.id]);
    return result;
  }

  static Future<void> eliminarMensajero(int id) async {
    final db = await MensajerosCRUD.db();
    try {
      await db.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Error: $err");
    }
  }
}
