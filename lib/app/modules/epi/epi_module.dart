import 'package:controle_epi_flutter/app/modules/epi/epi_controller.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/epi_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/funcionario_interface.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'epi_page.dart';

class EPIModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EPIController(
              epiService: i.get<IEPIService>(),
              funcionarioService: i.get<IFuncionarioService>(),
              fichaService: i.get<IFichaService>(),
            )),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => EPIPage()),
      ];

  static Inject get to => Inject<EPIModule>.of();
}
