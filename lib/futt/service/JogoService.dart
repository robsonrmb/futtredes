import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoModel.dart';
import 'package:futt/futt/rest/JogoRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class JogoService {

  inclui(var jogoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/adiciona";
      JogoRest jogoRest = JogoRest();
      jogoRest.processaHttpPost(url, jogoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualiza(var jogoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/atualiza";
      JogoRest jogoRest = JogoRest();
      jogoRest.processaHttpPut(url, jogoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualizaPlacar(var jogoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/atualizaplacar";
      JogoRest jogoRest = JogoRest();
      jogoRest.processaHttpPut(url, jogoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  informaVencedor(var vencedorModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/informavencedor";
      JogoRest jogoRest = JogoRest();
      jogoRest.processaHttpPut(url, vencedorModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  remove(String idJogo, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_JOGO}/remove/${idJogo}";
      JogoRest jogoRest = JogoRest();
      jogoRest.processaHttpDelete(url);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<JogoModel>> listaPorUsuario({bool fixo}) {
    String url = "${ConstantesRest.URL_JOGO}/ativasdousuariologado";
    JogoRest jogoRest = JogoRest();
    return jogoRest.processaHttpGetList(url, 0, fixo);
  }

  Future<List<JogoModel>> listaPorTorneios(int idTorneio, int idFase, bool atualizouPlacar, bool fixo) async {
    String url = "${ConstantesRest.URL_JOGO}/torneios/${idTorneio}/${idFase}";
    JogoRest jogoRest = JogoRest();
    if (!atualizouPlacar) {
      return jogoRest.processaHttpGetList(url, idFase, fixo);
    }else{
      return jogoRest.processaHttpGetListPlacarAtualizado(
          url, idFase, atualizouPlacar, fixo);
    }
  }

}