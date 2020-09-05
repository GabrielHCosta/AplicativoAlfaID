import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:controle_epi_flutter/app/modules/login/shared/modules/localstorage/local_storage_interface.dart';
import 'package:controle_epi_flutter/app/modules/login/shared/modules/localstorage/login_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/cargo_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/filial_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/usuario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/cargo_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/epi_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/ficha_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/filial_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/funcionario_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/usuario_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/itemFicha_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/projeto_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/usuario_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/webservice/repositories/web_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILocalStorage storage = Modular.get();

  final IUsuarioService usuarioService;
  bool checkBox = false;

  UsuarioModel usuario;

  WebRepository _repository = Modular.get();

  _LoginControllerBase({@required this.usuarioService}) {
    Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  String encript(String password) {
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  @action
  auth(String cpf, String password) async {
    usuario = await Future.value(usuarioService.auth(cpf, password));
    if (usuario != null) {
      //await LoginRepository().login(cpf, password);
      return true;
    } else
      return false;
  }

  @action
  share() async {
    String cpf = await storage.get('cpf');
    String password = await storage.get('password');

    if (cpf != null && password != null) return await auth(cpf, password);

    return false;
  }

  @action
  login(DadosLogin dadosLogin) {
    if (checkBox)
      save(dadosLogin);
    else
      remove();

    return auth(dadosLogin.cpf, dadosLogin.password);
  }

  @action
  save(DadosLogin dadosLogin) {
    remove();
    storage.addStringToSF('cpf', dadosLogin.cpf);
    storage.addStringToSF('password', dadosLogin.password);
  }

  @action
  void remove() {
    storage.delete('cpf');
    storage.delete('password');
  }

// -------------------------------------------------------------------------

  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult != ConnectivityResult.none) {
      print("COM INTERNET");
      inserirDados();
    } else {
      print("SEM INTERNET");
    }
  }

  inserirDados() async {
    print("INSERINDO...................................................");
    CargoService cargoService = Modular.get();
    EPIService epiService = Modular.get();
    FichaService fichaService = Modular.get();
    FilialService filialService = Modular.get();
    FuncionarioService funcionarioService = Modular.get();
    ItemFichaService itemFichaService = Modular.get();
    ProjetoService projetoService = Modular.get();
    UsuarioService usuarioService = Modular.get();

    List<CargoModel> cargo = await _repository.getCargos();
    List<EPIModel> epi = await _repository.getEPIs();
    List<FichaModel> ficha = await _repository.getFichas();
    List<FilialModel> filial = await _repository.getFiliais();
    List<FuncionarioModel> funcionario = await _repository.getFuncionarios();
    List<ItemFichaModel> itemFicha = await _repository.getItensFicha();
    List<ProjetoModel> projeto = await _repository.getProjetos();
    List<UsuarioModel> usuario = await _repository.getUsuarios();

    print("****************CARGO****************");
    for (var i = 0; i < cargo.length; i++) {
      print("execute sql : " + cargo[i].toString());
      await cargoService
          .insert(cargo[i])
          .catchError((onError) => print(onError));
    }

    print("****************EPI****************");
    for (var i = 0; i < epi.length; i++) {
      print("execute sql : " + epi[i].toString());
      await epiService.insert(epi[i]).catchError((onError) => print(onError));
    }

    print("****************FILIAL****************");
    for (var i = 0; i < filial.length; i++) {
      print("execute sql : " + filial[i].toString());
      await filialService
          .insert(filial[i])
          .catchError((onError) => print(onError));
    }

    print("****************FUNCIONARIO****************");
    for (var i = 0; i < funcionario.length; i++) {
      print("execute sql : " + funcionario[i].toString());
      await funcionarioService
          .insert(funcionario[i])
          .catchError((onError) => print(onError));
    }

    print("****************PROJETO****************");
    for (var i = 0; i < projeto.length; i++) {
      print("execute sql : " + projeto[i].toString());
      await projetoService
          .insert(projeto[i])
          .catchError((onError) => print(onError));
    }

    print("****************FICHA****************");
    for (var i = 0; i < ficha.length; i++) {
      print("execute sql : " + ficha[i].toString());
      await fichaService
          .insert(ficha[i])
          .catchError((onError) => print(onError));
    }

    print("****************ITEM-FICHA****************");
    for (var i = 0; i < itemFicha.length; i++) {
      print("execute sql : " + itemFicha[i].toString());
      await itemFichaService
          .insert(itemFicha[i])
          .catchError((onError) => print(onError));
    }

    print("****************USUARIO****************");
    for (var i = 0; i < usuario.length; i++) {
      print("execute sql : " + usuario[i].toString());
      await usuarioService
          .insert(usuario[i])
          .catchError((onError) => print(onError));
    }

    print("INSERINDO...................................................");
    print("ENVIANDO....................................................");

    print("****************FICHA****************");
    await _repository.inserirFichas();

    print("****************ITEM-FICHA****************");
    await _repository.inserirItensFichas();

    print("ENVIANDO....................................................");
  }
}
