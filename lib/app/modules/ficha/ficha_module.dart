import 'package:controle_epi_flutter/app/modules/ficha/ficha_controller.dart';
import 'package:controle_epi_flutter/app/modules/login/login_controller.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'ficha_page.dart';

class FichaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FichaController(fichaService: i.get<IFichaService>())),
        Bind((i) => LoginController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => FichaPage()),
      ];

  static Inject get to => Inject<FichaModule>.of();
}
