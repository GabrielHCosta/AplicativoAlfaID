import 'package:controle_epi_flutter/app/shared/modules/localstorange/enums/database.enum.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
// torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  static _initDatabase() async {
    try {
      String path = join(
          await getDatabasesPath(), DatabaseHelperEnum.getValue(DATABASE.name));
      //await deleteDatabase(path);
      return await openDatabase(path,
          version: DatabaseHelperEnum.getValue(DATABASE.version),
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    } catch (error) {
      print(error);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    print('Foreign keys turned on');
  }

  // Código SQL para criar o banco de dados e a tabela
  static Future _onCreate(Database db, int version) async {
    var sql = [
      '''DROP TABLE IF EXISTS Cargo;''',
      '''DROP TABLE IF EXISTS Funcionario;''',
      '''DROP TABLE IF EXISTS Usuario;''',
      '''DROP TABLE IF EXISTS EPI;''',
      '''DROP TABLE IF EXISTS Projeto;''',
      '''DROP TABLE IF EXISTS Ficha;''',
      '''DROP TABLE IF EXISTS ItemFicha;''',
      '''CREATE TABLE IF NOT EXISTS Cargo (
          id INTEGER primary key autoincrement,
          descricao VARCHAR(50) NOT NULL,
          date_modification datetime,
          date_create datetime
        );''',
      '''CREATE TABLE IF NOT EXISTS Filial (
            id INTEGER primary key autoincrement,
            descricao VARCHAR(50) NOT NULL,
            pseudonimo VARCHAR(60) NOT NULL,
            cnpj VARCHAR(60) NOT NULL,
            date_modification datetime,
            date_create datetime
          );''',
      '''CREATE TABLE IF NOT EXISTS Funcionario (
          id INTEGER primary key autoincrement,
          nome VARCHAR(50) NOT NULL,
          cpf VARCHAR(11) NOT NULL,
          matricula VARCHAR(20) NOT NULL,
          pin INT NOT NULL,
          id_cargo INTEGER NOT NULL,
          date_modification datetime,
          date_create datetime,
          foreign key (id_cargo) references Cargo (id) ON DELETE CASCADE
        );''',
      '''CREATE TABLE IF NOT EXISTS Usuario (
          id INTEGER primary key autoincrement,
          senha VARCHAR(40) NOT NULL,
          id_funcionario INTEGER NOT NULL,
          id_projeto INTEGER,
          date_modification datetime,
          date_create datetime,
          foreign key (id_funcionario) references Funcionario (id) ON DELETE CASCADE
        );''',
      '''CREATE TABLE IF NOT EXISTS EPI (
          id INTEGER primary key autoincrement,
          descricao VARCHAR(200) NOT NULL,
          ca VARCHAR(200) NOT NULL,
          validade DATE NOT NULL,
          date_modification datetime,
          date_create datetime
        );''',
      '''CREATE TABLE IF NOT EXISTS Projeto (
          id INTEGER primary key autoincrement,
          codigoAP VARCHAR(10) NOT NULL,
          descricao VARCHAR(200) NOT NULL,
          endereco VARCHAR(200) NOT NULL,
          id_filial INTEGER NOT NULL,
          date_modification datetime,
          date_create datetime,
          foreign key (id_filial) references Filial (id) ON DELETE CASCADE
        );''',
      '''CREATE TABLE IF NOT EXISTS Ficha (
          id INTEGER primary key autoincrement,
          id_funcionario INTEGER NOT NULL,
          id_projeto INTEGER NOT NULL,
          date_modification datetime,
          date_create datetime,
          foreign key (id_funcionario) references Funcionario (id) ON DELETE CASCADE,
          foreign key (id_projeto) references Projeto (id) ON DELETE CASCADE
        );''',
      '''CREATE TABLE IF NOT EXISTS ItemFicha (
          id INTEGER primary key autoincrement,
          assinatura MEDIUMBLOB,
          quantidade INT NOT NULL,
          id_epi INTEGER NOT NULL,
          id_ficha INTEGER NOT NULL,
          entrega DATE,
          devolucao DATETIME,
          date_modification datetime,
          date_create datetime,
          foreign key (id_epi) references EPI (id) ON DELETE CASCADE,
          foreign key (id_ficha) references Ficha (id) ON DELETE CASCADE
        );''',
      /* '''insert into Cargo (descricao,date_create)
          VALUES('Programador',strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Filial (descricao,pseudonimo,cnpj,date_create)
          VALUES('Alfa','Engenharia','10987654321',strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Funcionario (nome,cpf,matricula,pin,id_cargo,id_filial,date_create)''' +
          '''VALUES('Gabriel','1','01',1234,1,1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Funcionario (nome,cpf,matricula,pin,id_cargo,id_filial,date_create)''' +
          '''VALUES('Henrique','2','02',4321,1,1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Usuario (senha,id_funcionario,id_projeto,date_create)''' +
          '''VALUES('8cb2237d0679ca88db6464eac60da96345513964',1,1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Projeto (codigoAP,descricao,endereco,id_filial,date_create)
          VALUES('AP-20-001','projeto 1','endereço x',1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Ficha (id_funcionario,id_projeto,date_create)
          VALUES(1,1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into Ficha (id_funcionario,id_projeto,date_create)
          VALUES(1,1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into EPI (descricao,ca,validade,date_create)
         VALUES('bota','123',DATE('now'),strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',*/
    ];

    for (var i = 0; i < sql.length; i++) {
      print("execute sql : " + sql[i]);
      await db.execute(sql[i]).catchError((onError) => print(onError));
    }
  }
}
