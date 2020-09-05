import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/filial_model.dart';
import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class ProjetoModel extends DateCustom {
  final int id;
  final String codigoAP;
  final String descricao;
  final String endereco;
  final int idFilial;

  FilialModel filial;

  ProjetoModel({
    this.id,
    @required this.codigoAP,
    @required this.descricao,
    @required this.endereco,
    @required this.idFilial,
    this.filial,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory ProjetoModel.fromMap(Map<String, dynamic> map) {
    return ProjetoModel(
        id: map['id'],
        codigoAP: map['codigoAP'],
        descricao: map['descricao'],
        endereco: map['endereco'],
        idFilial: map['id_filial'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigoAP': codigoAP,
      'descricao': descricao,
      'endereco': endereco,
      'id_filial': idFilial,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'ProjetoModel{id: $id, codigoAP: $codigoAP, descricao: $descricao, endereco: $endereco, id_filial: $idFilial, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
