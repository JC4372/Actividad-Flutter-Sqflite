import 'package:sqllite_project/modelos/mensajeros.dart';
import 'package:sqllite_project/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';
import 'editar.dart';

class Perfilmensajero extends StatefulWidget {

  Mensajero perfil;
  Perfilmensajero({required this.perfil});

  @override
  _Perfilmensajero createState() => _Perfilmensajero();
}

class _Perfilmensajero extends State<Perfilmensajero> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil Mensajero'),
          actions: [
            IconButton(
                tooltip: 'Editar Mensajero',
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  var data = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                      ModificarMensajero(perfil: widget.perfil))) as Mensajero?;
                  if(data != null) {
                    setState(() {
                      widget.perfil = data;
                    });
                  }
                }),
            IconButton(
                tooltip: 'Eliminar Mensajero',
                icon: const Icon(Icons.delete),
                onPressed: () {
                  confirmaeliminar();
                })
          ],
        ),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(backgroundImage: widget.perfil.foto.isNotEmpty ? NetworkImage(widget.perfil.foto) : null, ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                widget.perfil.nombre,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(widget.perfil.moto),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Calificaciones'),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text('SOAT'),
                                      CircleAvatar(
                                        child: Text(widget.perfil.soat),
                                        backgroundColor: widget.perfil.soat == 'NO' ? Colors.red : Colors.green,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('TECNOMECANICA'),
                                      CircleAvatar(
                                        child: Text(widget.perfil.tecno),
                                        backgroundColor: widget.perfil.tecno == 'NO' ? Colors.red : Colors.green,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('ACTIVO'),
                                      CircleAvatar(
                                        child: Text(widget.perfil.activo),
                                        backgroundColor: widget.perfil.activo == 'NO' ? Colors.red : Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Descripcion:'),
                              const Text('Mensajero las 24 Horas'),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                              const Text('Verificar Placa:'),
                              const SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.yellowAccent,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(widget.perfil.placa, style: const TextStyle(fontSize: 20),),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'))
        ]),
      ),
    );
  }

  void confirmaeliminar() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Realmente Desea Eliminar?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Icon(Icons.cancel),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Icon(Icons.check_circle),
              onPressed: () {
                MensajerosCRUD.eliminarMensajero(widget.perfil.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}
