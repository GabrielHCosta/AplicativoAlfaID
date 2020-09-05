import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:flutter/foundation.dart';

import 'dates_model.dart';

class ItemFichaModel extends DateCustom {
  final int id;
  final String assinatura;
  final int quantidade;
  final String entrega;
  final String devolucao;
  final int idEpi;
  final int idFicha;

  EPIModel epi;
  FichaModel ficha;

  ItemFichaModel({
    this.id,
    this.assinatura,
    @required this.quantidade,
    @required this.entrega,
    @required this.devolucao,
    @required this.idEpi,
    @required this.idFicha,
    this.epi,
    this.ficha,
    dateModification,
    dateCreate,
  }) : super(dateModification: dateModification);

  factory ItemFichaModel.fromMap(Map<String, dynamic> map) {
    return ItemFichaModel(
        id: map['id'],
        assinatura: map['assinatura'],
        quantidade: map['quantidade'],
        entrega: map['entrega'],
        devolucao: map['devolucao'],
        idEpi: map['id_epi'],
        idFicha: map['id_ficha'],
        dateModification: map['date_modification'],
        dateCreate: map['date_create']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assinatura': assinatura,
      'quantidade': quantidade,
      'entrega': entrega,
      'devolucao': devolucao,
      'id_epi': idEpi,
      'id_ficha': idFicha,
      'date_modification': dateModification
    };
  }

  @override
  String toString() {
    return 'ItemFichaModel{id: $id, assinatura: $assinatura, quantidade: $quantidade, entrega: $entrega, devolucao: $devolucao, id_epi: $idEpi, id_ficha: $idFicha, date_modification: $dateModification, date_create: $dateCreate}';
  }
}
