import 'dart:io';

import 'package:finances/app/data/models/movimentacoes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MovimentacoesDbProvider {
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "meu_dinheiro.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Movimentacoes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          data TEXT,
          valor TEXT,
          icon INTEGER,
          isDespesa INTEGER
          )""");
    });
  }

  Future<int> addItem(ItemMovimentacao item) async {
    final db = await init();
    return db.insert(
      "Movimentacoes",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<ItemMovimentacao>> buscarMovimentacoes() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db.query("Movimentacoes"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      ItemMovimentacao item = ItemMovimentacao.fromMap(maps[i]);
      return item;
    });
  }

  Future<int> deletarMovimentacoes(int id) async {
    final db = await init();

    int result = await db.delete("Movimentacoes", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }

  Future<int> atualizarMovimentacao(int id, ItemMovimentacao item) async {
    final db = await init();

    int result = await db.update("Movimentacoes", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
