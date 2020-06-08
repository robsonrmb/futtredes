import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ParticipanteModel.dart';
import 'package:futt/futt/rest/ParticipanteRest.dart';

class ParticipanteService {

  Future<List<ParticipanteModel>> listaParticipantesDoTorneio(int idTorneio, bool fixo) {
    String url = "${ConstantesRest.URL_PARTICIPANTES}/${idTorneio}";
    ParticipanteRest participanteRest = ParticipanteRest();
    return participanteRest.processaHttpGetList(url, fixo);
  }

}