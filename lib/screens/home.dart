import 'package:flutter/material.dart';
import 'package:new_id/models/ingreso.dart';
import 'package:new_id/screens/TextFormFieldWithClearIcon.dart';
import 'package:new_id/screens/searchForm.dart';
import 'package:new_id/screens/bottonNav.dart';
import 'package:new_id/service/request.dart';


class home extends StatefulWidget {
  const home({super.key});
  
  @override
  homeState  createState(){
    return homeState();
  }
}

class homeState extends State<home> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;  
  Map<String, String> ingresoForm = Map();
  final HttpService httpService = HttpService();


  @override
  Widget build(BuildContext context) {

   return Container(
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
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Image.asset(
            'assets/logoMinis.png', 
            width: 300,
            height: 150,),
           Padding(
            padding: EdgeInsets.fromLTRB(80,80,80,30),
            child: TextField( 
              controller: _passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                     icon: Icon(passwordVisible
                         ? Icons.visibility_off
                         : Icons.visibility),
                     onPressed: () {
                       setState(
                         () {
                           passwordVisible = !passwordVisible;
                         },
                       );
                     },
                   ),
              ),
            )
          ),
          ElevatedButton(onPressed:() async {
            if(_formKey.currentState!.validate()){
              if(_passwordController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ingresa lo datos")),
              );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Buscando...")),
              );
              ingresoForm.addEntries({'password':_passwordController.text}.entries);
              final Ingreso ingreso = await httpService.ingreso(ingresoForm);
              if(ingreso.exitoso){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> const Bottonnav()));
                _passwordController.clear();
             }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Dato incorrecto. Intenta de nuevo")),
              );
               _passwordController.clear();
              }          
             }
              
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Completa la información")),
              );

            }
          }, child: const Text('Ingresar')),
        ]
        
      ),
    ),
    );
    
  }


}