class ClassificacaoTorneioModel {

  int _id;
  String _nome;
  String _descricao;

  ClassificacaoTorneioModel(this._id, this._nome, this._descricao);

  ClassificacaoTorneioModel.Dropdown(this._id, this._nome);

  factory ClassificacaoTorneioModel.fromJson(Map<String, dynamic> json) {
    return ClassificacaoTorneioModel(
      json["id"],
      json["nome"],
      json["descricao"],
    );
  }

  @override
  String toString() => _nome;

  @override
  operator ==(o) => o is ClassificacaoTorneioModel && o.id == id;

  @override
  int get hashCode => id.hashCode^nome.hashCode;

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