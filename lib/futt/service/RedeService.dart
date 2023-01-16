import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/rest/RedeRest.dart';

class RedeService {

  inclui(var redeModel) {
    String url = "${ConstantesRest.URL_REDE}/adiciona";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPost(url, redeModel);
  }

  atualizaPatrocinador(var redePatrocinadorModel) {
    String url = "${ConstantesRest.URL_REDE}/adicionapatrocinador";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPut(url, redePatrocinadorModel);
  }

  atualizaIntegrante(var integranteModel) {
    String url = "${ConstantesRest.URL_REDE}/adicionaintegrante";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPut(url, integranteModel);
  }

  atualiza(var redeModel) {
    String url = "${ConstantesRest.URL_REDE}/atualiza";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPut(url, redeModel);
  }

  alteraStatus(String idRede, String status) {
    String url = "${ConstantesRest.URL_REDE}/${idRede}/alterastatus/${status}";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPut(url, null);
  }

  desativaRede(String idRede) {
    String url = "${ConstantesRest.URL_REDE}/${idRede}/desativa";
    RedeRest redeRest = RedeRest();
    redeRest.processaHttpPut(url, null);
  }

  Future<List<RedeModel>> listaRedesQueParticipo() {
    String url = "${ConstantesRest.URL_REDE}/participacao";
    RedeRest redeRest = RedeRest();
    return redeRest.processaHttpGetListToken(url, "1");
  }

  Future<List<RedeModel>> listaMinhasRedes() {
    String url = "${ConstantesRest.URL_REDE}/minhasredes";
    RedeRest redeRest = RedeRest();
    return redeRest.processaHttpGetListToken(url, "2");
  }

  Future<List<IntegranteModel>> listaIntegrantesDaRede(String idRede) {
    String url = "${ConstantesRest.URL_REDE}/integrantes/${idRede}";
    RedeRest redeRest = RedeRest();
    return redeRest.processaHttpGetListIntegrantes(url);
  }

  Future<RedeModel> buscaRedePorId(int idRede) {
    String url = "${ConstantesRest.URL_REDE}/${idRede}";
    RedeRest redeRest = RedeRest();
    return redeRest.processaHttpGetObject(url);
  }

}