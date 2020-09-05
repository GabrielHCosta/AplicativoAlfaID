import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/filial_model.dart';

abstract class IFilialRepository {
  Future<int> insert(FilialModel row);
  Future<List<FilialModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(FilialModel row);
  Future<int> delete(id);
  Future<FilialModel> findById(id);
}
