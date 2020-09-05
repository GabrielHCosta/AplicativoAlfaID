import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

const MaterialColor alfaEngenhariaBlue = const MaterialColor(
  0xFF013A65,
  const <int, Color>{
    50: const Color(0xFF013A65),
    100: const Color(0xFF013A65),
    200: const Color(0xFF013A65),
    300: const Color(0xFF013A65),
    400: const Color(0xFF013A65),
    500: const Color(0xFF013A65),
    600: const Color(0xFF013A65),
    700: const Color(0xFF013A65),
    800: const Color(0xFF013A65),
    900: const Color(0xFF013A65),
  },
);

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Max Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: alfaEngenhariaBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
