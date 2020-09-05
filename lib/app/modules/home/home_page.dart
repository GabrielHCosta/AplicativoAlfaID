import 'package:controle_epi_flutter/app/modules/epi/itemCarrinhoEpi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/services/itemFicha_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  List<ItemFichaModel> itens = new List<ItemFichaModel>();

  ItemFichaModel item;

  HomePage(listaItensEPIRecebido) {
    itens = [];
    itens = listaItensEPIRecebido;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void add() {
    setState(() {});
  }

  void remove(index) {
    setState(() {
      widget.itens.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xFF013A65)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "EPI's adicionados",
          style: TextStyle(color: Color(0xFF013A65)),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: _btnConcluir,
              child: Text(
                "Concluir",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF013A65),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: widget.itens.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.itens[index];

          return Dismissible(
            child: Card(
              color: Colors.white,
              child: InkWell(
                splashColor: Color(0xFF013A65).withAlpha(150),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.check_circle,
                            color: Color(0xFF013A65), size: 40),
                        title: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            item.epi.descricao ?? "",
                            style: TextStyle(
                              color: Color(0xFF013A65),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "CA: " + item.epi.ca ?? "",
                                style: TextStyle(
                                  color: Color(0xFF013A65),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "Quantidade: 1",
                                style: TextStyle(
                                  color: Color(0xFF013A65),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            key: Key(item.epi.ca),
            onDismissed: (direction) {
              print(widget.itens[index].epi.descricao + " Excluido");
              remove(index);
            },
            background: Container(
              color: Colors.red,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.delete, color: Color(0xFF013A65), size: 30),
                  Text(
                    "Excluir",
                    style: TextStyle(
                      color: Color(0xFF013A65),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Text(
                    "Excluir",
                    style: TextStyle(
                      color: Color(0xFF013A65),
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.delete, color: Color(0xFF013A65), size: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _btnConcluir() {
    if (widget.itens.isEmpty) {
      _bottomMessage("Não possui EPI's adicionados!", 2000, Colors.redAccent);
    } else {
      _pedirSenhaFuncionario(context);
    }
  }

  Future<String> _pedirSenhaFuncionario(BuildContext context) async {
    String senhaFuncionario = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senha do Funcionário'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                style: TextStyle(color: Color(0xFF013A65), fontSize: 25.0),
                obscureText: true,
                maxLength: 4,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                autofocus: true,
                decoration: new InputDecoration(
                    fillColor: Color(0xFF013A65),
                    hoverColor: Color(0xFF013A65),
                    labelStyle: TextStyle(
                        color: Color(0xFF013A65),
                        fontFamily: "WorkSansLight",
                        fontSize: 24.0),
                    labelText: 'Senha de 4 dígitos:'),
                onChanged: (value) {
                  senhaFuncionario = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Color(0xFF013A65),
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop(senhaFuncionario);
              },
            ),
            FlatButton(
              textColor: Color(0xFF013A65),
              child: Text('Ok'),
              onPressed: () {
                if (senhaFuncionario.length < 4) {
                  _bottomMessage("Digite 4 dígitos", 1500, Colors.redAccent);
                } else {
                  int pin = widget.itens[0].ficha.funcionario.pin;
                  if (senhaFuncionario == pin.toString()) {
                    _inserirList();
                    Navigator.of(context).pop();
                  } else {
                    _bottomMessage("Pin inválido", 1500, Colors.redAccent);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  _bottomMessage(mensagem, tempo, cor) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        mensagem,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      backgroundColor: cor,
      duration: Duration(milliseconds: tempo),
    ));
  }

  _inserirList() async {
    ItemFichaService service = Modular.get();
    for (var item in widget.itens) {
      await service.insert(item);
    }

    setState(() {
      widget.itens = [];
    });
    Navigator.of(context).pop();
  }
}
