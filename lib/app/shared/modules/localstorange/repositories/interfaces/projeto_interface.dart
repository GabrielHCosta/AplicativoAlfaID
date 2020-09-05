import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';

abstract class IProjetoRepository {
  Future<int> insert(ProjetoModel row);
  Future<List<ProjetoModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(ProjetoModel row);
  Future<int> delete(id);
  Future<ProjetoModel> findById(id);
}
