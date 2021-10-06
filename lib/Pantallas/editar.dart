import 'package:sqllite_project/modelos/mensajeros.dart';
import 'package:sqllite_project/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';

class ModificarMensajero extends StatefulWidget {
  final Mensajero perfil;
  const ModificarMensajero({required this.perfil, key}): super(key: key);
  _ModificarMensajeroState createState() => _ModificarMensajeroState();
}

class _ModificarMensajeroState extends State<ModificarMensajero> {
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
  void initState() {
    controlNombre = TextEditingController(text: widget.perfil.nombre);
    controlfoto = TextEditingController(text: widget.perfil.foto);
    controlplaca = TextEditingController(text: widget.perfil.placa);
    controltelefono = TextEditingController(text: widget.perfil.telefono);
    controlwhatsapp = TextEditingController(text: widget.perfil.whatsapp);
    controlmoto = TextEditingController(text: widget.perfil.moto);

    soat = widget.perfil.soat == 'SI';
    tecno = widget.perfil.tecno == 'SI';
    activo = widget.perfil.activo == 'SI';

    super.initState();
  }

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
              ),
              TextField(
                controller: controlwhatsapp,
                decoration: const InputDecoration(labelText: "WhatsApp"),
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
                child: const Text("Modificar Mensajero"),
                onPressed: () {

                  var mensajero = Mensajero(id: widget.perfil.id,
                      nombre: controlNombre.text,
                      foto: controlfoto.text,
                      placa: controlplaca.text,
                      telefono: controltelefono.text,
                      whatsapp: controlwhatsapp.text,
                      moto: controlmoto.text,
                      soat: soat ? "SI" : "NO",
                      tecno: tecno ? "SI" : "NO",
                      activo: activo ? "SI" : "NO");
                  MensajerosCRUD.actualizarMensajero(mensajero);
                  Navigator.pop(context, mensajero);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
