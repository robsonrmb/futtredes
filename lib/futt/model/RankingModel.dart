class RankingModel {
  int? _id;
  int? _ano;
  int? _pontuacao;
  int? _pontuacao2;
  int? _pontuacao3;
  int? _idUsuario;
  String? _nomeUsuario;
  String? _apelidoUsuario;
  String? _fotoUsuario;
  String? _mediaFormatada;

  RankingModel(this._id, this._ano, this._pontuacao, this._pontuacao2, this._pontuacao3, this._mediaFormatada,
      this._idUsuario, this._nomeUsuario, this._apelidoUsuario, this._fotoUsuario);

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      json["id"],
      json["ano"],
      json["pontuacao"],
      json["pontuacao2"],
      json["pontuacao3"],
      json["mediaFormatada"],
      json["idUsuario"],
      json["nomeUsuario"],
      json["apelidoUsuario"],
      json["fotoUsuario"],
    );
  }

  String? getApelidoFormatado() {
    if (apelidoUsuario == null) {
      return nomeUsuario;
    }else{
      return apelidoUsuario;
    }
  }

  String? getNomeFormatado() {
    if (apelidoUsuario == null) {
      return "";
    }else{
      return nomeUsuario;
    }
  }

  String? get fotoUsuario => _fotoUsuario;

  set fotoUsuario(String? value) {
    _fotoUsuario = value;
  }

  String? get apelidoUsuario => _apelidoUsuario;

  set apelidoUsuario(String? value) {
    _apelidoUsuario = value;
  }

  String? get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String? value) {
    _nomeUsuario = value;
  }

  int? get idUsuario => _idUsuario;

  set idUsuario(int? value) {
    _idUsuario = value;
  }

  int? get pontuacao => _pontuacao;

  set pontuacao(int? value) {
    _pontuacao = value;
  }

  int? get ano => _ano;

  set ano(int? value) {
    _ano = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  int? get pontuacao2 => _pontuacao2;

  set pontuacao2(int? value) {
    _pontuacao2 = value;
  }

  String? get mediaFormatada => _mediaFormatada;

  set mediaFormatada(String? value) {
    _mediaFormatada = value;
  }

  int? get pontuacao3 => _pontuacao3;

  set pontuacao3(int? value) {
    _pontuacao3 = value;
  }

}