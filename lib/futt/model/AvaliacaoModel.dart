class AvaliacaoModel {
  int _id;
  int _idUsuario;
  int _idAvaliado;
  String _data;
  String _status;

  String _respostaPe;
  String _respostaLevantada;
  String _respostaRecepcao;
  String _respostaAtaque;
  String _respostaDefesa;
  String _respostaShark;
  String _respostaFintaPescoco;
  String _respostaFintaOmbro;
  String _respostaConstante;
  String _respostaVariacao;
  String _respostaInteligente;
  String _respostaTatico;
  String _respostaCompetitivo;
  String _respostaPreparo;

  String _nomeUsuario;
  String _nomeAvaliado;
  String _fotoUsuario;
  String _fotoAvaliado;

  AvaliacaoModel(this._id, this._idUsuario, this._idAvaliado, this._data,
      this._status, this._respostaPe, this._respostaLevantada,
      this._respostaRecepcao, this._respostaAtaque, this._respostaDefesa,
      this._respostaShark, this._respostaFintaPescoco, this._respostaFintaOmbro,
      this._respostaConstante, this._respostaVariacao, this._respostaInteligente,
      this._respostaTatico, this._respostaCompetitivo, this._respostaPreparo,
      this._nomeUsuario, this._nomeAvaliado, this._fotoUsuario, this._fotoAvaliado);

  AvaliacaoModel.RespostaStr(this._id, this._respostaRecepcao, this._respostaLevantada,
      this._respostaAtaque, this._respostaDefesa, this._respostaShark,
      this._respostaFintaPescoco, this._respostaFintaOmbro, this._respostaPe,
      this._respostaConstante, this._respostaVariacao, this._respostaInteligente,
      this._respostaTatico, this._respostaCompetitivo, this._respostaPreparo);

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AvaliacaoModel(
      json["id"],
      json["idUsuario"],
      json["idAvaliado"],
      json["data"],
      json["status"],
      json["respostaPe"],
      json["respostaLevantada"],
      json["respostaRecepcao"],
      json["respostaAtaque"],
      json["respostaDefesa"],
      json["respostaShark"],
      json["respostaFintaPescoco"],
      json["respostaFintaOmbro"],
      json["respostaConstante"],
      json["respostaVariacao"],
      json["respostaInteligente"],
      json["respostaTatico"],
      json["respostaCompetitivo"],
      json["respostaPreparo"],
      json["nomeUsuario"],
      json["nomeAvaliado"],
      json["fotoUsuario"],
      json["fotoAvaliado"],
    );
  }

  String getStringRespostaStr() {
    return "";
  }

  String get nomeAvaliado => _nomeAvaliado;

  set nomeAvaliado(String value) {
    _nomeAvaliado = value;
  }

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  String get respostaPreparo => _respostaPreparo;

  set respostaPreparo(String value) {
    _respostaPreparo = value;
  }

  String get respostaCompetitivo => _respostaCompetitivo;

  set respostaCompetitivo(String value) {
    _respostaCompetitivo = value;
  }

  String get respostaTatico => _respostaTatico;

  set respostaTatico(String value) {
    _respostaTatico = value;
  }

  String get respostaInteligente => _respostaInteligente;

  set respostaInteligente(String value) {
    _respostaInteligente = value;
  }

  String get respostaVariacao => _respostaVariacao;

  set respostaVariacao(String value) {
    _respostaVariacao = value;
  }

  String get respostaConstante => _respostaConstante;

  set respostaConstante(String value) {
    _respostaConstante = value;
  }

  String get respostaFintaOmbro => _respostaFintaOmbro;

  set respostaFintaOmbro(String value) {
    _respostaFintaOmbro = value;
  }

  String get respostaFintaPescoco => _respostaFintaPescoco;

  set respostaFintaPescoco(String value) {
    _respostaFintaPescoco = value;
  }

  String get respostaShark => _respostaShark;

  set respostaShark(String value) {
    _respostaShark = value;
  }

  String get respostaDefesa => _respostaDefesa;

  set respostaDefesa(String value) {
    _respostaDefesa = value;
  }

  String get respostaAtaque => _respostaAtaque;

  set respostaAtaque(String value) {
    _respostaAtaque = value;
  }

  String get respostaRecepcao => _respostaRecepcao;

  set respostaRecepcao(String value) {
    _respostaRecepcao = value;
  }

  String get respostaLevantada => _respostaLevantada;

  set respostaLevantada(String value) {
    _respostaLevantada = value;
  }

  String get respostaPe => _respostaPe;

  set respostaPe(String value) {
    _respostaPe = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  int get idAvaliado => _idAvaliado;

  set idAvaliado(int value) {
    _idAvaliado = value;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int value) {
    _idUsuario = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get fotoAvaliado => _fotoAvaliado;

  set fotoAvaliado(String value) {
    _fotoAvaliado = value;
  }

  String get fotoUsuario => _fotoUsuario;

  set fotoUsuario(String value) {
    _fotoUsuario = value;
  }

}