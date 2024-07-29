import 'package:flutter/material.dart';
import 'package:new_id/models/ingreso.dart';
import 'package:new_id/models/response.dart';
import 'package:new_id/screens/TextFormFieldWithClearIcon.dart';
import 'package:new_id/screens/teenagerData.dart';
import 'package:new_id/service/request.dart';


class Attendance extends StatefulWidget {

  const Attendance({super.key});

  
  
  @override
  AttendanceState  createState(){
    return AttendanceState();
  }
}

class AttendanceState extends State<Attendance> {

  final _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  final TextEditingController _attendanceController = TextEditingController();
  bool _showClearIcon = false;


  void _clearText() {
      setState(() {
        _attendanceController.clear();
        _showClearIcon = false;
      });
  }

  @override
  void initState() {
    super.initState();
    _attendanceController.addListener(() {
      setState(() {
        _showClearIcon = _attendanceController.text.isNotEmpty;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff5433ff), Color(0xff20bdff), Color(0xffa5fecb)],
                    stops: [0, 0.5, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                ),
                child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/immigration.png', height: 200, width: 150,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80,20,80,30),
                      child: TextFormField(
                                validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingresa un valor';
                                        }
                                        return null;
                                },
                                controller: _attendanceController,
                                decoration: InputDecoration(
                                  hintText: "Telefono",
                                  suffixIcon: _showClearIcon
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: _clearText,
                                        )
                                      : null,
                                ),
                              ),
                    ),
                    ElevatedButton(onPressed:() async {
                      if(_formKey.currentState!.validate()){

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Registrando asistencia..."),
                                      duration: Duration(seconds: 2)),
                                  );

                                  final Response response = await httpService.registroAsistencia(_attendanceController.text);
                                  if(response.exitoso){
                                   
                                    _attendanceController.clear();
                                    showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 200,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(response.data),
                                              const Text(' '),
                                              ElevatedButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }else{

                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 200,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('El joven no se encuentra en la base de datos'),
                                              const Text(' '),
                                              ElevatedButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                  
                      }
                    }, child: const Text('Ingresar asistencia')),
                  ]   
                ),
              ),
              ),
    );
  }
}