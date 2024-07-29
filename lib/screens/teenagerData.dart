import 'package:flutter/material.dart';
import 'package:new_id/models/jovenData.dart';

class Teenagerdata extends StatelessWidget {
  final List<UserData> persons;

  const Teenagerdata({required this.persons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          final person = persons[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: null ,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        person.nombre,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Celular: ${person.telefono}', style: const TextStyle(fontSize: 16)),
                  Text('Edad: ${person.edad ?? 'Sin datos'}', style: const TextStyle(fontSize: 16)),                 
                  Text('Fecha de nacimiento: ${person.fechaNacimientoString  ?? 'Sin datos'}', style: const TextStyle(fontSize: 16)),
                  Text('Requiere parqueadero: ${person.parqueadero == true ? 'Si' : 'No'}', style: const TextStyle(fontSize: 16)),
                  Text('Tiene mentor: ${person.tieneMentor == true ? 'Si' : 'No'}', style: const TextStyle(fontSize: 16)),
                  Text('Grupo de edad: ${person.grupoEdad ?? 'Sin datos'}', style:const  TextStyle(fontSize: 16)),
                  Text('Asistencias: ${person.asistencias}', style: const TextStyle(fontSize: 16)),
                  Text('Género: ${person.genero}', style: const TextStyle(fontSize: 16)),
                  Text('Mentor: ${person.abreviaturaMentor ?? 'Sin datos'}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}