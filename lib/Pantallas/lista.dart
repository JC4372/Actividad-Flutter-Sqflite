import 'package:sqllite_project/Pantallas/perfil.dart';
import 'package:sqllite_project/modelos/mensajeros.dart';
import 'package:sqllite_project/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';
import 'adicionar.dart';

class ListaMensajeros extends StatefulWidget {
  ListaMensajeros({required this.title});
  final String title;

  @override
  _ListaMensajerosState createState() => _ListaMensajerosState();
}

class _ListaMensajerosState extends State<ListaMensajeros> {
  List<Mensajero> _listamensajeros = [];
  bool _cargando = true;

  void _listarmensajero() async {
    final data = await MensajerosCRUD.listarMensajeros();
    setState(() {
      _listamensajeros = data;
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _listarmensajero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listados Mensajeros'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Mensajero',
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AgregarMensajero()))
                    .then((value) {
                        setState(() {
                        _listarmensajero();
                    });
                });
            })
        ],
      ),
      body: _cargando ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
              itemCount: _listamensajeros.length,
              itemBuilder: (context, posicion) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                        Perfilmensajero(perfil: _listamensajeros[posicion])))
                        .then((value) {
                            setState(() {
                              _listarmensajero();
                          });
                    });
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(5.0),
                    width: 50,
                    height: 50,
                    child: CircleAvatar(backgroundImage: _listamensajeros[posicion].foto.isNotEmpty ? NetworkImage(_listamensajeros[posicion].foto) : null,),
                  ),
                  title: Text(_listamensajeros[posicion].nombre),
                  subtitle: Text(_listamensajeros[posicion].moto),
                  trailing: Container(
                    width: 80,
                    height: 40,
                    color: Colors.yellowAccent,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(_listamensajeros[posicion].placa),
                  ),
                );
              }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _listarmensajero();
            // getInfo(context);
          });
        },
        tooltip: 'Refrescar',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


/*

Widget getInfo(BuildContext context) {
  return FutureBuilder(
    future: listarPost(http
        .Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? Vistamensajeros(mensajeros: snapshot.data)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class Vistamensajeros extends StatelessWidget {
  final List<Mensajero> mensajeros;

  const Vistamensajeros({required this.mensajeros});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mensajeros.length == 0 ? 0 : mensajeros.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Perfilmensajero(
                          perfil: mensajeros, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: Image.network(mensajeros[posicion].foto),
            ),
            title: Text(mensajeros[posicion].nombre),
            subtitle: Text(mensajeros[posicion].moto),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(mensajeros[posicion].placa),
            ),
          );
        });
  }
}

*/