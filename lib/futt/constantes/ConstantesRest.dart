class ConstantesRest {

  static const URL_BASE_LOCAL = "http://localhost:8080";
  static const URL_BASE_TESTE = "https://jsonplaceholder.typicode.com";
  static const URL_BASE_HEROKU_ = "https://futtapp.herokuapp.com";
  static const URL_BASE_AMAZON_ = "https://futtapp.s3-sa-east-1.amazonaws.com/";
  static const URL_BASE_CBRASIL = "https://kmaops.hospedagemelastica.com.br";

  static const URL_BASE = URL_BASE_CBRASIL;
  static const URL_CONTEXT = "${URL_BASE}/futback";
  static const URL_STATIC_USER = "${URL_BASE}/imagens/usuarios";
  static const URL_STATIC_REDES = "${URL_BASE}/imagens/redes";

  static const URL_LOGIN = "${URL_CONTEXT}/login";
  static const URL_NOVA_SENHA = "${URL_CONTEXT}/auth/nova_senha";
  static const URL_REFRESH_TOKEN = "${URL_CONTEXT}/auth/refresh_token";

  static const URL_AMIGO = "${URL_CONTEXT}/amigos";
  static const URL_AREA_ESTATISTICA = "${URL_CONTEXT}/areaestatisticas";
  static const URL_ESCOLINHA = "${URL_CONTEXT}/escolinhas";
  static const URL_ESTATISTICAS = "${URL_CONTEXT}/estatisticas";
  static const URL_JOGO_REDE = "${URL_CONTEXT}/jogosredes";
  static const URL_PATROCINADOR = "${URL_CONTEXT}/patrocinadores";
  static const URL_PARTICIPANTES = "${URL_CONTEXT}/redes/integrantes";
  static const URL_RANKING = "${URL_CONTEXT}/ranking";
  static const URL_REDE = "${URL_CONTEXT}/redes";
  static const URL_TIPO_AVALIACOES = "${URL_CONTEXT}/tipoavaliacoes";
  static const URL_USUARIOS = "${URL_CONTEXT}/usuarios";
  static const URL_PAISES = "${URL_CONTEXT}/utils/paises";
  static const URL_ESTADOS = "${URL_CONTEXT}/utils/estados";

}
