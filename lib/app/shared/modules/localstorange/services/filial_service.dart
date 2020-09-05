import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/filial_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/filial_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/filial_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FilialService extends Disposable implements IFilialService {
  final IFilialRepository filialRepository;
  FilialService({@required this.filialRepository});

  Future<List<FilialModel>> queryAllRows() async {
    return await filialRepository.queryAllRows();
  }

  Future<int> insert(FilialModel row) async {
    final id = await filialRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<FilialModel> findById(id) async {
    return await filialRepository.findById(id);
  }

  Future<int> update(FilialModel row) async {
    final linesChanges = await filialRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await filialRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await filialRepository.queryRowCount();
  }

  @override
  void dispose() {}
}
