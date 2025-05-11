class Movement {
  final int movmientoId;
  final int usuarioId;
  final String nombre;
  final String password;
  final DateTime fechaRegistro;

  Movement({
    required this.password,
    required this.fechaRegistro,
    required this.movmientoId,
    required this.usuarioId,
    required this.nombre,
  });

  factory Movement.fromJsonMap(Map<String, dynamic> json) => Movement(
    movmientoId: json["movmiento_id"],
    usuarioId: json["usuario_id"],
    nombre: json["nombre"],
    password: json["password"],
    fechaRegistro: DateTime.parse(json["fecha_registro"]),
  );
}
