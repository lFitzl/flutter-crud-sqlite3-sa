import 'package:senati_apps/models/AlumnoModel.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';

class DbProvider {
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "BaseDatosSQLite.db");
    print(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE alumnos(
          codigo TEXT PRIMARY KEY ,
          nombre TEXT,
          direccion TEXT)""");
    });
  }

  Future<int> addAlumno(AlumnoModel item) async {
    final db = await init();
    return db.insert(
      "alumnos",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<AlumnoModel>> getAlumnos() async {
    final db = await init();
    final maps = await db.query("alumnos");

    return List.generate(maps.length, (i) {
      return AlumnoModel(
        codigo: maps[i]['codigo'],
        nombre: maps[i]['nombre'],
        direccion: maps[i]['direccion'],
      );
    });
  }

  Future<int> deleteAlumno(String codigo) async {
    final db = await init();
    int result =
        await db.delete("alumnos", where: "codigo = ?", whereArgs: [codigo]);
    return result;
  }

  Future<int> updateAlumnos(String codigo, AlumnoModel item) async {
    final db = await init();

    int result = await db.update("alumnos", item.toMap(),
        where: "codigo = ?", whereArgs: [codigo]);
    return result;
  }
}
