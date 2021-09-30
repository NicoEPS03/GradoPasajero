class EPasajeros {
  String nombre;
  String apellido;
  String telefono;
  String tipo_documento;
  String num_documento;
  String correo;
  String clave;
  int saldo;
  String id_NFC;
  bool estado_cuenta;

  EPasajeros({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this. tipo_documento,
    required this.num_documento,
    required this.correo,
    required this.clave,
    required this.saldo,
    required this.id_NFC,
    required this.estado_cuenta
  });

  Map<String, Object> toMap(){
    return {
      'nombre' : nombre,
      'apellido' : apellido,
      'telefono' : telefono,
      'tipo_documento' : tipo_documento,
      'num_documento' : num_documento,
      'correo' : correo,
      'clave' : clave,
      'saldo' : saldo,
      'id_NFC' : id_NFC,
      'estado_cuenta' : estado_cuenta
    };
  }

  static EPasajeros fromMap(Map value){
    return EPasajeros(
        nombre: value['nombre'],
        apellido: value['apellido'],
        telefono: value['telefono'],
        tipo_documento: value['tipo_documento'],
        num_documento: value['num_documento'],
        correo: value['correo'],
        clave: value['clave'],
        saldo: value['saldo'],
        id_NFC: value['id_NFC'],
        estado_cuenta: value['estado_cuenta']
    );
  }
}