import 'package:futt/futt/model/AvaliacaoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/AvaliacaoServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AvaliacaoRest extends BaseRest {

  Future<List<AvaliacaoModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaAvaliacaoModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }

    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        AvaliacaoServiceFixo serviceFixo = AvaliacaoServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaAvaliacaoModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
      if (fixo != null && fixo == true) {
        AvaliacaoServiceFixo serviceFixo = AvaliacaoServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaAvaliacaoModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }
    }
  }

  List<AvaliacaoModel> _parseListaAvaliacaoModel(dadosJson) {
    List<AvaliacaoModel> lista = List();
    for (var registro in dadosJson) {
      AvaliacaoModel resultadoModel = AvaliacaoModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

}