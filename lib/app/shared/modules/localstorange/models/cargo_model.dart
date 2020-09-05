import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class CargoModel extends DateCustom {
  final int id;
  final String descricao;

  CargoModel({
    this.id,
    @required this.descricao,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory CargoModel.fromMap(Map<String, dynamic> map) {
    return CargoModel(
        id: map['id'],
        descricao: map['descricao'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'CargoModel{id: $id, descricao: $descricao, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
