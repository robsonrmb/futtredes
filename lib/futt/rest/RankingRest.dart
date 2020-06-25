import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/RankingServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankingRest extends BaseRest {

  Future<List<RankingModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaRankingModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        RankingServiceFixo serviceFixo = RankingServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista(true));
        return _parseListaRankingModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
      if (fixo != null && fixo == true) {
        RankingServiceFixo serviceFixo = RankingServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista(true));
        return _parseListaRankingModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }
    }
  }

  List<RankingModel> _parseListaRankingModel(dadosJson) {
    List<RankingModel> lista = List();
    for (var registro in dadosJson) {
      RankingModel resultadoModel = RankingModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}