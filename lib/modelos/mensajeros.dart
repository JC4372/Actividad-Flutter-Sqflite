class Mensajero {
  int id;
  String nombre;
  String foto;
  String placa;
  String telefono;
  String whatsapp;
  String moto;
  String soat;
  String tecno;
  String activo;

  Mensajero({this.id = 0,
    required this.nombre,
    required this.foto,
    required this.placa,
    required this.telefono,
    required this.whatsapp,
    required this.moto,
    required this.soat,
    required this.tecno,
    required this.activo,
  });

  factory Mensajero.fromJson(Map<String, dynamic> json) {
    return Mensajero(
      id: json['id'],
      nombre: json['nombre'],
      foto: json['foto'],
      placa: json['placa'],
      telefono: json['telefono'],
      whatsapp: json['whatsapp'],
      moto: json['moto'],
      soat: json['soat'],
      tecno: json['tecno'],
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'foto': foto,
      'placa': placa,
      'telefono': telefono,
      'whatsapp': whatsapp,
      'moto': moto,
      'soat': soat,
      'tecno': tecno,
      'activo': activo
    };
  }
}
