import 'package:futt/futt/model/ResultadoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/ResultadoServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadoRest extends BaseRest {

  Future<List<ResultadoModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaResultadoModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        ResultadoServiceFixo serviceFixo = ResultadoServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaResultadoModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<ResultadoModel> _parseListaResultadoModel(dadosJson) {
    List<ResultadoModel> lista = List();
    for (var registro in dadosJson) {
      ResultadoModel resultadoModel = ResultadoModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}