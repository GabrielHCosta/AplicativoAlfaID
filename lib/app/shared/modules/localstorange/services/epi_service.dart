import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/epi_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/epi_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EPIService extends Disposable implements IEPIService {
  final IEPIRepository epiRepository;
  EPIService({@required this.epiRepository});

  Future<List<EPIModel>> queryAllRows() async {
    return await epiRepository.queryAllRows();
  }

  Future<int> insert(EPIModel row) async {
    final id = await epiRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<EPIModel> findById(id) async {
    return await epiRepository.findById(id);
  }

  Future<int> update(EPIModel row) async {
    final linesChanges = await epiRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await epiRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await epiRepository.queryRowCount();
  }

  Future<EPIModel> getEPIByCA(String ca) async {
    return await epiRepository.getEPIByAC(ca);
  }

  @override
  void dispose() {}
}
