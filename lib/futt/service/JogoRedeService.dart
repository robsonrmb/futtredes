import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/JogoRedeRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class JogoRedeService {

  inclui(var jogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/adiciona";
      JogoRedeRest jogoRedeRest = JogoRedeRest();
      jogoRedeRest.processaHttpPost(url, jogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualiza(var jogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/atualiza";
      JogoRedeRest jogoRedeRest = JogoRedeRest();
      jogoRedeRest.processaHttpPut(url, jogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualizaPlacar(var jogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/atualizaplacar";
      JogoRedeRest jogoRedeRest = JogoRedeRest();
      jogoRedeRest.processaHttpPut(url, jogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  remove(String idJogo, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO_REDE}/remove/${idJogo}";
      JogoRedeRest jogoRedeRest = JogoRedeRest();
      jogoRedeRest.processaHttpDelete(url);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<JogoRedeModel>> listaPorRede(String idRede, {bool fixo}) {
    String url = "${ConstantesRest.URL_JOGO_REDE}/rede/${idRede}";
    JogoRedeRest jogoRedeRest = JogoRedeRest();
    return jogoRedeRest.processaHttpGetList(url, fixo);
  }
}