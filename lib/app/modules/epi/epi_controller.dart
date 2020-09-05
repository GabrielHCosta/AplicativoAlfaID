import 'package:controle_epi_flutter/app/modules/ficha/ficha_controller.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/epi_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/funcionario_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:mobx/mobx.dart';

part 'epi_controller.g.dart';

class EPIController = _EPIControllerBase with _$EPIController;

abstract class _EPIControllerBase with Store {
  final FichaController projetoController = Modular.get();

  final IFuncionarioService funcionarioService;
  final IEPIService epiService;
  final IFichaService fichaService;

  _EPIControllerBase(
      {@required this.epiService,
      @required this.funcionarioService,
      @required this.fichaService});

  Future<EPIModel> getEPIByCA(String ca) async {
    return await epiService.getEPIByCA(ca);
  }

  Future<String> readCode() async {
    String cameraScanResult = await scanner.scan();

    if (cameraScanResult != null) {
      await getEPIByCA(cameraScanResult);
      return cameraScanResult;
    }
    return "";
  }

  Future<FuncionarioModel> getFuncionario(String cpf) async {
    return await funcionarioService.getFuncionariobyCPF(cpf);
  }

  Future<FichaModel> getFicha(int funcionario) async {
    return await fichaService.getFicha(
        funcionario, projetoController.projeto.id);
  }

  Future<int> inserirFicha(int funcionario) async {
    return await fichaService.insert(FichaModel(
        idFuncionario: funcionario, idProjeto: projetoController.projeto.id));
  }
}
