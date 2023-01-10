import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/BannerModel.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/UsuarioAssinanteModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/rest/BannerRest.dart';
import 'package:futt/futt/rest/UsuarioRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class BannerService {
  Future<BannerModel> buscaPermissaoBanners() {
    String url = "${ConstantesRest.URL_BANNERS}";
    BannerRest bannerRest = BannerRest();
    return bannerRest.processaHttpGetObject(url);
  }
}