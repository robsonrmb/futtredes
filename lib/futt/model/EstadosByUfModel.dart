class EstadosByUFModel {
  int? id;
  String? sigla;
  String? nome;

  EstadosByUFModel({this.sigla,this.id, this.nome});

  factory EstadosByUFModel.fromJson(Map<String, dynamic> json) {
    return EstadosByUFModel(
      sigla: json['sigla'],
      id: json['id'],
      nome: json['nome'],
    );
  }
}
