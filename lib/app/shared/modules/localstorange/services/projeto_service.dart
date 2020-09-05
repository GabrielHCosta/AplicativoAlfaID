import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/projeto_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/projeto_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjetoService extends Disposable implements IProjetoService {
  final IProjetoRepository projetoRepository;
  ProjetoService({@required this.projetoRepository});

  Future<List<ProjetoModel>> queryAllRows() async {
    return await projetoRepository.queryAllRows();
  }

  Future<int> insert(ProjetoModel row) async {
    final id = await projetoRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<ProjetoModel> findById(id) async {
    return await projetoRepository.findById(id);
  }

  Future<int> update(ProjetoModel row) async {
    final linesChanges = await projetoRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await projetoRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await projetoRepository.queryRowCount();
  }

  @override
  void dispose() {}
}
