import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/itemFicha_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/itemFicha_interface.dart';

class ItemFichaService extends Disposable implements IItemFichaService {
  final IItemFichaRepository itemFichaRepository;
  ItemFichaService({@required this.itemFichaRepository});

  Future<List<ItemFichaModel>> queryAllRows() async {
    return await itemFichaRepository.queryAllRows();
  }

  Future<int> insert(ItemFichaModel row) async {
    final id = await itemFichaRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<ItemFichaModel> findById(id) async {
    return await itemFichaRepository.findById(id);
  }

  Future<int> update(ItemFichaModel row) async {
    final linesChanges = await itemFichaRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await itemFichaRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await itemFichaRepository.queryRowCount();
  }

  @override
  void dispose() {}
}
