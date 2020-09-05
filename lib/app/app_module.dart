import 'package:controle_epi_flutter/app/app_controller.dart';
import 'package:controle_epi_flutter/app/app_widget.dart';
import 'package:controle_epi_flutter/app/modules/epi/epi_module.dart';
import 'package:controle_epi_flutter/app/modules/ficha/ficha_module.dart';
import 'package:controle_epi_flutter/app/pages/splash/splash_controller.dart';
import 'package:controle_epi_flutter/app/pages/splash/splash_page.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/cargo_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/epi_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/ficha_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/filial_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/funcionario_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/cargo_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/epi_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/filial_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/funcionario_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/itemFicha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/projeto_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/interfaces/usuario_inteface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/itemFicha_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/projeto_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/repositories/usuario_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/cargo_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/epi_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/ficha_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/filial_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/funcionario_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/cargo_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/epi_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/ficha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/filial_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/funcionario_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/itemFicha_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/projeto_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/interfaces/usuario_interface.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/itemFicha_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/projeto_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/usuario_service.dart';
import 'package:controle_epi_flutter/app/shared/modules/webservice/repositories/web_repository.dart';
import 'package:controle_epi_flutter/app/shared/modules/webservice/utils/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'modules/login/login_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<ICargoRepository>((i) => CargoRepository()),
        Bind<ICargoService>((i) => CargoService(cargoRepository: i.get())),
        Bind<IEPIRepository>((i) => EPIRepository()),
        Bind<IEPIService>((i) => EPIService(epiRepository: i.get())),
        Bind<IFichaRepository>((i) => FichaRepository()),
        Bind<IFichaService>((i) => FichaService(fichaRepository: i.get())),
        Bind<IFilialRepository>((i) => FilialRepository()),
        Bind<IFilialService>((i) => FilialService(filialRepository: i.get())),
        Bind<IFuncionarioRepository>((i) => FuncionarioRepository()),
        Bind<IFuncionarioService>(
            (i) => FuncionarioService(funcionarioRepository: i.get())),
        Bind<IItemFichaRepository>((i) => ItemFichaRepository()),
        Bind<IItemFichaService>(
            (i) => ItemFichaService(itemFichaRepository: i.get())),
        Bind<IProjetoRepository>((i) => ProjetoRepository()),
        Bind<IProjetoService>(
            (i) => ProjetoService(projetoRepository: i.get())),
        Bind<IUsuarioRepository>((i) => UsuarioRepository()),
        Bind<IUsuarioService>(
            (i) => UsuarioService(usuarioRepository: i.get())),
        Bind((i) => WebRepository(i.get())),
        //Bind((i) => Dio(BaseOptions(baseUrl: URL_BASE))),
        Bind((i) => CustomDio.withAuthentication().instance),
        Bind((i) => SplashController()),
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router('/login', module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/ficha', module: FichaModule()),
        Router('/epi', module: EPIModule()),
        Router('/splash', child: (_, args) => SplashPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
