import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/filial_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/projeto_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class ProjetoRepository extends Disposable implements IProjetoRepository {
  static final _table = "projeto";
  static Future<Database> _database;
  ProjetoRepository() {
    _database = DatabaseHelper.instance.database;
  }

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(ProjetoModel row) async {
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
  Future<List<ProjetoModel>> queryAllRows() async {
    final Database db = await _database;
    try {
      final category = await db.query(_table);
      FilialRepository filialRepository = Modular.get();

      List<ProjetoModel> list = new List<ProjetoModel>();
      list = List.generate(category.length, (i) {
        return ProjetoModel(
          id: category[i]['id'],
          codigoAP: category[i]['codigoAP'],
          descricao: category[i]['descricao'],
          endereco: category[i]['endereco'],
          idFilial: category[i]['id_filial'],
          dateModification: category[i]['date_modification'],
        );
      });

      for (var i = 0; i < list.length; i++) {
        int idFilial = list[i].idFilial;

        list[i].filial =
            await Future.value(filialRepository.findById(idFilial));
      }

      return list;
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
  Future<int> update(ProjetoModel row) async {
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

  Future<ProjetoModel> findById(id) async {
    final Database db = await _database;
    try {
      FilialRepository filialRepository = Modular.get();
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "codigoAP",
            "descricao",
            "endereco",
            "id_filial",
            "date_modification",
            "date_create"
          ],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        ProjetoModel projeto = ProjetoModel.fromMap(maps.first);
        projeto.filial =
            await Future.value(filialRepository.findById(projeto.idFilial));

        return projeto;
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
