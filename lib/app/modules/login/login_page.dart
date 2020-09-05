import 'package:controle_epi_flutter/app/modules/login/shared/modules/localstorage/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    controller.share().then((value) {
      if (value) {
        _goHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey, body: _buildContainer());
  }

  _imageLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 35),
      child: Image.asset(
        "images/logoSimboloEscritoAlfaTeste.png",
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      ),
    );
  }

  _imputTextCPF() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(color: Color(0xFF013A65), fontSize: 20.0),
        controller: _cpfController,
        cursorColor: Color(0xFF013A65),
        decoration: InputDecoration(
          labelText: "CPF",
          labelStyle: TextStyle(color: Color(0xFF013A65)),
          hintStyle: TextStyle(
              color: Color(0xFF013A65),
              fontFamily: "WorkSansLight",
              fontSize: 18.0),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.white24, width: 0.5)),
          prefixIcon: const Icon(
            Icons.account_box,
            color: Color(0xFF013A65),
          ),
        ),
      ),
    );
  }

  _imputTextSenha() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        style: TextStyle(color: Color(0xFF013A65), fontSize: 20.0),
        controller: _passwordController,
        cursorColor: Color(0xFF013A65),
        decoration: InputDecoration(
          labelText: "Senha",
          labelStyle: TextStyle(color: Color(0xFF013A65)),
          hintStyle: TextStyle(
              color: Color(0xFF013A65),
              fontFamily: "WorkSansLight",
              fontSize: 18.0),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.white24, width: 0.5)),
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Color(0xFF013A65),
          ),
        ),
        obscureText: true,
      ),
    );
  }

  _loginButton() {
    return SizedBox(
      height: 40,
      width: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: RaisedButton(
          color: Color(0xFF013A65),
          child: Text(
            "Entrar",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await controller
                .login(DadosLogin(
                    cpf: _cpfController.text,
                    password: controller.encript(_passwordController.text)))
                .then((value) {
              if (value) _goHome();
            });
          },
        ),
      ),
    );
  }

  _salvarDados() {
    return SizedBox(
      height: 40,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: controller.checkBox,
            onChanged: (bool newValue) {
              setState(() {
                controller.checkBox = newValue;
              });
            },
          ),
          Expanded(child: Text("Salvar dados para login")),
        ],
      ),
    );
  }

  _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _imageLogo(),
                  _imputTextCPF(),
                  SizedBox(
                    height: 25.0,
                  ),
                  _imputTextSenha(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              "Procure o Administrador para recuperar o acesso!"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 4),
                        ));
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                        style:
                            TextStyle(color: Color(0xFF013A65), fontSize: 13.0),
                      ),
                    ),
                  ),
                  _salvarDados(),
                  SizedBox(
                    height: 40,
                  ),
                  _loginButton(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _goHome() {
    Navigator.pushNamed(context, '/ficha');
  }
}
