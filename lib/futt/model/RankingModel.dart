class RankingModel {
  int _id;
  int _ano;
  int _pontuacao;
  int _idUsuario;
  String _nomeUsuario;
  String _apelidoUsuario;
  String _fotoUsuario;

  RankingModel(this._id, this._ano, this._pontuacao, this._idUsuario,
      this._nomeUsuario, this._apelidoUsuario, this._fotoUsuario);

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      json["id"],
      json["ano"],
      json["pontuacao"],
      json["idUsuario"],
      json["nomeUsuario"],
      json["apelidoUsuario"],
      json["fotoUsuario"],
    );
  }

  String get fotoUsuario => _fotoUsuario;

  set fotoUsuario(String value) {
    _fotoUsuario = value;
  }

  String get apelidoUsuario => _apelidoUsuario;

  set apelidoUsuario(String value) {
    _apelidoUsuario = value;
  }

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int value) {
    _idUsuario = value;
  }

  int get pontuacao => _pontuacao;

  set pontuacao(int value) {
    _pontuacao = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}