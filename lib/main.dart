import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_id/screens/home.dart';
import 'package:new_id/models/mysql.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = MySql();


  @override
  Widget build(BuildContext context) {
    const appTitle = 'Base de datos NewID';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.blue, // Color de fondo del AppBar
          elevation: 10, // Sombra del AppBar
          titleTextStyle: TextStyle(
            color: Colors.white, // Color del texto del título
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // Color de los iconos (como el botón de atrás)
        ),
      ),
      home: const Scaffold(
        body: home(),
      ),
    );
  }
}

