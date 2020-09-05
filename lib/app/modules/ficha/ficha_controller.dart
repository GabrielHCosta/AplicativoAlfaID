import 'package:controle_epi_flutter/app/modules/login/login_controller.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/webservice/repositories/web_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'ficha_controller.g.dart';

class FichaController = _FichaControllerBase with _$FichaController;

abstract class _FichaControllerBase with Store {
  final LoginController loginController = Modular.get();
  final IFichaService fichaService;

  ProjetoModel projeto;

  @observable
  ObservableFuture<List<FichaModel>> cardsList;

  _FichaControllerBase({@required this.fichaService}) {
    projeto = loginController.usuario.projeto;
    cardsList = getFicha().asObservable();
  }

  Future<List<FichaModel>> getFicha() async {
    return await fichaService.getFichasProjeto(projeto.id);
  }
}
