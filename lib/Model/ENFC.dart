class ENFC{
  bool bloqueo;
  String codigo;
  bool estado;
  String mac;
  String usuarioId;

  ENFC({
    required this.bloqueo,
    required this.codigo,
    required this.estado,
    required this.mac,
    required this.usuarioId
  });

  Map<String, Object> toMap(){
    return {
      'bloqueo' : bloqueo,
      'codigo' : codigo,
      'estado' : estado,
      'mac' : mac,
      'usuarioId' : usuarioId
    };
  }

  static ENFC fromMap(Map value){
    return ENFC(
        bloqueo: value['bloqueo'],
        codigo: value['codigo'],
        estado: value['estado'],
        mac: value['mac'],
        usuarioId: value['usuarioId']
    );
  }
}