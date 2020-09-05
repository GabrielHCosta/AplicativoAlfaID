import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/funcionario_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/projeto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class FichaRepository extends Disposable implements IFichaRepository {
  static final _table = "ficha";
  static Future<Database> _database;
  FichaRepository() {
    _database = DatabaseHelper.instance.database;
  }

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(FichaModel row) async {
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
  Future<List<FichaModel>> queryAllRows() async {
    final Database db = await _database;
    FuncionarioService funcionarioService = Modular.get();
    ProjetoService projetoService = Modular.get();

    try {
      List<FichaModel> list = new List<FichaModel>();

      final category = await db.query(_table);
      list = List.generate(category.length, (i) {
        return FichaModel(
          id: category[i]['id'],
          idFuncionario: category[i]['id_funcionario'],
          idProjeto: category[i]['id_projeto'],
          dateModification: category[i]['date_modification'],
        );
      });

      for (var i = 0; i < list.length; i++) {
        int idFuncionario = list[i].idFuncionario;
        int idProjeto = list[i].idProjeto;

        list[i].funcionario =
            await Future.value(funcionarioService.findById(idFuncionario));
        list[i].projeto =
            await Future.value(projetoService.findById(idProjeto));
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
  Future<int> update(FichaModel row) async {
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

  Future<FichaModel> findById(id) async {
    final Database db = await _database;
    FuncionarioService funcionarioService = Modular.get();
    ProjetoService projetoService = Modular.get();
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "id_funcionario",
            "id_projeto",
            "date_modification",
            "date_create"
          ],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        FichaModel ficha = FichaModel.fromMap(maps.first);

        int idFuncionario = ficha.id;
        int idProjeto = ficha.idProjeto;

        ficha.funcionario =
            await Future.value(funcionarioService.findById(idFuncionario));
        ficha.projeto = await Future.value(projetoService.findById(idProjeto));

        return ficha;
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<List<FichaModel>> getFichasProjeto(id) async {
    final Database db = await _database;
    FuncionarioService funcionarioService = Modular.get();
    ProjetoService projetoService = Modular.get();

    String query = "SELECT * FROM $_table WHERE id_projeto = ?;";

    try {
      List<FichaModel> list = new List<FichaModel>();

      final category = await db.rawQuery(query, [id]);
      list = List.generate(category.length, (i) {
        return FichaModel(
          id: category[i]['id'],
          idFuncionario: category[i]['id_funcionario'],
          idProjeto: category[i]['id_projeto'],
          dateModification: category[i]['date_modification'],
        );
      });

      for (var i = 0; i < list.length; i++) {
        int idFuncionario = list[i].idFuncionario;
        int idProjeto = list[i].idProjeto;

        list[i].funcionario =
            await Future.value(funcionarioService.findById(idFuncionario));
        list[i].projeto =
            await Future.value(projetoService.findById(idProjeto));
      }

      return list;
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<FichaModel> getFicha(int funcionario, int projeto) async {
    final Database db = await _database;
    FuncionarioService funcionarioService = Modular.get();
    ProjetoService projetoService = Modular.get();
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "id_funcionario",
            "id_projeto",
            "date_modification",
            "date_create"
          ],
          where: 'id_funcionario = ? and id_projeto = ?',
          whereArgs: [funcionario, projeto]);

      if (maps.first.length > 0) {
        FichaModel ficha = FichaModel.fromMap(maps.first);

        int idFuncionario = ficha.id;
        int idProjeto = ficha.idProjeto;

        ficha.funcionario =
            await Future.value(funcionarioService.findById(idFuncionario));
        ficha.projeto = await Future.value(projetoService.findById(idProjeto));

        return ficha;
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
