import 'package:flutter/material.dart';
import 'package:new_id/screens/attendance.dart';
import 'package:new_id/screens/home.dart';
import 'package:new_id/screens/register.dart';
import 'package:new_id/screens/searchForm.dart';
import 'package:new_id/screens/teenagerData.dart';


class Bottonnav extends StatefulWidget {
  const Bottonnav({super.key});
  
  @override
  BottonnavState  createState(){
    return BottonnavState();
  }
}

class BottonnavState extends State<Bottonnav> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Attendance(),
    Register(),
    SearchForm(),
    Text(
      'Ver todo',
    ),
    //home(),
];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
        child: _pages.elementAt(_selectedIndex),
        ) ,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white ,
          selectedItemColor: const Color(0xff20bdff),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Asistencia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.drive_file_rename_outline_sharp),
              label: 'Registro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Ver todo',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.logout),
            //   label: 'Salir',
            // ),
          ],
        ),
        ),
      );
  }
}