class PaisesModel {
  String? codigo;
  String? texto;

  PaisesModel({this.codigo,this.texto});

  factory PaisesModel.fromJson(Map<String, dynamic> json) {
    return PaisesModel(
      codigo: json["codigo"],
      texto: json["texto"],
    );
  }

}