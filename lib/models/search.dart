class Search {

  late String? telefono;
  late String? nombre;



  Search(
      { this.telefono,
       this.nombre
      })
      : super();

  Search.fromJson(dynamic json) {
    telefono = json['telefono'];
    nombre = json['nombre'];
    
  }

  Map<String, dynamic> toJson() {
    return {
      'telefono': telefono,
      'nombre': nombre,
    };
  }
}