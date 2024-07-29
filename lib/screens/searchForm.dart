import 'package:flutter/material.dart';
import 'package:new_id/models/jovenData.dart';
import 'package:new_id/models/search.dart';
import 'package:new_id/screens/TextFormFieldWithClearIcon.dart';
import 'package:new_id/screens/teenagerData.dart';
import 'package:new_id/service/request.dart';


class SearchForm extends StatefulWidget {

  const SearchForm({super.key});

  
  
  @override
  MyCustomFormState  createState(){
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<SearchForm> {

  final _formKey = GlobalKey<FormState>();

final TextEditingController _nombreController = TextEditingController();
final TextEditingController _celularController = TextEditingController();
bool _showClearIconName = false;
bool _showClearIconCel = false;
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
                    Image.asset('assets/magnifier.png'),
                    //Search by celphone
                     Padding(
                      padding: EdgeInsets.fromLTRB(80,60,80,30),
                      child: TextFormField(
                                controller: _celularController,
                                decoration: InputDecoration(
                                  hintText: "Ingresa el número de celular",
                                  suffixIcon: _showClearIconCel
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: _clearTextCel,
                                        )
                                      : null,
                                ),
                              ),
                    ),
                    ElevatedButton(onPressed:() async {
                      if(_formKey.currentState!.validate()){

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Buscando...")),
                        );
                        Search search = new Search(telefono: _celularController.text, nombre: null);
                        print(search.toJson());
                        final JovenData? jovenData = await httpService.buscarJoven(search);
                        if(jovenData!= null){
                          if(jovenData.data.isNotEmpty){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> Teenagerdata(persons:jovenData.data)));
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
                                      const Text('¡El joven no se encuentra registrado!'),
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
                        
                      }
                    }, child: const Text('Buscar por celular')),
                    //Search by name
                    Padding(
                      padding: EdgeInsets.fromLTRB(80,0,80,30),
                      child:TextFormField(
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  hintText: "Ingresa el nombre",
                                  suffixIcon: _showClearIconName
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: _clearTextName,
                                        )
                                      : null,
                                ),
                              ),
                    ),
                    ElevatedButton(onPressed:() async {
                      if(_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Buscando...")),
                        );
                        Search search = Search(telefono: null, nombre: _nombreController.text);
                        print(search.toJson());
                        final JovenData? jovenData = await httpService.buscarJoven(search);
                        if(jovenData!= null){
                          if(jovenData.data.isNotEmpty){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>  Teenagerdata(persons:jovenData.data)));
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
                                      const Text('¡El joven no se encuentra registrado!'),
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
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("kk...")),
                        );
                      }
                    }, child: const Text('Buscar por nombre')),
                  ]   
                ),
              ),
              ),
    );
  }
}