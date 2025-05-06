class Weather{
  final String nombreCiudad;
  final double temperatura;
  final String condicionPrincipal;

  Weather({
    required this.nombreCiudad,
    required this.temperatura,
    required this.condicionPrincipal,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(nombreCiudad: json['name'], 
    temperatura: json['main']['temp'].toDouble(), 
    condicionPrincipal: json['weather'][0]['main'],
    );
  }
}