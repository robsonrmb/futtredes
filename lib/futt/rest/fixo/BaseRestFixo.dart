import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseRestFixo {

  var envio = json.encode(
      {
        "userId": 200,
        "id": null,
        "title": "Título",
        "body": "Corpo da mensagem"
      }
  );

  processaHttpPostFixo() async {
    http.Response response = await http.post(
        Uri.parse("${ConstantesRest.URL_BASE_TESTE}/posts")
        ,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: envio
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

  processaHttpPutFixo() async {
    http.Response response = await http.put(
      Uri.parse("${ConstantesRest.URL_BASE_TESTE}/posts/1"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: envio
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

  processaHttpDeleteFixo() async {
    http.Response response = await http.delete(
      Uri.parse("${ConstantesRest.URL_BASE_TESTE}/posts/1"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

}