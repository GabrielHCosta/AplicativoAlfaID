import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/cargo_model.dart';

abstract class ICargoService {
  Future<int> insert(CargoModel row);
  Future<List<CargoModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(CargoModel row);
  Future<int> delete(id);
  Future<CargoModel> findById(id);
}
