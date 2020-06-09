class IntegranteModel {
  int _idUsuario;
  String _nome;
  String _nomeFoto;
  String _pais;
  String _estado;

  IntegranteModel(this._idUsuario, this._nome, this._nomeFoto, this._pais, this._estado);

  factory IntegranteModel.fromJson(Map<String, dynamic> json) {
    return IntegranteModel(
      json["idUsuario"],
      json["nome"],
      json["nomeFoto"],
      json["pais"],
      json["estado"],
    );
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get nomeFoto => _nomeFoto;

  set nomeFoto(String value) {
    _nomeFoto = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int value) {
    _idUsuario = value;
  }

}