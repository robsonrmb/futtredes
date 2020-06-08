class PaisModel {

  String _id;
  String _nome;

  PaisModel(this._id, this._nome);

  factory PaisModel.fromJson(Map<String, dynamic> json) {
    return PaisModel(
      json["id"],
      json["nome"],
    );
  }

  @override
  String toString() => _nome;

  @override
  operator ==(o) => o is PaisModel && o.id == id;

  @override
  int get hashCode => id.hashCode^nome.hashCode;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}