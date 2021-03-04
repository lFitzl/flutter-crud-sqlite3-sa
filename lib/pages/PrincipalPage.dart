import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senati_apps/helpers/responsive.dart';
import 'package:senati_apps/pages/PrincipalPageViewModel.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PrincipalPageViewModel(),
        ),
      ],
      child: PrincipalPageBase(),
    );
  }
}

//Vista de los pedidos del cliente
class PrincipalPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PrincipalPageViewModel>(context);
    var alumnos = viewModel.alumnos;
    return Scaffold(
      // backgroundColor: Color(0xFF2B2B2B),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: hp(5),
            ),
            Center(
              child: Text('CRUD ALUMNOS'),
            ),
            InputFormField(
                hint: 'CÓDIGO', controller: viewModel.codigoController),
            SizedBox(
              height: hp(3),
            ),
            InputFormField(
                hint: 'NOMBRE', controller: viewModel.nombreController),
            SizedBox(
              height: hp(3),
            ),
            InputFormField(
                hint: 'DIRECCIÓN', controller: viewModel.direccionController),
            SizedBox(
              height: hp(3),
            ),
            Button(
              text: 'Agregar',
              func: viewModel.addAlumno,
              disabled: viewModel.codigoSelected != "",
            ),
            Button(
                text: 'Editar',
                func: viewModel.updateAlumno,
                disabled: viewModel.codigoSelected == ""),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewModel.alumnos.length,
                itemBuilder: (context, index) {
                  print(alumnos[index].codigo);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                            '${alumnos[index].codigo} - ${alumnos[index].nombre} - ${alumnos[index].direccion}'),
                      ),
                      Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () => {
                                    viewModel
                                        .deleteAlumno(alumnos[index].codigo)
                                  })),
                      Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.edit,
                              ),
                              onPressed: () =>
                                  {viewModel.selectToEdit(alumnos[index])})),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  //Generador de los pedidos del cliente

}

class InputFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const InputFormField({
    Key key,
    @required this.controller,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wp(50),
      height: hp(5),
      child: TextFormField(
        decoration:
            InputDecoration(hintText: hint, hintStyle: TextStyle(fontSize: 12)),
        controller: controller,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Function func;
  final bool disabled;

  const Button({
    Key key,
    @required this.text,
    @required this.func,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: wp(50),
      height: hp(5),
      buttonColor: Color(0xFF5A81FB),
      child: RaisedButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Color(0xFF5A81FB),
        elevation: 2,
        textColor: Colors.white,
        onPressed: disabled ? null : func,
        padding: EdgeInsets.symmetric(vertical: hp(1.2)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(40.0),
          side: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
