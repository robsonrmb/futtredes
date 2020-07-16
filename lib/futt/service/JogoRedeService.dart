import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/JogoRedeRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class JogoRedeService {

  inclui(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/adiciona";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPost(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualiza(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/atualiza";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPut(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualizaPlacar(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/atualizaplacar";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPut(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  remove(String idJogo, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/remove/${idJogo}";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpDelete(url);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<JogoRedeModel>> listaPorRede(int idRede, bool fixo) async {
    String url = "${ConstantesRest.URL_JOGO_REDE}/rede/${idRede}";
    JogoRedeRest jogoRest = JogoRedeRest();
    return jogoRest.processaHttpGetList(url, fixo);
  }

  Future<List<JogoRedeModel>> listaPorRedeUsuario(int idRede, bool fixo) async {
    String url = "${ConstantesRest.URL_JOGO_REDE}/usuario/0/${idRede}";
    JogoRedeRest jogoRest = JogoRedeRest();
    return jogoRest.processaHttpGetListToken(url, fixo);
  }

}