import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/usuario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/usuario_inteface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/usuario_interface.dart';

class UsuarioService extends Disposable implements IUsuarioService {
  final IUsuarioRepository usuarioRepository;
  UsuarioService({@required this.usuarioRepository});

  Future<List<UsuarioModel>> queryAllRows() async {
    return await usuarioRepository.queryAllRows();
  }

  Future<int> insert(UsuarioModel row) async {
    final id = await usuarioRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<UsuarioModel> findById(id) async {
    return await usuarioRepository.findById(id);
  }

  Future<int> update(UsuarioModel row) async {
    final linesChanges = await usuarioRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await usuarioRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await usuarioRepository.queryRowCount();
  }

/*
  @override
  Future<UsuarioModel> auth(String cpf, String password) async {
    return await usuarioRepository.auth(cpf, password);
  }
*/
  @override
  Future<UsuarioModel> auth(String cpf, String password) async {
    return await usuarioRepository.auth(cpf, password);
  }

  @override
  void dispose() {}
}
