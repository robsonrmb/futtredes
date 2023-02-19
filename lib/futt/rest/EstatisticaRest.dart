import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/QuantidadeModel.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespQuantidadeModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstatisticaRest extends BaseRest {

  Future<List<RespQuantidadeModel>?> processaHttpGetListRespQuantidade(String url, int tipo) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaRespQuantidadeModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar resultados!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<RespPerformanceModel>?> processaHttpGetListRespPerformance(String url, int tipo) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaRespPerformanceModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar resultados!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<QuantidadeModel>?> processaHttpGetListQuantidade(String url, int tipo) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaQuantidadeModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar resultados!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<RespostaModel>?> processaHttpGetListResposta(String url, int tipo) async {
    try {
      //http.Response response = await http.get(url);
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.get(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaRespostaModel(dadosJson);

      } else {
        throw Exception('Falha ao buscar estatísticas!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao buscar estatísticas!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  List<RespQuantidadeModel> _parseListaRespQuantidadeModel(dadosJson) {
    List<RespQuantidadeModel> lista = [];
    for (var registro in dadosJson) {
      RespQuantidadeModel resultadoModel = RespQuantidadeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  List<RespPerformanceModel> _parseListaRespPerformanceModel(dadosJson) {
    List<RespPerformanceModel> lista = [];
    for (var registro in dadosJson) {
      RespPerformanceModel resultadoModel = RespPerformanceModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  List<QuantidadeModel> _parseListaQuantidadeModel(dadosJson) {
    List<QuantidadeModel> lista = [];
    for (var registro in dadosJson) {
      QuantidadeModel resultadoModel = QuantidadeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  List<RespostaModel> _parseListaRespostaModel(dadosJson) {
    List<RespostaModel> lista = [];
    for (var registro in dadosJson) {
      RespostaModel resultadoModel = RespostaModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}