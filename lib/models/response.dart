import 'package:flutter/foundation.dart';

class Response {

  late bool exitoso;

  late String data;


  Response(
      {required this.exitoso,
        required this.data,
      })
      : super();

  Response.fromJson(dynamic json) {
    exitoso = json['exitoso'];
    data = json['data'];
    
  }
}
