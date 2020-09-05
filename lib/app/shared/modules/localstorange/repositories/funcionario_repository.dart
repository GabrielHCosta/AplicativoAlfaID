import 'dart:async';

import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/cargo_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

import 'interfaces/funcionario_interface.dart';

class FuncionarioRepository extends Disposable
    implements IFuncionarioRepository {
  static final _table = "Funcionario";
  static Future<Database> _database;
  FuncionarioRepository() {
    _database = DatabaseHelper.instance.database;
  }

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(FuncionarioModel row) async {
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
  Future<List<FuncionarioModel>> queryAllRows() async {
    final Database db = await _database;
    CargoService cargoService = Modular.get();
    List<FuncionarioModel> list = new List<FuncionarioModel>();

    try {
      final category = await db.query(_table);
      list = List.generate(category.length, (i) {
        return FuncionarioModel(
          id: category[i]['id'],
          nome: category[i]['nome'],
          cpf: category[i]['cpf'],
          matricula: category[i]['matricula'],
          pin: category[i]['pin'],
          idCargo: category[i]['id_cargo'],
          dateModification: category[i]['date_modification'],
        );
      });

      for (var i = 0; i < list.length; i++) {
        int idCargo = list[i].idCargo;

        list[i].cargo = await Future.value(cargoService.findById(idCargo));
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
  Future<int> update(FuncionarioModel row) async {
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

  Future<FuncionarioModel> findById(id) async {
    final Database db = await _database;
    CargoService cargoService = Modular.get();

    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "nome",
            "cpf",
            "matricula",
            "pin",
            "id_cargo",
            "date_modification",
            "date_create"
          ],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        FuncionarioModel funcionario = FuncionarioModel.fromMap(maps.first);
        funcionario.cargo =
            await Future.value(cargoService.findById(funcionario.idCargo));
        return funcionario;
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<FuncionarioModel> getFuncionariobyCPF(String cpf) async {
    final Database db = await _database;
    CargoService cargoService = Modular.get();

    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "nome",
            "cpf",
            "matricula",
            "pin",
            "id_cargo",
            "date_modification",
            "date_create"
          ],
          where: 'cpf = ?',
          whereArgs: [cpf]);

      if (maps.first.length > 0) {
        FuncionarioModel funcionario = FuncionarioModel.fromMap(maps.first);
        funcionario.cargo =
            await Future.value(cargoService.findById(funcionario.idCargo));
        return funcionario;
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  @override
  void dispose() {}
}
