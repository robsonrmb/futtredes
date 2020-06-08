import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const URL_BASE_REST = "http://localhost:8080/login";

class LoginServiceFixo {

  logar(var loginModel) async {

    http.Response response = await http.post(
      ConstantesRest.URL_LOGIN,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonDecode(loginModel)
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

}