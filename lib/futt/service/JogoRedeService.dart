import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/JogoRedeRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class JogoRedeService {

  inclui(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/adiciona";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPost(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualiza(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/atualiza";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPut(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualizaPlacar(var JogoRedeModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/atualizaplacar";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpPut(url, JogoRedeModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  remove(String idJogo, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/remove/${idJogo}";
      JogoRedeRest jogoRest = JogoRedeRest();
      jogoRest.processaHttpDelete(url);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<JogoRedeModel>> listaPorRedes(int idRede, int dia, bool atualizouPlacar, bool fixo) async {
    String url = "${ConstantesRest.URL_JOGO_REDE}/redes/${idRede}";
    JogoRedeRest jogoRest = JogoRedeRest();
    if (!atualizouPlacar) {
      return jogoRest.processaHttpGetList(url, dia, fixo);
    }else{
      return jogoRest.processaHttpGetListPlacarAtualizado(url, dia, atualizouPlacar, fixo);
    }
  }

}