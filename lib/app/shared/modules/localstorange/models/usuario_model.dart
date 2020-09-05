import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class UsuarioModel extends DateCustom {
  final int id;
  final String senha;
  final int idFuncionario;
  final int idProjeto;

  FuncionarioModel funcionario;
  ProjetoModel projeto;

  UsuarioModel({
    this.id,
    @required this.senha,
    @required this.idFuncionario,
    this.idProjeto,
    this.funcionario,
    this.projeto,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
        id: map['id'],
        senha: map['senha'],
        idFuncionario: map['id_funcionario'],
        idProjeto: map['id_projeto'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senha': senha,
      'id_funcionario': idFuncionario,
      'id_projeto': idProjeto,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'UsuarioModel{id: $id, senha: $senha, id_funcionario: $idFuncionario, id_projeto: $idProjeto, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
