import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/epi_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/ficha_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/itemFicha_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class ItemFichaRepository extends Disposable implements IItemFichaRepository {
  static final _table = "ItemFicha";
  static Future<Database> _database;
  ItemFichaRepository() {
    _database = DatabaseHelper.instance.database;
  }

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(ItemFichaModel row) async {
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
  Future<List<ItemFichaModel>> queryAllRows() async {
    final Database db = await _database;
    try {
      final category = await db.query(_table);
      EPIRepository epiRepository = Modular.get();
      FichaRepository fichaRepository = Modular.get();

      List<ItemFichaModel> list = new List<ItemFichaModel>();
      list = List.generate(category.length, (i) {
        return ItemFichaModel(
          id: category[i]['id'],
          assinatura: category[i]['assinatura'],
          quantidade: category[i]['quantidade'],
          entrega: category[i]['entrega'],
          devolucao: category[i]['devolucao'],
          idEpi: category[i]['id_epi'],
          idFicha: category[i]['id_ficha'],
          dateModification: category[i]['date_modification'],
        );
      });

      for (var i = 0; i < list.length; i++) {
        int idEpi = list[i].idEpi;
        int idFicha = list[i].idFicha;

        list[i].epi = await Future.value(epiRepository.findById(idEpi));
        list[i].ficha = await Future.value(fichaRepository.findById(idFicha));
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
  Future<int> update(ItemFichaModel row) async {
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

  Future<ItemFichaModel> findById(id) async {
    final Database db = await _database;
    try {
      EPIRepository epiRepository = Modular.get();
      FichaRepository fichaRepository = Modular.get();

      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: [
            "id",
            "assinatura",
            "date_modification",
            "quantidade",
            "entrega",
            "devolucao",
            "id_epi",
            "id_ficha",
            "date_create"
          ],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        ItemFichaModel itemFicha = ItemFichaModel.fromMap(maps.first);
        itemFicha.epi =
            await Future.value(epiRepository.findById(itemFicha.idEpi));
        itemFicha.ficha =
            await Future.value(fichaRepository.findById(itemFicha.idFicha));

        return itemFicha;
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
