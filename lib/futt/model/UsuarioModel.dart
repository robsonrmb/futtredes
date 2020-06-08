class UsuarioModel {
  int _id;
  String _nome;
  String _email;
  String _senha;
  String _apelido;
  DateTime _dataNascimento;
  String _ondeJoga;
  String _tipo;
  String _nivel;
  String _cidade;
  String _estado;
  String _pais;
  String _status;
  String _sexo;
  String _professor;
  String _nomeFoto;

  UsuarioModel.Novo(this._id);

  UsuarioModel(this._id, this._nome, this._email, this._senha, this._apelido,
      this._dataNascimento, this._ondeJoga, this._tipo, this._nivel, this._cidade,
      this._estado, this._pais, this._status, this._sexo, this._professor,
      this._nomeFoto);

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      json["id"],
      json["nome"],
      json["email"],
      json["senha"],
      json["apelido"],
      json["dataNascimento"],
      json["ondeJoga"],
      json["tipo"],
      json["nivel"],
      json["cidade"],
      json["estado"],
      json["pais"],
      json["status"],
      json["sexo"],
      json["professor"],
      json["nomeFoto"],
    );
  }

  String get nomeFoto => _nomeFoto;

  set nomeFoto(String value) {
    _nomeFoto = value;
  }

  String get professor => _professor;

  set professor(String value) {
    _professor = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get nivel => _nivel;

  set nivel(String value) {
    _nivel = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get ondeJoga => _ondeJoga;

  set ondeJoga(String value) {
    _ondeJoga = value;
  }

  DateTime get dataNascimento => _dataNascimento;

  set dataNascimento(DateTime value) {
    _dataNascimento = value;
  }

  String get apelido => _apelido;

  set apelido(String value) {
    _apelido = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}