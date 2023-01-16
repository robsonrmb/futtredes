import 'package:futt/futt/model/EscolinhaModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EscolinhaRest extends BaseRest {

  Future<List<EscolinhaModel
  >> processaHttpGetList(String url, bool filtro) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaEscolinhaModel(dadosJson);

      } else {
        throw Exception('Failed to load Escolinha!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar resultados!!!');

    } catch (error) {
      print(error.toString());
      throw Exception('Falha ao listar resultados!!!');
    }
  }

  List<EscolinhaModel> _parseListaEscolinhaModel(dadosJson) {
    List<EscolinhaModel> lista = List();
    for (var registro in dadosJson) {
      EscolinhaModel resultadoModel = EscolinhaModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}