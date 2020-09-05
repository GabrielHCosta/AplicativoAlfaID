import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class FilialModel extends DateCustom {
  final int id;
  final String descricao;
  final String pseudonimo;
  final String cnpj;

  FilialModel({
    this.id,
    @required this.descricao,
    @required this.pseudonimo,
    @required this.cnpj,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory FilialModel.fromMap(Map<String, dynamic> map) {
    return FilialModel(
        id: map['id'],
        descricao: map['descricao'],
        pseudonimo: map['pseudonimo'],
        cnpj: map['cnpj'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'pseudonimo': pseudonimo,
      'cnpj': cnpj,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'FilialModel{id: $id, descricao: $descricao, pseudonimo: $pseudonimo, cnpj: $cnpj, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
