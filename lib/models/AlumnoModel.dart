class AlumnoModel {
  final String codigo;
  final String nombre;
  final String direccion;

  AlumnoModel({this.codigo, this.nombre, this.direccion});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "codigo": codigo,
      "nombre": nombre,
      "direccion": direccion,
    };
  }
}
