import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';

abstract class IFuncionarioRepository {
  Future<int> insert(FuncionarioModel row);
  Future<List<FuncionarioModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(FuncionarioModel row);
  Future<int> delete(id);
  Future<FuncionarioModel> findById(id);

  Future<FuncionarioModel> getFuncionariobyCPF(String cpf);
}
