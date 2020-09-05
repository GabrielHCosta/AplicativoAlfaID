import 'package:controle_epi_flutter/app/shared/modules/webservice/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  login(String cpf, String password) {
    var dio = CustomDio().instance;

    dio.post('/login', data: {'cpf': cpf, 'password': password}).then(
        (res) async {
      print('res: $res');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res.data['token']);
    }).catchError((err) {
      throw Exception('cpf ou senha inválidos');
    });
  }
}
