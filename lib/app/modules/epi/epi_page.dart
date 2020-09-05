import 'package:controle_epi_flutter/app/modules/epi/itemCarrinhoEpi_model.dart';
import 'package:controle_epi_flutter/app/modules/epi/epi_controller.dart';
import 'package:controle_epi_flutter/app/modules/home/home_page.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/epi_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/ficha_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/funcionario_model.dart';
import 'package:controle_epi_flutter/app/shared/modules/localstorange/models/itemFicha_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class EPIPage extends StatefulWidget {
  List<ItemFichaModel> listaItensEpiAdicionados = new List<ItemFichaModel>();

  EPIPage() {
    listaItensEpiAdicionados = [];
  }

  @override
  _EPIPageState createState() => _EPIPageState();
}

class _EPIPageState extends State<EPIPage> {
  FuncionarioModel funcionario;
  final EPIController controller = Modular.get();

  final _cpfController = TextEditingController();
  final _dataEntregaEPIController = TextEditingController();
  final _numeroCAController = TextEditingController();
  final _nomeEquipamentoController = TextEditingController();
  final _quantidadeEquipamentoController = TextEditingController();

  String nomeTrabalhador = "";
  String funcaoTrabalhador = "";
  String _cameraScanResult = "";
  String dropdownValue = 'Primeira entrega';

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _EPIPageState() {
    _quantidadeEquipamentoController.text = "1";
  }

  @override
  void initState() {
    super.initState();
    _inicializarComDataAtual(_dataEntregaEPIController);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Color(0xFF013A65)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Lançamento de EPI's",
            style: TextStyle(color: Color(0xFF013A65)),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: confirmarButtons,
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
        ),
        body: Container(
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
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 35),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.assignment,
                                color: Color(0xFF013A65), size: 50),
                            Text(
                              "Dados do Lançamento do EPI",
                              style: TextStyle(
                                color: Color(0xFF013A65),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          onTap: verificarCarrinho,
                          onEditingComplete: buscarTrabalhador,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                              color: Color(0xFF013A65), fontSize: 20.0),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 0.5)),
                            prefixIcon: const Icon(
                              Icons.account_box,
                              color: Color(0xFF013A65),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: lerQrCode,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.camera_alt,
                                color: Color(0xFF013A65), size: 20),
                            Text(
                              "  Ler QR Code do crachá",
                              style: TextStyle(
                                color: Color(0xFF013A65),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18, right: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  nomeTrabalhador,
                                  style: TextStyle(
                                    color: Color(0xFF013A65),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  funcaoTrabalhador,
                                  style: TextStyle(
                                    color: Color(0xFF013A65),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 25.0,
                      ),

                      //Inicio Data entrega
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: Text(
                              "Data de Entrega:",
                              style: TextStyle(
                                color: Color(0xFF013A65),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 70.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  style: TextStyle(
                                      color: Color(0xFF013A65), fontSize: 20.0),
                                  controller: _dataEntregaEPIController,
                                  cursorColor: Color(0xFF013A65),
                                  decoration: InputDecoration(
                                    labelText: "dd/mm/aaaa",
                                    labelStyle:
                                        TextStyle(color: Color(0xFF013A65)),
                                    hintStyle: TextStyle(
                                        color: Color(0xFF013A65),
                                        fontFamily: "WorkSansLight",
                                        fontSize: 18.0),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.white24, width: 0.5)),
//                                  prefixIcon: const Icon(
//                                    Icons.date_range,
//                                    color: Color(0xFF013A65),
//                                  ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70.0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(
                                Icons.date_range,
                                size: 30,
                                color: Color(0xFF013A65),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150.0,
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            child: Text(
                              "Motivo:",
                              style: TextStyle(
                                color: Color(0xFF013A65),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 30),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Color(0xFF013A65),
                                style: BorderStyle.solid,
                                width: .80),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 20,
                            style: TextStyle(
                                color: Color(0xFF013A65), fontSize: 20),
                            underline: Container(
                              height: 1,
                              color: Colors.transparent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              'Primeira entrega',
                              'Substituição',
                              'Dano',
                              'Perda'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      Text(
                        "Dados do EPI:",
                        style: TextStyle(
                          color: Color(0xFF013A65),
                          fontSize: 20,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          onEditingComplete: buscarEPI,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                              color: Color(0xFF013A65), fontSize: 20.0),
                          controller: _numeroCAController,
                          cursorColor: Color(0xFF013A65),
                          decoration: InputDecoration(
                            labelText: "C.A. (Somente números)",
                            labelStyle: TextStyle(color: Color(0xFF013A65)),
                            hintStyle: TextStyle(
                                color: Color(0xFF013A65),
                                fontFamily: "WorkSansLight",
                                fontSize: 18.0),
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 0.5)),
                            prefixIcon: const Icon(
                              Icons.settings_ethernet,
                              color: Color(0xFF013A65),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: lerCodiogoBarra,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.camera_alt,
                                color: Color(0xFF013A65), size: 20),
                            Text(
                              "  Ler código de barra do C.A.",
                              style: TextStyle(
                                color: Color(0xFF013A65),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          style: TextStyle(
                              color: Color(0xFF013A65), fontSize: 20.0),
                          controller: _nomeEquipamentoController,
                          readOnly: true,
                          cursorColor: Color(0xFF013A65),
                          decoration: InputDecoration(
                            labelText: "Nome do Equipamento",
                            labelStyle: TextStyle(color: Color(0xFF013A65)),
                            hintStyle: TextStyle(
                                color: Color(0xFF013A65),
                                fontFamily: "WorkSansLight",
                                fontSize: 18.0),
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 0.5)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: RaisedButton(
                            color: Color(0xFF013A65),
                            child: Text(
                              "Adicionar",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              adicionarButton();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _inicializarComDataAtual(TextEditingController _dataController) {
    //Formatando data
    String dataFormatada = DateFormat('dd/MM/yyyy').format(new DateTime.now());

    setState(() {
      _dataController.text = dataFormatada;
    });
  }

  mostrarErro(String erro) {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        erro,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }

  adicionarButton() async {
    EPIModel epi = await controller.getEPIByCA(_numeroCAController.text);
    funcionario = await controller.getFuncionario(_cpfController.text);

    if (widget.listaItensEpiAdicionados.length != 0) {
      if (funcionario.cpf !=
          widget.listaItensEpiAdicionados[0].ficha.funcionario.cpf) {
        mostrarErro("1 funcionario por vez");
        return null;
      }
    }

    if (epi == null) {
      mostrarErro("CA inválido");
    } else if (funcionario == null) {
      mostrarErro("Funcionario não encontrato");
    } else if (_cpfController.text.isEmpty ||
        _numeroCAController.text.isEmpty ||
        _nomeEquipamentoController.text.isEmpty) {
      mostrarErro("Preencha todos os campos obrigatórios!");
    } else {
      FichaModel ficha = await controller.getFicha(funcionario.id);
      int idFicha;

      if (ficha == null) {
        idFicha = await controller.inserirFicha(funcionario.id);
      } else {
        idFicha = ficha.id;
      }

      ficha = await controller.getFicha(funcionario.id);

      ItemFichaModel item = new ItemFichaModel(
          quantidade: 1,
          entrega: DateTime.now().toString(),
          devolucao: "",
          idEpi: idFicha,
          idFicha: idFicha,
          epi: epi,
          ficha: ficha);

      //item.nome = _nomeEquipamentoController.text;
      // item.numeroCA = _numeroCAController.text;
      widget.listaItensEpiAdicionados.add(item);

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          epi.descricao + " adicionado!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      setState(() {
        _nomeEquipamentoController.text = "";
        _numeroCAController.text = "";
      });
    }
    // colocar codigo referente a adicionar EPI na lista
  }

  confirmarButtons() {
    if (widget.listaItensEpiAdicionados.length == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Nenhum produto foi adicionado!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    } else {
      List<ItemFichaModel> lista = widget.listaItensEpiAdicionados;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(lista)),
      );
      widget.listaItensEpiAdicionados = [];
    }
  }

  buscarEPI() async {
    EPIModel epi = await controller.getEPIByCA(_numeroCAController.text);

    setState(() {
      if (epi != null) {
        _nomeEquipamentoController.text = epi.descricao.toString();
      } else {
        _nomeEquipamentoController.text = "";
      }
    });
  }

  verificarCarrinho() {
    if (widget.listaItensEpiAdicionados.length != 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "EPIS na fila de entrega",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 4),
      ));
    }
  }

  buscarTrabalhador() async {
    FuncionarioModel funcionario =
        await controller.getFuncionario(_cpfController.text);

    setState(() {
      if (funcionario != null) {
        nomeTrabalhador = "NOME: " + funcionario.nome.toString();
        funcaoTrabalhador = "FUNÇÃO: " + funcionario.cargo.descricao.toString();
      } else {
        nomeTrabalhador = "";
        funcaoTrabalhador = "";
      }
    });
  }

  void lerQrCode() async {
    _cameraScanResult = await controller.readCode();

    setState(() {
      _cpfController.text = _cameraScanResult;
    });
    buscarTrabalhador();
  }

  void lerCodiogoBarra() async {
    _cameraScanResult = await controller.readCode();

    setState(() {
      _numeroCAController.text = _cameraScanResult;
    });

    buscarEPI();
  }
}
