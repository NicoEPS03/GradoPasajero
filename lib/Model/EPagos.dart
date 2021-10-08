class EPagos{
  String fecha;
  String rutaId;
  String pasajeroId;
  int valor;

  EPagos({
    required this.fecha,
    required this.rutaId,
    required this.pasajeroId,
    required this.valor
  });

  Map<String, Object> toMap(){
    return {
      'fecha' : fecha,
      'rutaId' : rutaId,
      'pasajeroId' : pasajeroId,
      'valor' : valor
    };
  }

  static EPagos fromMap(Map value){
    return EPagos(
        fecha: value['fecha'],
        rutaId: value['rutaId'],
        pasajeroId: value['pasajeroId'],
        valor: value['valor']
    );
  }
}