class RankingEntidadeModel {
  int _id;
  String _nome;
  String _descricao;

  RankingEntidadeModel(this._id, this._nome, this._descricao);
  RankingEntidadeModel.Dropdown(this._id, this._descricao);

  factory RankingEntidadeModel.fromJson(Map<String, dynamic> json) {
    return RankingEntidadeModel(
      json["id"],
      json["nome"],
      json["descricao"],
    );
  }

  @override
  String toString() => _descricao;

  @override
  operator ==(o) => o is RankingEntidadeModel && o.id == id;

  @override
  int get hashCode => id.hashCode^descricao.hashCode;

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