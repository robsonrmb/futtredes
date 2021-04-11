import 'package:futt/futt/constantes/ConstantesEstatisticas.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/QuantidadeModel.dart';
import 'package:futt/futt/model/RespQuantidadeModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/rest/EstatisticaRest.dart';

class EstatisticaService {

  Future<List<RespQuantidadeModel>> vitoriasDerrotas(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/vitoriasederrotas/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> tiebreaks(String idUsuario, String ano, String idTorneio, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/tiebreaksvencidoseperdidos/usuario/${idUsuario}?ano=${ano}&&id=${idTorneio}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> pontos(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/pontos/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> jogos(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/jogos/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<QuantidadeModel>> quantitativa(String idUsuario, String tipoestatistica, String ano, String id, String tipo, bool fixo) async {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/qtd/usuario/${idUsuario}/${tipoestatistica}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListQuantidade(url, 0, fixo);
  }

  /* CONSULTAS NOVAS PARA FLUTTER */
  Future<List<RespostaModel>> getQuantitativas(int idUsuario, int idRede, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/quantitativas/${idUsuario}?tipo='R'";
    // if (ano != 0) {
    //   url = "${url}&&ano=${ano}";
    // }
    // if (idRede != 0) {
    //   url = "${url}&&id=${idRede}";
    // }
    url = "$url&&ano=$ano&&id=$idRede";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.QUANTITATIVOS, fixo); //quantitativas
  }

  Future<List<RespostaModel>> getJogosEPontos(int idUsuario, int idRede, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/jogosepontos/${idUsuario}?tipo='R'";
    if (ano != 0) { url = "${url}&&ano=${ano}"; }
    if (idRede != 0) { url = "${url}&&id=${idRede}"; }
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.JOGOSEPONTOS, fixo); //jogos e pontos
  }

  Future<List<RespostaModel>> getSequenciais(int idUsuario, int idRede, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/sequenciais/${idUsuario}?tipo='R'";
    if (idRede != 0) { url = "${url}&&idRede=${idRede}"; }
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.SEQUENCIAIS, fixo); //sequenciais
  }

}