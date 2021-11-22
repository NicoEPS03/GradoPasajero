class EHistorialTransfrencia{
  String fecha;
  String pasajeroOrigenId;
  String pasajeroDestinoId;
  int valor;

  EHistorialTransfrencia({
    required this.fecha,
    required this.pasajeroOrigenId,
    required this.pasajeroDestinoId,
    required this.valor
  });

  Map<String, Object> toMap(){
    return {
      'fecha' : fecha,
      'pasajeroOrigenId' : pasajeroOrigenId,
      'pasajeroDestinoId' : pasajeroDestinoId,
      'valor' : valor
    };
  }

  static EHistorialTransfrencia fromMap(Map value){
    return EHistorialTransfrencia(
        fecha: value['fecha'],
        pasajeroOrigenId: value['pasajeroOrigenId'],
        pasajeroDestinoId: value['pasajeroDestinoId'],
        valor: value['valor']
    );
  }
}