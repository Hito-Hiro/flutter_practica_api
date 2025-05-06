import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practica_api/models/weather_model.dart';
import 'package:practica_api/services/weather_services.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{

  //Api key

  final _WeatherServices = WeatherServices('c1e666a4b8f6eaa113025bf61459fe50');
  Weather? _weather;

  //Clima
  _fetchWeather() async{

    //Obtener la ciudad actual
    String nombreCiudad = await _WeatherServices.GetCurrentWeather();

    //Obtener el clima de la ciudad
    try{
      final weather = await _WeatherServices.getWeather(nombreCiudad);
      setState(() {
        _weather = weather;
      });
    }

    //por errores
    catch(e){
      print(e);
    }
  }

  //Animaciones
  String GetWeatherAnimation(String? condicionPrincipal){
    if(condicionPrincipal == null) return 'assets/sunny.json';

    switch (condicionPrincipal.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          //nombre de la ciudad
          Text(_weather?.nombreCiudad ?? 'Cargando ciudad...', style: TextStyle(fontSize: 28,),),

          //animaciones
          Lottie.asset(GetWeatherAnimation(_weather?.condicionPrincipal)),

          //temperatura
          Text('${_weather?.temperatura.round()}°C', style: TextStyle(fontSize: 24),),

          //descripción clima
          Text(_weather?.condicionPrincipal ?? "", style: TextStyle(fontSize: 24),),
        ],
        ),
      ),
    );
  }

}