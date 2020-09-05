import 'package:controle_epi_flutter/app/modules/login/shared/modules/localstorage/local_storage_interface.dart';
import 'package:controle_epi_flutter/app/modules/login/shared/modules/localstorage/local_storage_share.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/usuario_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController(usuarioService: i.get<IUsuarioService>())),
        Bind<ILocalStorage>((i) => LocalStorageShared()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
