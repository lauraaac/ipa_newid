import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:new_id/models/ingreso.dart';
import 'package:new_id/models/jovenData.dart';
import 'package:new_id/models/response.dart';
import 'package:new_id/models/search.dart';
import 'package:new_id/service/globals.dart';

class HttpService {

  Future<Ingreso> ingreso(Map<String, String> ingreso) async {
    
    var url = Uri.parse(baseURL+'/ingresar');
    var body  = json.encode(ingreso);
    http.Response response = await http.post(url, headers: httpHeaders, body: body);
    if (response.statusCode == 200) {
      Ingreso ans = Ingreso.fromJson(json.decode(response.body));
      return ans;
    }
    return Ingreso(exitoso: false);
  }

   Future<Response> registroAsistencia(String telefono) async {


    Map<String, String> queryParams = {
    'telefono': telefono,
    };
    Uri url = Uri.parse(baseURL+'/registrarAsistencia/'+telefono);

    http.Response response = await http.get(url, headers: httpHeaders);
    if (response.statusCode == 200) {
      Response ans = Response.fromJson(json.decode(response.body));
      return ans;
    }
    return Response(exitoso: false, data:"Error en el servicio");
  }

  Future<Response> registroJoven(Map<String, Object> registro) async {
    
    var url = Uri.parse(baseURL+'/registrarJoven');
    var body  = json.encode(registro);
    http.Response response = await http.post(url, headers: httpHeaders, body: body);
    if (response.statusCode == 200) {
      Response ans = Response.fromJson(json.decode(response.body));
      return ans;
    }
    return Response(exitoso: false, data:"Error en el servicio");
  }

  Future<JovenData?> buscarJoven(Search search) async {
    
    var url = Uri.parse(baseURL+'/buscar');
    var body  = json.encode(search);
    http.Response response = await http.post(url, headers: httpHeaders, body: body);
    if (response.statusCode == 200) {
      JovenData ans = JovenData.fromJson(json.decode(response.body));
      return ans;
    }
    return null;
  }
}