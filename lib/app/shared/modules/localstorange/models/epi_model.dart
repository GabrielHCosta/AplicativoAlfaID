import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class EPIModel extends DateCustom {
  final int id;
  final String descricao;
  final String ca;
  final String validade;

  EPIModel({
    this.id,
    @required this.descricao,
    @required this.ca,
    @required this.validade,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory EPIModel.fromMap(Map<String, dynamic> map) {
    return EPIModel(
        id: map['id'],
        descricao: map['descricao'],
        ca: map['ca'],
        validade: map['validade'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'ca': ca,
      'validade': validade,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'EPIModel{id: $id, descricao: $descricao, ca: $ca, validade: $validade, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
