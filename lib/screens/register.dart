import 'package:flutter/material.dart';
import 'package:new_id/models/response.dart';
import 'package:new_id/screens/TextFormFieldWithClearIcon.dart';
import 'package:new_id/screens/teenagerData.dart';
import 'package:new_id/service/request.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  bool _showClearIconName = false;
  bool _showClearIconCel = false;
  bool _showClearIconDate = false;
  bool _quiereMentorBool = false;
  bool _necesitaParqueaderoBool = false;

  Map<String, Object> registroFrom = Map();
  final HttpService httpService = HttpService();

  void _clearTextName() {
      setState(() {
        _nombreController.clear();
        _showClearIconName = false;
      });
  }

  void _clearTextCel() {
      setState(() {
        _celularController.clear();
        _showClearIconCel = false;
      });
  }

  void _clearTextDate() {
      setState(() {
        _fechaNacimientoController.clear();
        _showClearIconDate = false;
      });
  }

  @override
  void initState() {
    super.initState();
    _nombreController.addListener(() {
      setState(() {
        _showClearIconName = _nombreController.text.isNotEmpty;
      });
    });
    _celularController.addListener(() {
      setState(() {
        _showClearIconCel = _nombreController.text.isNotEmpty;
      });
    });
    _fechaNacimientoController.addListener(() {
      setState(() {
        _showClearIconDate = _nombreController.text.isNotEmpty;
      });
    });
  }

  String _selectedValueGender = 'Selecciona';
  String _selectedValueMentor = 'Selecciona';
  String _selectedValueParqueadero = 'Selecciona';
  String _selectedValueQuiereMentor = 'Selecciona';


  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _parkingController = TextEditingController();
  final TextEditingController _quiereMentorController = TextEditingController();
  final TextEditingController _mentorController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();


  final List<String> _dropdownItemsGender = [
    'Selecciona',
    'Hombre',
    'Mujer',
  ];

  final List<String> _dropdownItemsMentor = [
    'Selecciona',
    'Laura',
    'Yaung',
    'Briggite',
    'Jose',
    'Dani O',
    'Dani M',
    'Ana',
    'Diana M',
    'Diana V',
    'Lorena',
    'Nelson',
    'Andrea R',
    'Y Andrea',
    'Nohemi',
    'Andrea C',
    'Kathryn',
    'Juan S',
    'Mercy',
    'Abraham',
    'No tiene',
    'No desea'

    //TODO: completar
  ];

  final List<String> _dropdownItemsParqueadero = [
    'Selecciona',
    'Sí',
    'No'
  ];

  final List<String> _dropdownItemsQuiereMentor = [
    'Selecciona',
    'Sí',
    'No'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _fechaNacimientoController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
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
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/edit.png', height: 200, width: 150),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: TextFormField(
                                validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingresa un valor';
                                        }
                                        return null;
                                },
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  hintText: "Nombre completo*",
                                  suffixIcon: _showClearIconName
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: _clearTextName,
                                        )
                                      : null,
                                ),
                              ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: TextFormField(
                                validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingresa un valor';
                                        }
                                        return null;
                                },
                                controller: _celularController,
                                decoration: InputDecoration(
                                  hintText: "Celular*",
                                  suffixIcon: _showClearIconCel
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: _clearTextCel,
                                        )
                                      : null,
                                ),
                              ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa un valor';
                          }
                          return null;
                        },
                        controller: _fechaNacimientoController,
                        decoration: InputDecoration(
                          hintText: "Fecha*",
                          suffixIcon: _showClearIconDate
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _clearTextDate,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: '¿Requiere parqueadero?',
                          ),
                           validator: (value){
                            if(value == null || value.isEmpty || value.toString() == 'Selecciona'){
                              return 'Selecciona un valor';
                            }else{
                              return null;
                            }
                          },
                          value: _selectedValueParqueadero,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValueParqueadero = newValue!;
                              _parkingController.text = _selectedValueParqueadero; // Update the TextFormField
                            });
                          },
                          items: _dropdownItemsParqueadero.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: '¿Desea mentor?',
                          ),
                           validator: (value){
                            if(value == null || value.isEmpty || value.toString() == 'Selecciona'){
                              return 'Selecciona un valor';
                            }else{
                              return null;
                            }
                          },
                          value: _selectedValueQuiereMentor,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValueQuiereMentor = newValue!;
                              _quiereMentorController.text = _selectedValueQuiereMentor; // Update the TextFormField
                            });
                          },
                          items: _dropdownItemsQuiereMentor.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Género*',
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty || value.toString() == 'Selecciona'){
                              return 'Selecciona un género';
                            }else{
                              return null;
                            }
                          },
                          value: _selectedValueGender,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValueGender = newValue!;
                              _genderController.text = _selectedValueGender; // Update the TextFormField
                            });
                          },
                          items: _dropdownItemsGender.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Mentor*',
                          ),
                           validator: (value){
                            if(value == null || value.isEmpty || value.toString() == 'Selecciona'){
                              return 'Selecciona un valor';
                            }else{
                              return null;
                            }
                          },
                          value: _selectedValueMentor,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValueMentor = newValue!;
                              _mentorController.text = _selectedValueMentor; // Update the TextFormField
                            });
                          },
                          items: _dropdownItemsMentor.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                  
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Registrando...")));
                  
                        if(_quiereMentorController.text == "Sí"){
                          _quiereMentorBool = true;
                        }else{
                          _quiereMentorBool = false;
                        }
                         if(_parkingController.text == "Sí"){
                          _necesitaParqueaderoBool = true;
                        }else{
                          _necesitaParqueaderoBool = false;
                        }
                  
                        registroFrom.addEntries({'telefono': _celularController.text}.entries);
                        registroFrom.addEntries({'nombre': _nombreController.text}.entries);
                        registroFrom.addEntries({'fechaNacimiento': _fechaNacimientoController.text}.entries);
                        registroFrom.addEntries({'parqueadero': _necesitaParqueaderoBool}.entries);
                        registroFrom.addEntries({'tieneMentor': _quiereMentorBool}.entries);
                        registroFrom.addEntries({'genero': _genderController.text}.entries);
                        registroFrom.addEntries({'abreviaturaMentor': _mentorController.text}.entries);
                  
                        print(registroFrom);
                  
                        final Response response = await httpService.registroJoven(registroFrom);
                        if(response.exitoso){
                          _celularController.clear();
                          _nombreController.clear();
                          _fechaNacimientoController.clear();
                          _parkingController.clear();
                          _quiereMentorController.clear();
                          _genderController.clear();
                          _mentorController.clear();
                          _selectedValueGender = 'Selecciona';
                          _selectedValueMentor = 'Selecciona';
                          _selectedValueParqueadero = 'Selecciona';
                          _selectedValueQuiereMentor = 'Selecciona';
                  
                          showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 250,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('¡El joven ha sido registrado!'),
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
                              height: 250,
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
                  
                        }
                        
                      }
                    },
                    child: const Text('Registrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}