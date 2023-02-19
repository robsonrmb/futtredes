import 'package:futt/futt/model/PatrocinadorModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatrocinadorRest extends BaseRest {

  Future<List<PatrocinadorModel>> processaHttpGetList(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      List<PatrocinadorModel> lista = [];
      for (var registro in dadosJson) {
        PatrocinadorModel patrocinadorModel = PatrocinadorModel.fromJson(
            registro); //.converteJson
        lista.add(patrocinadorModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }
}