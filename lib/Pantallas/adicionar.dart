import 'package:sqllite_project/modelos/mensajeros.dart';
import 'package:sqllite_project/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';

class AgregarMensajero extends StatefulWidget {
  const AgregarMensajero({Key? key}) : super(key: key);

  @override
  _AgregarMensajeroState createState() => _AgregarMensajeroState();
}

class _AgregarMensajeroState extends State<AgregarMensajero> {
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlfoto = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlwhatsapp = TextEditingController();
  TextEditingController controlmoto = TextEditingController();
  bool soat = false;
  bool tecno = false;
  bool activo = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Mensajero"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controlNombre,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlfoto,
                decoration: const InputDecoration(labelText: "Foto"),
              ),
              TextField(
                controller: controlplaca,
                decoration: const InputDecoration(labelText: "Placa"),
              ),
              TextField(
                controller: controltelefono,
                decoration: const InputDecoration(labelText: "Telefono"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: controlwhatsapp,
                decoration: const InputDecoration(labelText: "WhatsApp"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: controlmoto,
                decoration: const InputDecoration(labelText: "Moto"),
              ),
              SwitchListTile(
                title: const Text('Soat Vigente?'),
                value: soat,
                onChanged: (bool value) {
                  setState(() {
                    soat = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Tecnomecanica Vigente?'),
                value: tecno,
                onChanged: (bool value) {
                  setState(() {
                    tecno = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Activo ?'),
                value: activo,
                onChanged: (bool value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
              ElevatedButton(
                child: const Text("Adicionar Mensajero"),
                onPressed: () {

                  var mensajero = Mensajero(
                      nombre: controlNombre.text,
                      foto: controlfoto.text,
                      placa: controlplaca.text,
                      telefono: controltelefono.text,
                      whatsapp: controlwhatsapp.text,
                      moto: controlmoto.text,
                      soat: soat ? "SI" : "NO",
                      tecno: tecno ? "SI" : "NO",
                      activo: activo ? "SI" : "NO"
                  );

                  MensajerosCRUD.guardarMensajero(mensajero);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
