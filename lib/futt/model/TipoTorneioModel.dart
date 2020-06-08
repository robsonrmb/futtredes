class TipoTorneioModel {

  int _id;
  String _nome;
  String _descricao;
  String _geracaoJogos;

  TipoTorneioModel.Dropdown(this._id, this._nome);
  TipoTorneioModel(this._id, this._nome, this._descricao, this._geracaoJogos);

  factory TipoTorneioModel.fromJson(Map<String, dynamic> json) {
    return TipoTorneioModel(
      json["id"],
      json["nome"],
      json["descricao"],
      json["geracaoJogos"],
    );
  }

  @override
  String toString() => _nome;

  @override
  operator ==(o) => o is TipoTorneioModel && o.id == id;

  @override
  int get hashCode => id.hashCode^nome.hashCode;

  String get geracaoJogos => _geracaoJogos;

  set geracaoJogos(String value) {
    _geracaoJogos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
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