import 'package:flutter/cupertino.dart';
import 'package:senati_apps/models/AlumnoModel.dart';
import 'package:senati_apps/services/db_service.dart';

class PrincipalPageViewModel extends ChangeNotifier {
  String codigoSelected = "";

  final _codigoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();

  TextEditingController get codigoController => _codigoController;
  TextEditingController get nombreController => _nombreController;
  TextEditingController get direccionController => _direccionController;

  PrincipalPageViewModel() {
    getAlumnos();
  }

  List<AlumnoModel> alumnos = [];

  getAlumnos() async {
    WidgetsFlutterBinding.ensureInitialized();
    DbProvider alumnoDb = DbProvider();

    var resp = await alumnoDb.getAlumnos();
    alumnos = resp;
    notifyListeners();
  }

  void selectToEdit(AlumnoModel alumno) async {
    codigoSelected = alumno.codigo;

    _codigoController.text = alumno.codigo;
    _nombreController.text = alumno.nombre;
    _direccionController.text = alumno.direccion;

    notifyListeners();
  }

  void addAlumno() async {
    WidgetsFlutterBinding.ensureInitialized();
    DbProvider alumnoDb = DbProvider();
    var alumno = AlumnoModel(
        codigo: _codigoController.text,
        direccion: _direccionController.text,
        nombre: nombreController.text);
    await alumnoDb.addAlumno(alumno);

    resetForm();
    return getAlumnos();
  }

  void updateAlumno() async {
    DbProvider alumnoDb = DbProvider();
    var newAlumno = AlumnoModel(
        codigo: _codigoController.text,
        direccion: _direccionController.text,
        nombre: nombreController.text);

    await alumnoDb.updateAlumnos(codigoSelected, newAlumno);
    resetForm();
    return getAlumnos();
  }

  void deleteAlumno(String codigo) async {
    DbProvider alumnoDb = DbProvider();

    await alumnoDb.deleteAlumno(codigo);
    resetForm();
    return getAlumnos();
  }

  void resetForm() {
    codigoSelected = "";

    _codigoController.text = "";
    _nombreController.text = "";
    _direccionController.text = "";
  }
}

// String _codigo;
// String _nombre;
// String _direccion;

// String get codigo => _codigo;
// String get nombre => _nombre;
// String get direccion => _direccion;
