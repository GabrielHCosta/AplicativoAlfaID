import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/usuario_model.dart';

abstract class IUsuarioService {
  Future<int> insert(UsuarioModel row);
  Future<List<UsuarioModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(UsuarioModel row);
  Future<int> delete(id);
  Future<UsuarioModel> findById(id);

  Future<UsuarioModel> auth(String cpf, String password);
}
