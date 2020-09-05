import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FichaService extends Disposable implements IFichaService {
  final IFichaRepository fichaRepository;
  FichaService({@required this.fichaRepository});

  Future<List<FichaModel>> queryAllRows() async {
    return await fichaRepository.queryAllRows();
  }

  Future<int> insert(FichaModel row) async {
    final id = await fichaRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<FichaModel> findById(id) async {
    return await fichaRepository.findById(id);
  }

  Future<int> update(FichaModel row) async {
    final linesChanges = await fichaRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await fichaRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await fichaRepository.queryRowCount();
  }

  Future<List<FichaModel>> getFichasProjeto(id) async {
    return await fichaRepository.getFichasProjeto(id);
  }

  Future<FichaModel> getFicha(int funcionario, int projeto) async {
    return await fichaRepository.getFicha(funcionario, projeto);
  }

  @override
  void dispose() {}
}
