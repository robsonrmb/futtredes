import 'dart:convert';
import 'package:futt/futt/model/JogoRedeModel.dart';

class JogoRedeServiceFixo {

  String retornoJogo = '{'
        '"id": 1, '
        '"numero": 1, '
        '"pontuacao1": 18, '
        '"pontuacao2": 12, '
        '"data": null, '
        '"idRede": 4, '
        '"idJogador1": 1, '
        '"idJogador2": 2, '
        '"idJogador3": 3, '
        '"idJogador4": 4, '
        '"idJogador5": 0, '
        '"idJogador6": 0, '
        '"idJogador7": 0, '
        '"idJogador8": 0, '
        '"idJogador9": 0, '
        '"idJogador10": 0 '
      '}';

  String retornoJogos = '[ '
        '{'
          '"id": 1, '
          '"numero": 1, '
          '"pontuacao1": 18, '
          '"pontuacao2": 12, '
          '"data": null, '
          '"idRede": 4, '
          '"idJogador1": 1, '
          '"idJogador2": 2, '
          '"idJogador3": 3, '
          '"idJogador4": 4, '
          '"idJogador5": 0, '
          '"idJogador6": 0, '
          '"idJogador7": 0, '
          '"idJogador8": 0, '
          '"idJogador9": 0, '
          '"idJogador10": 0 '
        '} '
      ']';

  String responseLista() {
    return retornoJogos;
  }

  String responseObjeto() {
    return retornoJogo;
  }

  Future<JogoRedeModel> _buscaJogoFixo() async {
    var dadosJson = json.decode(retornoJogo);
    return JogoRedeModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<JogoRedeModel>> _listaJogosFixo() async {
    var dadosJson = json.decode(retornoJogos);
    List<JogoRedeModel> lista = List();
    for (var registro in dadosJson) {
      JogoRedeModel jogoRedeModel = JogoRedeModel.fromJson(registro); //.converteJson
      lista.add(jogoRedeModel);
    }
    return lista;
  }

  Future<List<JogoRedeModel>> listaPorRede(String idRede) async {
    return _listaJogosFixo();
  }
}