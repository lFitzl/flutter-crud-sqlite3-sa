import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:senati_apps/pages/PrincipalPage.dart';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SENATI APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrincipalPage(),
    );
  }
}

/*

  final newalumno = AlumnoModel(
    codigo: alumno.codigo,
    nombre: 'Alumno 1 modificado',
    direccion: alumno.direccion,
  );

 */
