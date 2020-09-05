import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/funcionario_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/funcionario_interface.dart';

class FuncionarioService extends Disposable implements IFuncionarioService {
  final IFuncionarioRepository funcionarioRepository;
  FuncionarioService({@required this.funcionarioRepository});

  Future<List<FuncionarioModel>> queryAllRows() async {
    return await funcionarioRepository.queryAllRows();
  }

  Future<int> insert(FuncionarioModel row) async {
    final id = await funcionarioRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<FuncionarioModel> findById(id) async {
    return await funcionarioRepository.findById(id);
  }

  Future<int> update(FuncionarioModel row) async {
    final linesChanges = await funcionarioRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await funcionarioRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await funcionarioRepository.queryRowCount();
  }

  Future<FuncionarioModel> getFuncionariobyCPF(String cpf) async {
    return await funcionarioRepository.getFuncionariobyCPF(cpf);
  }

  @override
  void dispose() {}
}
