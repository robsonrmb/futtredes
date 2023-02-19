import 'package:futt/futt/model/AreaEstatisticaModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AreaEstatisticaRest extends BaseRest {

  Future<List<AreaEstatisticaModel>> processaHttpGetList(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      List<AreaEstatisticaModel> lista = [];
      for (var registro in dadosJson) {
        AreaEstatisticaModel areaEstatisticaModel = AreaEstatisticaModel
            .fromJson(
            registro); //.converteJson
        lista.add(areaEstatisticaModel);
      }
      return lista;
    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }

}