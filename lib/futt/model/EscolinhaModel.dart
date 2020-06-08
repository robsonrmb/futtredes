class EscolinhaModel {
  int _id;
  String _nome;
  String _telefone;
  String _cidade;
  String _estado;
  String _pais;
  String _endereco;
  String _descricao;
  String _nomeResponsavel;
  String _nomeProfessor1;
  String _nomeProfessor2;
  String _nomeProfessor3;
  String _fotoResponsavel;
  String _fotoProfessor1;
  String _fotoProfessor2;
  String _fotoProfessor3;

  EscolinhaModel(this._id, this._nome, this._telefone, this._cidade, this._estado, this._pais,
      this._endereco, this._descricao, this._nomeResponsavel,
      this._nomeProfessor1, this._nomeProfessor2, this._nomeProfessor3,
      this._fotoResponsavel, this._fotoProfessor1, this._fotoProfessor2,
      this._fotoProfessor3);

  factory EscolinhaModel.fromJson(Map<String, dynamic> json) {
    return EscolinhaModel(
      json["id"],
      json["nome"],
      json["telefone"],
      json["cidade"],
      json["estado"],
      json["pais"],
      json["endereco"],
      json["descricao"],
      json["nomeResponsavel"],
      json["nomeProfessor1"],
      json["nomeProfessor2"],
      json["nomeProfessor3"],
      json["fotoResponsavel"],
      json["fotoProfessor1"],
      json["fotoProfessor2"],
      json["fotoProfessor3"],
    );
  }

  String get fotoProfessor3 => _fotoProfessor3;

  set fotoProfessor3(String value) {
    _fotoProfessor3 = value;
  }

  String get fotoProfessor2 => _fotoProfessor2;

  set fotoProfessor2(String value) {
    _fotoProfessor2 = value;
  }

  String get fotoProfessor1 => _fotoProfessor1;

  set fotoProfessor1(String value) {
    _fotoProfessor1 = value;
  }

  String get fotoResponsavel => _fotoResponsavel;

  set fotoResponsavel(String value) {
    _fotoResponsavel = value;
  }

  String get nomeProfessor3 => _nomeProfessor3;

  set nomeProfessor3(String value) {
    _nomeProfessor3 = value;
  }

  String get nomeProfessor2 => _nomeProfessor2;

  set nomeProfessor2(String value) {
    _nomeProfessor2 = value;
  }

  String get nomeProfessor1 => _nomeProfessor1;

  set nomeProfessor1(String value) {
    _nomeProfessor1 = value;
  }

  String get nomeResponsavel => _nomeResponsavel;

  set nomeResponsavel(String value) {
    _nomeResponsavel = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
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

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

}