class ParticipanteModel {

  int _idUsuario;
  String _nome;
  String _nomeFoto;
  String _pais;
  String _cidade;
  String _email;

  ParticipanteModel(this._idUsuario, this._nome, this._nomeFoto, this._pais, this._cidade);

  ParticipanteModel.Novo(this._idUsuario, this._email);

  factory ParticipanteModel.fromJson(Map<String, dynamic> json) {
    return ParticipanteModel(
      json["idUsuario"],
      json["nome"],
      json["nomeFoto"],
      json["pais"],
      json["cidade"],
    );
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
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

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}