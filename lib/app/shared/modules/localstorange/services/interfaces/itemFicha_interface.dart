import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';

abstract class IItemFichaService {
  Future<int> insert(ItemFichaModel row);
  Future<List<ItemFichaModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(ItemFichaModel row);
  Future<int> delete(id);
  Future<ItemFichaModel> findById(id);
}
