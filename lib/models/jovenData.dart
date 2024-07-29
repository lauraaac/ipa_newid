class JovenData {

  final List<UserData> data;
  final bool exitoso;

  JovenData({required this.data, required this.exitoso});

  factory JovenData.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<UserData> data = dataList.map((i) => UserData.fromJson(i)).toList();

    return JovenData(
      data: data,
      exitoso: json['exitoso'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((v) => v.toJson()).toList(),
      'exitoso': exitoso,
    };
  }
}

class UserData {
  final String telefono;
  final String nombre;
  final String? fechaNacimiento;
  final bool? parqueadero;
  final bool? tieneMentor;
  final int? idMentor;
  final int? idGrupoEdad;
  final int asistencias;
  final String genero;
  final String? abreviaturaMentor;
  final String? grupoEdad;
  final int? edad;
  final String? fechaNacimientoString;
  //final String profilePictureUrl = "";

  UserData({
    required this.telefono,
    required this.nombre,
    this.fechaNacimiento,
    this.parqueadero,
    this.tieneMentor,
    this.idMentor,
    this.idGrupoEdad,
    required this.asistencias,
    required this.genero,
    this.abreviaturaMentor,
    this.edad,
    this.grupoEdad,
    this.fechaNacimientoString
    //required this.profilePictureUrl
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      telefono: json['telefono'],
      nombre: json['nombre'],
      fechaNacimiento: json['fechaNacimiento'],
      parqueadero: json['parqueadero'],
      tieneMentor: json['tieneMentor'],
      idMentor: json['idMentor'],
      idGrupoEdad: json['idGrupoEdad'],
      asistencias: json['asistencias'],
      genero: json['genero'],
      abreviaturaMentor: json['abreviaturaMentor'],
      edad: json['edad'],
      grupoEdad: json['grupoEdad'],
      fechaNacimientoString: json['fechaNacimientoString']
      //profilePictureUrl: json['profilePictureUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'telefono': telefono,
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento,
      'parqueadero': parqueadero,
      'tieneMentor': tieneMentor,
      'idMentor': idMentor,
      'idGrupoEdad': idGrupoEdad,
      'asistencias': asistencias,
      'genero': genero,
      'abreviaturaMentor': abreviaturaMentor,
      'edad':edad,
      'grupoEdad':grupoEdad,
      'fechaNacimientoString': fechaNacimientoString,
    };
  }
}