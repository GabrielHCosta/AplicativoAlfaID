import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';

abstract class IFichaRepository {
  Future<int> insert(FichaModel row);
  Future<List<FichaModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(FichaModel row);
  Future<int> delete(id);
  Future<FichaModel> findById(id);
  Future<List<FichaModel>> getFichasProjeto(id);
  Future<FichaModel> getFicha(int funcionario, int projeto);
}
