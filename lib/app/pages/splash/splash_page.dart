import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((v) {
      Modular.to.pushReplacementNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SplashScreen(
          seconds: 2,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF013A55),
              Color(0xFF013A60),
              Color(0xFF013A85),
              Color(0xFF013A85),
              Color(0xFF013A60),
              Color(0xFF013A55),
            ],
          ),
          loaderColor: Colors.transparent,
        ),
        Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/logoSimboloEscritoAlfaTeste.png"),
              scale: 0.7,
              fit: BoxFit.none,
            ),
          ),
        ),
      ],
    ));
  }
}
