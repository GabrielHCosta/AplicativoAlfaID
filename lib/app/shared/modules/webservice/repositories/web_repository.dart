import 'dart:convert';

import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/cargo_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/filial_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/projeto_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/usuario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/ficha_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/itemFicha_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebRepository {
  final Dio dio;
  WebRepository(this.dio);

  Future<List<CargoModel>> getCargos() async {
    return dio.get('/get/cargo').then((res) {
      return res.data['cargo']
          .map<CargoModel>((c) => CargoModel.fromMap(c))
          .toList() as List<CargoModel>;
    });
  }

  Future<List<EPIModel>> getEPIs() async {
    return dio.get('/get/epi').then((res) {
      return res.data['epi'].map<EPIModel>((c) => EPIModel.fromMap(c)).toList()
          as List<EPIModel>;
    });
  }

  Future<List<FichaModel>> getFichas() async {
    return dio.get('/get/ficha').then((res) {
      return res.data['ficha']
          .map<FichaModel>((c) => FichaModel.fromMap(c))
          .toList() as List<FichaModel>;
    });
  }

  Future<List<FilialModel>> getFiliais() async {
    return dio.get('/get/filial').then((res) {
      return res.data['filial']
          .map<FilialModel>((c) => FilialModel.fromMap(c))
          .toList() as List<FilialModel>;
    });
  }

  Future<List<FuncionarioModel>> getFuncionarios() async {
    return dio.get('/get/funcionario').then((res) {
      return res.data['funcionario']
          .map<FuncionarioModel>((c) => FuncionarioModel.fromMap(c))
          .toList() as List<FuncionarioModel>;
    });
  }

  Future<List<ItemFichaModel>> getItensFicha() async {
    return dio.get('/get/itemFicha').then((res) {
      return res.data['itemFicha']
          .map<ItemFichaModel>((c) => ItemFichaModel.fromMap(c))
          .toList() as List<ItemFichaModel>;
    });
  }

  Future<List<ProjetoModel>> getProjetos() async {
    return dio.get('/get/projeto').then((res) {
      return res.data['projeto']
          .map<ProjetoModel>((c) => ProjetoModel.fromMap(c))
          .toList() as List<ProjetoModel>;
    });
  }

  Future<List<UsuarioModel>> getUsuarios() async {
    return dio.get('/get/usuario').then((res) {
      return res.data['usuario']
          .map<UsuarioModel>((c) => UsuarioModel.fromMap(c))
          .toList() as List<UsuarioModel>;
    });
  }

  inserirFichas() async {
    final FichaService fichaService = Modular.get();

    try {
      List<FichaModel> list = await fichaService.queryAllRows();
      List<Map<String, dynamic>> map = new List();

      for (var item in list) {
        map.add(item.toMap());
      }

      for (var item in map) {
        await this.dio.post('/inserir/ficha', data: jsonEncode(item));
      }
    } catch (error) {
      print(error);
    }
  }

  inserirItensFichas() async {
    final ItemFichaService itemFichaService = Modular.get();

    try {
      List<ItemFichaModel> list = await itemFichaService.queryAllRows();
      List<Map<String, dynamic>> map = new List();

      for (var item in list) {
        map.add(item.toMap());
      }

      for (var item in map) {
        await this.dio.post('/inserir/itemFicha', data: jsonEncode(item));
      }
    } catch (error) {
      print(error);
    }
  }
}
