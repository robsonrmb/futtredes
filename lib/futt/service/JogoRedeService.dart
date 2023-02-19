import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/JogoRedeRest.dart';

class JogoRedeService {

  inclui(var JogoRedeModel) {
    String url = "${ConstantesRest.URL_JOGO_REDE}/adiciona";
    JogoRedeRest jogoRest = JogoRedeRest();
    jogoRest.processaHttpPost(url, JogoRedeModel);
  }

  atualiza(var JogoRedeModel) {
    String url = "${ConstantesRest.URL_JOGO_REDE}/atualiza";
    JogoRedeRest jogoRest = JogoRedeRest();
    jogoRest.processaHttpPut(url, JogoRedeModel);
  }

  atualizaPlacar(var JogoRedeModel) {
    String url = "${ConstantesRest.URL_JOGO_REDE}/atualizaplacar";
    JogoRedeRest jogoRest = JogoRedeRest();
    jogoRest.processaHttpPut(url, JogoRedeModel);
  }

  remove(String idJogo) {
    String url = "${ConstantesRest.URL_JOGO_REDE}/remove/${idJogo}";
    JogoRedeRest jogoRest = JogoRedeRest();
    jogoRest.processaHttpDelete(url);
  }

  Future<List<JogoRedeModel>?> listaPorRede(int? idRede) async {
    String url = "${ConstantesRest.URL_JOGO_REDE}/rede/${idRede}";
    JogoRedeRest jogoRest = JogoRedeRest();
    return jogoRest.processaHttpGetList(url);
  }

  Future<List<JogoRedeModel>?> listaPorRedeUsuario(int? idRede) async {
    String url = "${ConstantesRest.URL_JOGO_REDE}/usuario/0/${idRede}";
    JogoRedeRest jogoRest = JogoRedeRest();
    return jogoRest.processaHttpGetListToken(url);
  }

}