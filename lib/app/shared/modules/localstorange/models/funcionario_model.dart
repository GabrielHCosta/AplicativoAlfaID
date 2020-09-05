import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/cargo_model.dart';
import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class FuncionarioModel extends DateCustom {
  final int id;
  final String nome;
  final String cpf;
  final String matricula;
  final int pin;
  final idCargo;

  CargoModel cargo;

  FuncionarioModel({
    this.id,
    @required this.nome,
    @required this.cpf,
    @required this.matricula,
    @required this.pin,
    @required this.idCargo,
    cargo,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory FuncionarioModel.fromMap(Map<String, dynamic> map) {
    return FuncionarioModel(
        id: map['id'],
        nome: map['nome'],
        cpf: map['cpf'],
        matricula: map['matricula'],
        pin: map['pin'],
        idCargo: map['id_cargo'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'matricula': matricula,
      'pin': pin,
      'id_cargo': idCargo,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'FuncionarioModel{id: $id, nome: $nome, cpf: $cpf, matricula: $matricula, id_cargo: $idCargo, pin: $pin, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
