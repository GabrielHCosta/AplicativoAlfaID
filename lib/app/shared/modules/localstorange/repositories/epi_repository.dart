import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/epi_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class EPIRepository extends Disposable implements IEPIRepository {
  static final _table = "EPI";
  static Future<Database> _database;
  EPIRepository() {
    _database = DatabaseHelper.instance.database;
  }

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(EPIModel row) async {
    final Database db = await _database;
    try {
      return await db.insert(_table, row.toMap());
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<EPIModel>> queryAllRows() async {
    final Database db = await _database;
    try {
      final category = await db.query(_table);
      return List.generate(category.length, (i) {
        return EPIModel(
          id: category[i]['id'],
          descricao: category[i]['descricao'],
          ca: category[i]['ca'],
          validade: category[i]['validade'],
          dateModification: category[i]['date_modification'],
        );
      });
    } catch (error) {
      print(error);
    }
    return null;
  }

  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    final Database db = await _database;
    try {
      return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_table'));
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(EPIModel row) async {
    final Database db = await _database;
    try {
      return await db
          .update(_table, row.toMap(), where: 'id = ?', whereArgs: [row.id]);
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(id) async {
    final Database db = await _database;
    try {
      return await db.delete(_table, where: 'id = ?', whereArgs: [id]);
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<EPIModel> findById(id) async {
    final Database db = await _database;
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "descricao",
            "ca",
            "validade",
            "date_modification",
            "date_create"
          ],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        return EPIModel.fromMap(maps.first);
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<EPIModel> getEPIByAC(String ca) async {
    final Database db = await _database;
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "descricao",
            "ca",
            "validade",
            "date_modification",
            "date_create"
          ],
          where: 'ca = ?',
          whereArgs: [ca]);

      if (maps.first.length > 0) {
        return EPIModel.fromMap(maps.first);
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
