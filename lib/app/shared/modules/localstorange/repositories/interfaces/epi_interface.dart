import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';

abstract class IEPIRepository {
  Future<int> insert(EPIModel row);
  Future<List<EPIModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(EPIModel row);
  Future<int> delete(id);
  Future<EPIModel> findById(id);

  Future<EPIModel> getEPIByAC(String ca);
}
