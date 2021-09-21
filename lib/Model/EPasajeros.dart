class EPasajeros {
  late String nombre;
  late String apellido;
  late String telefono;
  late String tipo_documento;
  late String num_documento;
  late String correo;
  late String clave;
  late int saldo;
  late String id_NFC;
  late bool estado_cuenta;
  late bool confirmacion_correo;

  EPasajeros (String nombre, String apellido, String telefono,
      String tipo_documento, String num_documento, String correo,
      String clave, int saldo, String id_NFC, bool estado_cuenta,
      bool confirmacion_correo){
    this.nombre = nombre;
    this.apellido = apellido;
    this.telefono = telefono;
    this.tipo_documento = tipo_documento;
    this.num_documento = num_documento;
    this.correo = correo;
    this.clave = clave;
    this.saldo = saldo;
    this.id_NFC = id_NFC;
    this.estado_cuenta = estado_cuenta;
    this.confirmacion_correo = confirmacion_correo;
  }
}