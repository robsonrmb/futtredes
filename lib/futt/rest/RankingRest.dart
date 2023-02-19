import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankingRest extends BaseRest {

  Future<List<RankingModel>> processaHttpGetList(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaRankingModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar resultados!!!');

    } catch (error) {
      print(error.toString());
      throw Exception('Falha ao listar resultados!!!');
    }
  }

  List<RankingModel> _parseListaRankingModel(dadosJson) {
    List<RankingModel> lista = [];
    for (var registro in dadosJson) {
      RankingModel resultadoModel = RankingModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}