import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';

abstract class IEPIService {
  Future<int> insert(EPIModel row);
  Future<List<EPIModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(EPIModel row);
  Future<int> delete(id);
  Future<EPIModel> findById(id);

  Future<EPIModel> getEPIByCA(String ca);
}
