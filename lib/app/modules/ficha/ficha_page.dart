import 'package:controle_epi_flutter/app/modules/ficha/ficha_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FichaPage extends StatefulWidget {
  @override
  _FichaPageState createState() => _FichaPageState();
}

class _FichaPageState extends ModularState<FichaPage, FichaController> {
  //use 'controller' variable to access controller
  final controller = Modular.get();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildContainer(),
      bottomNavigationBar: _bottoAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/epi');
        },
        tooltip: 'Adicionar Ficha de EPI',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _codigoAp(String cod) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 15),
      child: Text(
        cod,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF013A65),
          fontSize: 15,
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: Text(
        "Fichas de EPI's",
        style: TextStyle(color: Color(0xFF013A65)),
      ),
      actions: [
        _codigoAp(
            controller.loginController.usuario.projeto.codigoAP.toString())
      ],
      backgroundColor: Colors.white,
    );
  }

  _buildContainer() {
    return Observer(builder: (_) {
      if (controller.cardsList.error != null) {
        return Center(child: Text('Erro'));
      }

      if (controller.cardsList.value == null) {
        return Center(child: CircularProgressIndicator());
      }

      var list = controller.cardsList.value;

      return ListView.builder(
        itemCount: list.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            child: InkWell(
              splashColor: Color(0xFF013A65).withAlpha(150),
              onTap: () {
                //Navigator.pushNamed(context, '/epi');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.assignment,
                          color: Color(0xFF013A65), size: 50),
                      title: Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          list[index].funcionario.nome.toString(),
                          style: TextStyle(
                            color: Color(0xFF013A65),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          list[index].projeto.descricao.toString(),
                          style: TextStyle(
                            color: Color(0xFF013A65),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit,
                            color: Color(0xFF013A65), size: 20),
                        onPressed: () {
                          print("Editar Home pressionado");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 91, bottom: 15),
                      child: Row(
                        children: [
                          Text(
                            list[index].funcionario.cpf.toString(),
                            style: TextStyle(
                              color: Color(0xFF013A65),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  _bottoAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 55.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              "Adicionar Lançamento de EPI",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF013A65),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
