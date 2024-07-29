import 'package:flutter/foundation.dart';

class Ingreso {

  late bool exitoso;



  Ingreso(
      {required this.exitoso,
      })
      : super();

  Ingreso.fromJson(dynamic json) {
    exitoso = json['exitoso'];
    
  }
}
