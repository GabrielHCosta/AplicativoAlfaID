import 'package:controle_epi_flutter/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [];

  static Inject get to => Inject<HomeModule>.of();
}
