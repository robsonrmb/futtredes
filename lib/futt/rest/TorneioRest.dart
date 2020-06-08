import 'package:futt/futt/model/ParticipanteModel.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/TorneioServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TorneioRest extends BaseRest {

  Future<List<TorneioModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar torneios!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<TorneioModel> _parseListaTorneioModel(dadosJson) {
    List<TorneioModel> lista = List();
    for (var registro in dadosJson) {
      TorneioModel resultadoModel = TorneioModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  Future<List<TorneioModel>> processaHttpPostReturn(String url, var torneioModel, bool fixo) async {
    print("chegou...");
    try {
      http.Response response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            jsonDecode(torneioModel)
          }
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseFiltro());
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar torneios!!!');
      }

    } catch (error) {
      print(error.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseFiltro());
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar torneios!!!');
      }
    }
  }

  Future<List<TorneioModel>> processaHttpPostReturnSemParam(String url, bool fixo) async {
    try {
      http.Response response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseMeusTorneios());
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar torneios!!!');
      }

    } catch (error) {
      print(error.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseMeusTorneios());
        return _parseListaTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar torneios!!!');
      }
    }
  }

  Future<TorneioModel> processaHttpGetObject(String url, bool fixo) async {
    try {
      http.Response response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return TorneioModel.fromJson(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseObjeto());
        return TorneioModel.fromJson(dadosJson);

      } else {
        throw Exception('Falha ao buscar torneio!!!');
      }

    } catch (error) {
      print(error.toString());
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseObjeto());
        return TorneioModel.fromJson(dadosJson);

      } else {
        throw Exception('Falha ao buscar torneio!!!');
      }
    }
  }

  Future<List<ParticipanteModel>> processaHttpGetListParticipante(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        TorneioServiceFixo serviceFixo = TorneioServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<ParticipanteModel> lista = List();
      for (var registro in dadosJson) {
        ParticipanteModel participanteModel = ParticipanteModel.fromJson(
            registro); //.converteJson
        lista.add(participanteModel);
      }
      return lista;
    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }
}