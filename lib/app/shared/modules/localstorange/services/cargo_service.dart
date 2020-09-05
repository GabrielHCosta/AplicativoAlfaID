import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/cargo_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/cargo_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/cargo_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CargoService extends Disposable implements ICargoService {
  final ICargoRepository cargoRepository;
  CargoService({@required this.cargoRepository});

  Future<List<CargoModel>> queryAllRows() async {
    return await cargoRepository.queryAllRows();
  }

  Future<int> insert(CargoModel row) async {
    final id = await cargoRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<CargoModel> findById(id) async {
    return await cargoRepository.findById(id);
  }

  Future<int> update(CargoModel row) async {
    final linesChanges = await cargoRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await cargoRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await cargoRepository.queryRowCount();
  }

  @override
  void dispose() {}
}
