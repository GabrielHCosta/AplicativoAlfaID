import 'package:controle_epi_flutter/app/app_module.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/database/init.database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //permite carregar dados dados assincronos no main()
  await DatabaseHelper.instance.database;
  runApp(ModularApp(module: AppModule()));
}
