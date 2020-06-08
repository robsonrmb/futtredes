class EntidadeModel {
  int _id;
  String _nome;
  String _sigla;
  int _tipo;
  String _website;
  String _status;
  DateTime _disponibilidade;
  int _idResponsavelEntidade;
  int _idSubresponsavel1;
  int _idSubresponsavel2;
  int _idSubresponsavel3;

  EntidadeModel(this._id, this._nome, this._sigla, this._tipo, this._website,
      this._status, this._disponibilidade, this._idResponsavelEntidade,
      this._idSubresponsavel1, this._idSubresponsavel2, this._idSubresponsavel3);

  factory EntidadeModel.fromJson(Map<String, dynamic> json) {
    return EntidadeModel(
      json["id"],
      json["nome"],
      json["sigla"],
      json["tipo"],
      json["website"],
      json["status"],
      json["disponibilidade"],
      json["idResponsavelEntidade"],
      json["idSubresponsavel1"],
      json["idSubresponsavel2"],
      json["idSubresponsavel3"],
    );
  }

  @override
  String toString() => _nome;

  @override
  operator ==(o) => o is EntidadeModel && o.id == id;

  @override
  int get hashCode => id.hashCode^nome.hashCode;

  int get idSubresponsavel3 => _idSubresponsavel3;

  set idSubresponsavel3(int value) {
    _idSubresponsavel3 = value;
  }

  int get idSubresponsavel2 => _idSubresponsavel2;

  set idSubresponsavel2(int value) {
    _idSubresponsavel2 = value;
  }

  int get idSubresponsavel1 => _idSubresponsavel1;

  set idSubresponsavel1(int value) {
    _idSubresponsavel1 = value;
  }

  int get idResponsavelEntidade => _idResponsavelEntidade;

  set idResponsavelEntidade(int value) {
    _idResponsavelEntidade = value;
  }

  DateTime get disponibilidade => _disponibilidade;

  set disponibilidade(DateTime value) {
    _disponibilidade = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get website => _website;

  set website(String value) {
    _website = value;
  }

  int get tipo => _tipo;

  set tipo(int value) {
    _tipo = value;
  }

  String get sigla => _sigla;

  set sigla(String value) {
    _sigla = value;
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