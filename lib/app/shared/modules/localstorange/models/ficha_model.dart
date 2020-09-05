import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class FichaModel extends DateCustom {
  final int id;
  final int idFuncionario;
  final int idProjeto;

  FuncionarioModel funcionario;
  ProjetoModel projeto;

  FichaModel({
    this.id,
    @required this.idFuncionario,
    @required this.idProjeto,
    funcionario,
    projeto,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory FichaModel.fromMap(Map<String, dynamic> map) {
    return FichaModel(
        id: map['id'],
        idFuncionario: map['id_funcionario'],
        idProjeto: map['id_projeto'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_funcionario': idFuncionario,
      'id_projeto': idProjeto,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'FichaModel{id: $id, id_funcionario: $idFuncionario, id_projeto: $idProjeto,date_modification: $dateModification, date_create: $dateCreate}';
  }
}
