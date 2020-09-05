// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ficha_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FichaController on _FichaControllerBase, Store {
  final _$cardsListAtom = Atom(name: '_FichaControllerBase.cardsList');

  @override
  ObservableFuture<List<FichaModel>> get cardsList {
    _$cardsListAtom.reportRead();
    return super.cardsList;
  }

  @override
  set cardsList(ObservableFuture<List<FichaModel>> value) {
    _$cardsListAtom.reportWrite(value, super.cardsList, () {
      super.cardsList = value;
    });
  }

  @override
  String toString() {
    return '''
cardsList: ${cardsList}
    ''';
  }
}
