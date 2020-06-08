import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/rest/TorneioRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class TorneioService {

  inclui(var torneioModel, bool fixo) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/adiciona";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPost(url, torneioModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  adicionaPatrocinador(var torneioPatrocinadorModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/adicionapatrocinador";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPost(url, torneioPatrocinadorModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  adicionaParticipante(var participanteModel, bool fixo) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/adicionaparticipante";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPost(url, participanteModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  atualiza(var torneioModel, bool fixo) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/atualiza";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, torneioModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  informaCampeoes(var torneioModel, {bool fixo}) {

    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/informacampeoes";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, torneioModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  alteraStatus(String idTorneio, String status, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/alterastatus";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, null);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  desativaTorneio(String idTorneio, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/desativa";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, null);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  finalizaTorneio(String idTorneio, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/finaliza";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, null);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  resetTorneio(String idTorneio, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/reset";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, null);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  gravaRankingTorneio(String idTorneio, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/gravaranking";
      TorneioRest torneioRest = TorneioRest();
      torneioRest.processaHttpPut(url, null);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<TorneioModel>> listaPorFiltros(var torneioModel, bool fixo) {
    String url = "${ConstantesRest.URL_TORNEIOS}/filtros";
    TorneioRest torneioRest = TorneioRest();
    return torneioRest.processaHttpPostReturn(url, torneioModel, fixo);
  }

  Future<List<TorneioModel>> listaPorStatus(var status, bool fixo) {
    String url = "${ConstantesRest.URL_TORNEIOS}/status?status=${status}";
    TorneioRest torneioRest = TorneioRest();
    return torneioRest.processaHttpGetList(url, fixo);
  }

  Future<List<TorneioModel>> listaTodos(bool fixo) {
    String url = "${ConstantesRest.URL_TORNEIOS}";
    TorneioRest torneioRest = TorneioRest();
    return torneioRest.processaHttpGetList(url, fixo);
  }

  Future<List<TorneioModel>> listaMeusTorneios(bool fixo) {
    String url = "${ConstantesRest.URL_MEUSTORNEIOS}";
    TorneioRest torneioRest = TorneioRest();
    return torneioRest.processaHttpPostReturnSemParam(url, fixo);
  }

  Future<TorneioModel> getTorneio(int idTorneio, bool fixo) {
    String url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}";
    TorneioRest torneioRest = TorneioRest();
    return torneioRest.processaHttpGetObject(url, fixo);
  }

}